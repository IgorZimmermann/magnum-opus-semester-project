#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Proposal",
  authors: json("../team-members.json"),
)

= Background and Motivation

- Refer to Project Description Word document

= Aim

In many outpatient departments, doctors must manually manage appointments, transcribe consultations, and write prescriptions, which disrupts the flow of patients and increases the workload of hospital staff. Our project addresses this by providing a privacy-preserving, locally hosted OPD management system that automates the workflow from consultation to digital prescription using open-source speech and large language models, with a "safety net" of suggestive alerts.

The technical aim of our project is to tackle the challenge of component-based architecture by orchestrating multiple independent services, such as appointment management, transcription, clinical summarization, medical suggestive alerts, and prescription generation. These services are isolated, each have their own runtime environment with well-defined interfaces that connect them and enable easy replacement and seamless upgrades of individual components.

The system follows a design that prioritizes privacy preservation, because dealing with sensitive health data requires strict precautions. To achieve this privacy thinking design, we will only use locally hosted open-source models, so that patient data never leaves the hospital's network.

This modular design makes it easy to replace components while preserving privacy and supporting clinical workflow.

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
