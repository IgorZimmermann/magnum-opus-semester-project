#import "../templates/contract.typ": contract

#show: contract.with(
  title: "Group Contract",
  date: datetime.today(),
  location: "Sønderborg",
  signatories: json("../team-members.json"),
)

= Introduction
The below contract outlines the rules and methods the Group will adhere to during our Semester Project for the Spring 2026 semester. These rules are set in place to ensure that progression through the project is smooth and continuous. The methodology outlined below ensures that every contribution made to the project will be peer-reviewed.

= Meetings
All meetings will be held in person.

Meetings will be held twice a week.

@meeting-times shows the meeting times.

#figure(
  table(
    columns: 2,
    [*Event*], [*Day*],
    [Sprint Review, Sprint Planning], [Monday],
    [Weekly Stand-up], [Thursday],
  ),
  caption: "Meeting times",
) <meeting-times>

Members must not be late by more than 15 minutes unless they give prior notice, at least three hours ahead.

Members must give prior notice, if they cannot attend or can only attend online, at least on the day before.

All meetings must be logged in a document, with attendants, date, and each member's contribution since the previous meeting.

= Method

== Task Tracking
Every task must be an issue on #link("https://www.atlassian.com/software/jira")[Jira].

Tasks must be completed during Sprints.

Sprints must last from a Sprint Planning event, to the following Sprint Review event.

New tasks must only be added to the backlog.

Tasks must be assigned by the Scrum Master (appointed during the first meeting).

The Scrum Master must assign tasks during the Sprint Planning event, based on the input of team members.

Every issue must have a story point value, based on the input of team members.

Task progression must be appropriately tracked between the "To-Do", "In Progress", "In Review" and "Done" columns, by the task assignee.

== Documents and Presentations
All documents and presentations must be made using #link("https://typst.app/docs/")[Typst].

All documents (report, meeting logs, presentations, etc.) must be version controlled and pushed to the repository.

All documents, where possible, must be made using the templates.

All images and figures used in documents, must be pushed to the repository.

== Repository

All task contributions must be made to a new branch from the `main` branch.

When a task is finished a pull request must be opened.

All pull request must be reviewed by at least two, non-contributing members.

Pull requests must be merged during the Sprint Review event.

Pull requests must be opened, at the latest, two days before the Sprint Review meeting, so others have time to review and changes can be made, if needed.

All pull requests must be made in accordance with the PULL_REQUEST template.

= AI use
AI can be used to generate a guideline for a documents.

AI can be used to proofread documents.

AI must not be used to directly rephrase or rewrite any part of a document.

AI can be used to find solutions to coding problems.

AI must not be used to write code directly.

AI must not review pull requests.

All team members must adhere to SDU's #link("https://mitsdu.dk/en/mit_studie/kandidat/negot_kandidat/vejledning-og-support/aipaasdu/vejledning-gai")[AI Guidelines and Rules].
