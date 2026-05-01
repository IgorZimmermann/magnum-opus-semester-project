import https from "https";
import fs from "fs";
import path from "path";

import 'dotenv/config'

// ─── Config ───────────────────────────────────────────────────────────────────

const GITHUB_TOKEN = process.env.GITHUB_TOKEN ?? "";
const REPO_OWNER = process.env.REPO_OWNER ?? "your-org";
const REPO_NAME = process.env.REPO_NAME ?? "your-repo";
const JIRA_BASE_URL = process.env.JIRA_BASE_URL ?? ""; // e.g. https://your-org.atlassian.net
const JIRA_EMAIL = process.env.JIRA_EMAIL ?? "";
const JIRA_TOKEN = process.env.JIRA_TOKEN ?? "";
const OUTPUT_DIR = process.env.OUTPUT_DIR ?? "./output";

for (const [name, val] of Object.entries({ GITHUB_TOKEN, JIRA_BASE_URL, JIRA_EMAIL, JIRA_TOKEN })) {
	if (!val) { console.error(`Error: ${name} environment variable is required.`); process.exit(1); }
}

// ─── Types ────────────────────────────────────────────────────────────────────

interface PullRequest {
	number: number;
	title: string;
	state: "open" | "closed";
	user: { login: string };
	created_at: string;
	merged_at: string | null;
	base: { ref: string };
	head: { ref: string };
	html_url: string;
	draft: boolean;
	labels: { name: string }[];
	body: string | null;
}

interface GitHubReview {
	user: { login: string };
	state: "APPROVED" | "CHANGES_REQUESTED" | "COMMENTED" | "DISMISSED" | "PENDING";
	submitted_at: string;
}

interface JiraIssue {
	key: string;
	fields: {
		summary: string;
		status: { name: string };
		issuetype: { name: string };
		priority: { name: string } | null;
		assignee: { displayName: string } | null;
		reporter: { displayName: string } | null;
		created: string;
		// Story points — Jira Cloud uses customfield_10016, Server often uses story_points
		story_points: number | null;
		customfield_10016: number | null;
	};
}

// The shape written to each JSON file
interface IssueRecord {
	jiraKey: string;
	jiraSummary: string;
	jiraIssueType: string;
	jiraStatus: string;
	jiraAssignee: string;
	storyPoints: number | null;
	jiraCreatedAt: string;       // ISO
	prNumber: number;
	prTitle: string;
	prUrl: string;
	prAuthor: string;
	prOpenedAt: string;          // ISO
	prMergedAt: string | null;   // ISO
	githubReviewers: {
		login: string;
		state: string;
		reviewedAt: string;        // ISO
	}[];
}

// ─── HTTP helper ──────────────────────────────────────────────────────────────

function getJSON<T>(url: string, headers: Record<string, string>): Promise<T> {
	return new Promise((resolve, reject) => {
		const parsed = new URL(url);
		const options = {
			hostname: parsed.hostname,
			path: parsed.pathname + parsed.search,
			headers: { "Content-Type": "application/json", ...headers },
		};
		https.get(options, (res) => {
			let data = "";
			res.on("data", (chunk) => (data += chunk));
			res.on("end", () => {
				if (res.statusCode && res.statusCode >= 400) {
					reject(new Error(`HTTP ${res.statusCode} from ${parsed.hostname}: ${data.slice(0, 300)}`));
				} else {
					resolve(JSON.parse(data) as T);
				}
			});
		}).on("error", reject);
	});
}

// ─── GitHub ───────────────────────────────────────────────────────────────────

const GH_HEADERS = {
	Authorization: `Bearer ${GITHUB_TOKEN}`,
	"User-Agent": "pr-parser-script",
	Accept: "application/vnd.github+json",
	"X-GitHub-Api-Version": "2022-11-28",
};

function githubGet<T>(path: string): Promise<T> {
	return getJSON<T>(`https://api.github.com${path}`, GH_HEADERS);
}

async function fetchAllPRs(): Promise<PullRequest[]> {
	const all: PullRequest[] = [];
	for (const state of ["open", "closed"] as const) {
		let page = 1;
		while (true) {
			const batch = await githubGet<PullRequest[]>(
				`/repos/${REPO_OWNER}/${REPO_NAME}/pulls?state=${state}&per_page=100&page=${page}`
			);
			if (!batch.length) break;
			all.push(...batch);
			if (batch.length < 100) break;
			page++;
		}
	}
	console.log(all.length, all.map(i => i.title))
	return all;
}

/** Returns all reviews for a PR, deduped to the latest review per reviewer. */
async function fetchReviewers(prNumber: number): Promise<GitHubReview[]> {
	const reviews = await githubGet<GitHubReview[]>(
		`/repos/${REPO_OWNER}/${REPO_NAME}/pulls/${prNumber}/reviews`
	);

	// Keep only the latest review per user
	const latest = new Map<string, GitHubReview>();
	for (const r of reviews) {
		if (r.user?.login) latest.set(r.user.login, r);
	}
	return [...latest.values()];
}

// ─── Jira ─────────────────────────────────────────────────────────────────────

const JIRA_AUTH = Buffer.from(`${JIRA_EMAIL}:${JIRA_TOKEN}`).toString("base64");
const JIRA_KEY_RE = /\bOPUS-\d+\b/g;
const JIRA_HEADERS = { Authorization: `Basic ${JIRA_AUTH}`, Accept: "application/json" };

function extractJiraKey(text: string): string | null {
	return text.match(JIRA_KEY_RE)?.[0] ?? null;
}

async function fetchJiraIssue(key: string): Promise<JiraIssue | null> {
	try {
		// Request story_points and customfield_10016 explicitly so both Server & Cloud are covered
		const fields = "summary,status,issuetype,priority,assignee,reporter,created,story_points,customfield_10016";
		return await getJSON<JiraIssue>(
			`${JIRA_BASE_URL}/rest/api/3/issue/${key}?fields=${fields}`,
			JIRA_HEADERS
		);
	} catch (err: unknown) {
		const msg = err instanceof Error ? err.message : String(err);
		if (msg.includes("HTTP 404")) return null;
		throw err;
	}
}

function resolveStoryPoints(fields: JiraIssue["fields"]): number | null {
	// customfield_10016 = Jira Cloud story points; story_points = Jira Server
	return fields.customfield_10016 ?? fields.story_points ?? null;
}

// ─── JSON file writer ─────────────────────────────────────────────────────────

function writeIssueFile(record: IssueRecord): void {
	fs.mkdirSync(OUTPUT_DIR, { recursive: true });
	const filePath = path.join(OUTPUT_DIR, `${record.jiraKey}.json`);
	fs.writeFileSync(filePath, JSON.stringify(record, null, 2), "utf-8");
	console.log(`Wrote ${filePath}`);
}

// ─── Main ─────────────────────────────────────────────────────────────────────

async function main() {
	console.log(`\nFetching PRs for ${REPO_OWNER}/${REPO_NAME}...`);
	const allPRs = await fetchAllPRs();

	// Only work with PRs that contain a Jira key
	const linkedPRs = allPRs.filter((pr) => extractJiraKey(pr.title) !== null);
	console.log(`Found ${linkedPRs.length} PR(s) with an OPUS-* key (skipping ${allPRs.length - linkedPRs.length}).\n`);

	let written = 0;
	let skipped = 0;

	for (const pr of linkedPRs) {
		const jiraKey = extractJiraKey(pr.title)!;
		console.log(`Processing PR #${pr.number} → ${jiraKey}`);

		// Fetch Jira issue and GitHub reviewers concurrently
		const [jiraIssue, reviews] = await Promise.all([
			fetchJiraIssue(jiraKey),
			fetchReviewers(pr.number),
		]);

		if (!jiraIssue) {
			console.log(`Jira issue ${jiraKey} not found — skipping.\n`);
			skipped++;
			continue;
		}

		const f = jiraIssue.fields;

		const record: IssueRecord = {
			jiraKey,
			jiraSummary: f.summary,
			jiraIssueType: f.issuetype.name,
			jiraStatus: f.status.name,
			jiraAssignee: f.assignee?.displayName ?? "Unassigned",
			storyPoints: resolveStoryPoints(f),
			jiraCreatedAt: f.created,                          // ISO 8601
			prNumber: pr.number,
			prTitle: pr.title,
			prUrl: pr.html_url,
			prAuthor: pr.user.login,
			prOpenedAt: pr.created_at,                      // ISO 8601
			prMergedAt: pr.merged_at,                       // ISO 8601 or null
			githubReviewers: reviews.map((r) => ({
				login: r.user.login,
				state: r.state,
				reviewedAt: r.submitted_at,                      // ISO 8601
			})),
		};

		writeIssueFile(record);
		written++;
		console.log();
	}

	console.log("─────────────────────────────────────");
	console.log(`Done. ${written} file(s) written to ${OUTPUT_DIR}/  |  ${skipped} skipped.`);
}

main().catch((err) => {
	console.error("Fatal:", err instanceof Error ? err.message : err);
	process.exit(1);
});
