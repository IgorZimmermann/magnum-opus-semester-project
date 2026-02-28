#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Proposal",
  authors: json("../team-members.json"),
)

= Background and Motivation

- Refer to Project Description Word document

= Aim

In many outpatient departments, doctors must manually manage appointments, transcribe consultations, and write prescriptions, which disrupts the flow of patients and increases the workload of hospital staff. Our project addresses this by providing a privacy-preserving, locally hosted OPD management system that automates the flow from consultation to digital prescription using open‑source speech and language models, offers a "safety net" through suggestive alerts, and is designed as a modular, easily replaceable component-based system.

= Objectives

- User stories

= Initial requirements

- Non-functional and function
- MoSCoW
- additional requirement ideas
  - llm testing
  - image upload

= Methods

- Refer to Group Contract

= Architecture

- Tech stack, refer to Application Diagram

= Risks

- What poses a risk to the success of your project?
- What can you do to mitigate these risks?
