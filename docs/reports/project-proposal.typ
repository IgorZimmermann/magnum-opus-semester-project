#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Proposal",
  authors: json("../team-members.json"),
)

= Background and Motivation

- Refer to Project Description Word document

= Aim

- Problem statement

= Objectives

- User stories

= Initial requirements

- Non-functional and function
- MoSCoW
- additional requirement ideas
  - llm testing
  - image upload

#pagebreak()

= Methods

Before starting out on our project, we outlined a set of rules and methods to ensure that progression through the project will be smooth and continuous. The methodology and tools used also ensure that every contribution made to the project is peer-reviewed.

== Task tracking

In order to ensure that none of the tasks get lost, we make every task (development, diagramming, documenting) an issue on Jira. We complete these tasks during one-week-long Sprints, from one Monday to the next. On Mondays, we hold meetings where we both reflect on the Sprint ending that day and plan the one coming up. We also assign story points to each task before distributing them to ensure that each person gets a similar workload. On Thursdays, we also hold a Stand-up meeting where everyone gives an update on the issue(s).

== Documents and Presentations

To create our documentation and presentations, we choose #link("https://typst.app/docs/")[Typst]. It allows us to version control and handle our documents, as if they were code. Templates have also been made to create a uniform design and look to all of our reports and presentations. In order to keep track of our images and diagrams, we also decided to store them in the same repository as our documents and code.

== Repository

To make sure code contribution is safe, each issue has its own branch, and pull requests must be opened to merge. Those pull requests must then be reviewed by at least two non-contributing peers. In order to have time for review and changes before the end of the sprint, pull requests must be opened at least two days before the end of the sprint. To help the work of the reviewers and to guarantee a smooth workflow, a Pull Request template has also been made, see @pr_template.

#appendix(
  <pr_template>,
  image(
    "../images/pull-request-template.png",
  ),
  "Pull Request template",
)


#pagebreak()

= Architecture

- Tech stack, refer to Application Diagram

= Risks

- What poses a risk to the success of your project?
- What can you do to mitigate these risks?
