#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Report",
  authors: json("../team-members.json"),
)

= Introduction

= Methodology
Before starting out on our project, we outlined a set of rules and methods which ensured that progression throughout the project will be smooth and continous.
The methodology and tools used also ensured that every contribution made to the project was peer-reviewed.

== Task tracking
In order to ensure that none of the tasks get lost, we made every task (programming, diagramming, documenting) an issue on Jira.
We completed these tasks during one-week-long Sprints, from one Monday to the next.
Some exceptions were made with the length of the Sprints, for example around the spring break.
Usually on Mondays, we held meetings, where we both reflected on the Sprint ending that day, and planned the one coming up.
On Thursdays we also regularly held stand-up meetings, where everyone gave an update on their issue(s).

To ensure that tasks were distributed fairly, we assigned tasks not based on their sheer quantity, but based on the tasks' actual difficulty.
We agreed collectively on an issue's story point value, using Story Point Poker.

== Documents and Presentations
To create our documentation and presentations, we chose #link("https://typst.app/")[Typst].
It allowed us to version control and handle our documents as if they were code.
Templates have also been made to create a uniform look for all of our reports and presentations.
In order to keep track of our images and diagrams, we also decided to store them in the same repository as our documents and code.
We also created a meeting log document during each meeting to keep everyone accountable and to allow team members to catch up, in case they were absent.

== Repository
To make sure code contributions are safe, each issue had its own branch, and pull requests had to be opened.
Those pull requests had to be reviewed by at least two non-contributing.
In order to allow for a rigorous and in-depth review of each contributions, we made it a rule that pull requests must be opened by Fridays, which left us the entire weekend for review and refactoring.
To help the work of the reviewers and to guarantee a smooth workflow, a Pull Request Template has also been made, see @pr-template.
We merged all pull requests together during our Monday meetings, so we can resolve possible merge conflicts with all contributors input.
We also created a pipeline that sends a message to our Discord server about a new pull request, and by replying to that message, the PR owner tags the requested reviewers.

#appendix(
  <pr-template>,
  image("../images/pull-request-template.png"),
  "Pull Request Template",
)

= Problem analysis

= Requirements

= Design

= Implementation

= Validation

= Conclusion

