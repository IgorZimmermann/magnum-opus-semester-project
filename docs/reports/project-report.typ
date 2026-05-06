#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Report",
  authors: json("../team-members.json"),
)

= Introduction
This report documents the work of this semester's project, a privacy-preserving OPD (Outpatient Department) management system. The project relies on skills gathered from this semester's subjects to provide a working solution for managing consultations in clinical environments, from booking to AI-assisted prescription.

The system consists of a web application that lets patients handle appointment booking and allows doctors to control the consultation workflow: audio recording, transcription, AI-generated summary and suggestions, and finally, delivery of the doctor's note via email.

Components are connected through well-defined interfaces, and the locally run AI model guarantees that no patient data ever leaves the clinic's network. The project showcases how a component-based design, a local LLM, and a containerized infrastructure can work together in a privacy-sensitive environment.
== Motivation
Outpatient departments spend the majority of their time on administrative work rather than focusing on patient care. Managing appointments on paper, taking notes during consultations, and writing prescriptions in separate tools all contribute to staff burnout. As a consequence, patients suffer from longer waits and less focused consultations.

AI-based tools can be used to ease this workload. However, the solution must not rely on cloud services. Since patient records are sensitive by nature, regulations require that they stay under the control of the facility that holds them.

This project addresses these problems by creating a system that automates the entire clinical workflow from appointment booking to digital prescription while everything is kept local.
== Objective
The project's aim is to deliver a working OPD management system that supports patients' and doctors' everyday workflows. The system's design lets patients easily book and manage appointments with the help of a simple interface, as well as providing doctors a way to record consultations, and easily create a prescription with the locally stored data without it ever leaving the clinic's infrastructure.

To achieve this, the project provides the following core capabilities:

*Appointment Management:*
Patients are able to register, log in, search for doctors, and create or cancel bookings.

*Audio Recording and Transcription:*
Doctors begin and conclude consultations from their portal. The system records the audio and passes it to a local speech-to-text service for transcription.

*Summary Generation:*
A locally hosted LLM, served through Ollama, processes the transcript and produces a structured consultation summary. The summary is then manually checked for accuracy before finalization.

*Prescription Review and Delivery*: Upon summary validation, a prescription is generated along with suggestions such as overlooked medications and/or referrals. Doctors can then revise the prescription if needed and finally export it as a PDF and send it to patients via email.



= Methodology
Before starting out on our project, we outlined a set of rules and methods which ensured that progression throughout the project will be smooth and continous.
The methodology and tools used also ensured that every contribution made to the project was peer-reviewed.

== Task tracking
In order to ensure that none of the tasks get lost, we made every task (programming, diagramming, documenting) an issue on Jira.
We completed these tasks during one-week-long Sprints, from one Monday to the next.
Some exceptions were made with the length of the Sprints, for example around the spring break.
On Mondays, we held meetings, where we both reflected on the Sprint ending that day, and planned the one coming up.
On Thursdays we also regularly held stand-up meetings, where everyone gave an update on their issue(s).

To ensure that tasks were distributed fairly, we assigned tasks not based on their sheer quantity, but based on the tasks' actual difficulty.
We agreed collectively on an issue's story point value, using Story Point Poker.

== Documents and Presentations
To create our documentation and presentations, we chose #link("https://typst.app/")[Typst].
As Typst is a text-based document markup language, this allowed us to version control and handle our documents as if they were code.
We also made templates to create a uniform look for all of our reports and presentations.
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

All in all, these methods and rules helped us improve our productivity by a lot, compared to previous semesters.
It also made the entire process, less of a hassle, and way more enjoyable.
Our team completed every task within the deadlines, with time to review and discuss different opinions.

= Problem analysis

== Background and Motivation

Outpatient departments face outdated manual processes that drastically slow down operations and put a burden on both patients and medical staff. Doctors and nurses spend too much time on paper schedules, taking notes during consultations, and using separate systems for writing prescriptions. This causes long wait times, a poor patient experience due to disrupted doctor focus, errors, and burnout from extra administrative work. These issues also create serious privacy risks for patient data, which demand strict precautions and careful handling.

Our project offers a solution for a clear gap: the need for simple AI tools that run entirely locally using open-source models, keeping all sensitive health information secure within the clinic's network. By automating the full process from patient booking and real-time transcription to AI-generated clinical summaries, "safety-net" suggestions, and instant digital prescriptions, it helps healthcare facilities modernize quickly and affordably. This reduces mistakes, speeds up patient flow, and relieves medical staff of the burden of endless paperwork, allowing them to focus on delivering quality care and improving patient satisfaction.

== Problem Statement

Danish General Practitioners (GPs) have contact with around 49 patients per day on average. Operating with such a high volume of patients carries risks of making mistakes across three core steps: diagnosis, prescribing, and referral.#footnote[
  Beskrivelse af almen praksissektoren i Danmark (2016)
  ]

== Aim

The aim of this project is to provide a privacy-preserving, locally hosted OPD management system that automates the workflow from consultation to digital prescription, using open-source speech-to-text and large language models, with a "safety net" of suggestive alerts.

Managing such such a worklfow in a single, tightly coupled system would make it difficult to maintain, extend and replace individual parts. Therefore the technical aim of our project is to tackle this challenge through component-based architecture by implementing multiple independent services: appointment management, transcription, clinical summarisation, medical suggestions, and prescription generation. These services are isolated, each with its own runtime environment and well-defined interfaces that connect them and enable easy replacement and seamless upgrades of individual components.

The system follows a privacy-first design, as dealing with sensitive health data requires strict precautions. To achieve this, only locally hosted open-source models are used, so that patient data never leaves the hospital's network.

This modular design makes it easy to replace components while preserving privacy and supporting clinical workflow.

== Use cases

=== Booking process 
- *Primary actor:* Patient
- *Preconditions:* Patient is registered in the system and has valid login credentials
- *Goal:* Book a consultation with a doctor

*Flow* _(see @activity_login, @activity_bookings)_
+ The user navigates to the client website and logs in
+ The user selects a preferred doctor
+ The system displays available time slots
+ The user books an available appointment
+ The user is redirected to a dashboard where they can view or cancel their bookings
+ The system sends a confirmation email

#appendix(
  <activity_login>,
  image(
    "../images/ActivityLogin.drawio.svg",
  ),
  "Activity Diagram - Login",
)

#appendix(
  <activity_bookings>,
  image(
    "../images/ActivityBooking.drawio.svg",
  ),
  "Activity Diagram - Booking",
)

=== Consultation process
- *Primary actor:* Doctor
- *Secondary actor:* Patient
- *Preconditions:* An appointment exists in the system and the doctor has valid credentials
- *Goal*
  - Doctor and patient discuss the issues
  - Doctor identifies symptoms, makes a diagnosis, and if necessary prescribes medicine and refers the patient to another department
  - The system internally processes the audio and transcribes the consultation

*Flow* _(see @activity_doctor)_
+ User navigates to the doctor website and logs in
+ The system displays a dashboard with the day's appointments
+ The user selects the appropriate appointment and starts consultation
+ The system begins audio recording
+ The system waits until the user ends the consultation
+ Audio recording is stopped and sent to the speech-to-text component for transcription

#appendix(
  <activity_doctor>,
  image(
    "../images/ActivityDoctor.drawio.svg",
  ),
  "Activity Diagram - Doctor Workflow",
)

=== Review and send doctor's note to patient
- *Primary actor:* Doctor
- *Preconditions:* Consultation recording completed and successfully transcribed
- *Goal:* Review AI-generated documentation, validate clinical suggestions, and send the final doctor's note to the patient

*Flow* _(see @activity_doctor)_
+ The system generates a summary based on the transcription and displays it to the doctor
+ The doctor can either edit or accept the summary
+ When the summary is accepted, the system generates suggestions and a draft prescription
+ The doctor reviews, edits and approves the final prescription
+ The system exports the prescription as a PDF and emails it to the patient

== Risks

=== Security

The most significant risk in this project is the mishandling of sensitive patient data.
To avoid this, the system is split into two separate, locally hosted backends: a
booking service and a clinical workflow service. By keeping them separate, a request
to the booking backend only ever touches booking data, ensuring that confidential
medical information is never exposed through that path.

Structured booking data is stored in a relational database, while sensitive clinical
data (transcripts, summaries, and prescriptions) is stored in a separate
non-relational database.
The locally hosted LLM further reduces the risk of data breaches, as no data is sent
to external servers. Role-based access control and token-based authentication
prevent unauthorised access at the backend level.

=== Componentised Architecture

A tightly coupled system would make individual failures spread across the entire
application. By breaking the system into loosely coupled components with clearly
defined interfaces, failures are isolated to the affected component while the rest of
the system continues to function. This also simplifies debugging and makes
individual components independently replaceable without affecting others.

Docker containerisation is used to enforce isolation between services. Each
component runs in its own container, which also enables independent scaling and
automatic health checks. Containers that fail to respond can be automatically
restarted, reducing downtime and improving overall reliability.


= Requirements

== Functional Requirements

*MUST have*

  - The system shall allow patients to create, view, and cancel bookings.
    - Acceptance criteria:
      - Creating a booking returns a booking identifier and status.

  - The system shall require authenticated access for patient and doctor workflows.
    - Acceptance criteria:
      - Protected API endpoints reject unauthenticated requests.
      - Authenticated users can access only authorized workflow endpoints.

  - The system shall allow doctors to start and end consultations linked to valid bookings.
    - Acceptance criteria:
      - Start creates a consultation record with status _In Progress_.
      - End sets consultation status to _Completed_.

  - The system shall transcribe consultation audio locally using an open-source model.
    - Acceptance criteria:
      - Uploading audio returns transcript text.
      - No cloud Speech-to-Text service is called during transcription.

  - The system shall generate a structured clinical summary and prescription draft using a locally hosted open-source LLM.
    - Acceptance criteria:
      - Summary generation returns structured summary output.
      - Prescription draft generation returns structured fields.

  - Doctors shall be able to review, edit, approve, and reject AI-generated summary and prescription outputs.
    - Acceptance criteria:
      - Edit operations persist updated content.
      - Approve operation marks status Approved.
      - Reject operation marks status Rejected.

  - The system shall generate a PDF prescription after doctor approval and send it to the patient via email.
    - Acceptance criteria:
      - Approval triggers PDF generation.
      - Approved PDF is attached to outbound email.
      - Delivery outcome is logged.

  - The system shall store structured operational data (users, doctors, patients, bookings) in a relational database.
  - The system shall store transcript and AI-generated consultation artifacts in a non-relational database.

*SHOULD have*

  - The system should allow searching and filtering doctors by availability and name/specialty.
  - The system should log AI prompts and outputs for evaluation purposes.

*COULD have*

  - Doctors could upload diagnostic images to consultation records.
  - The system could support runtime switching between local LLM models.
  - The system could allow configurable instructions.

*WON'T have*

- The system will not use cloud-based AI services for core transcription or generation.
- The system will not include a mobile application.

== Non-Functional Requirements

*Performance*
- Transcription request returns within 30 seconds for a 5-minute audio sample on low-end hardware.
- PDF generation and email dispatch complete within 5 seconds after approval under normal load (up to 20 concurrent users).
- Booking API responses complete within 3 seconds at expected load.

*Portability*
- The system runs on Windows, Linux, and macOS through containerized deployment.
- All core services are runnable with one orchestrated compose configuration.

*Scalability / Capacity*
- The system supports at least 5 concurrent consultations without service failure.

*Maintainability / Modularity*
- Core services are independently deployable and replaceable via stable APIs.
- The architecture follows CBSE principles with clear component boundaries and interfaces.
- Changes to one service should not require code changes in unrelated services.

*Security*
- Patient and consultation data in transit shall use encrypted channels in non-development environments.
- Passwords and secrets shall never be stored in plain text.
- Role-based authorization rules shall enforce doctor and patient access boundaries.
- Security events (login failure, unauthorized access, approval actions) shall be auditable.

*Reliability / Recoverability*
- Services auto-recover from container-level failures.
- No approved prescription or transcript shall be lost across restart events.
- Relational and non-relational stores shall use persistent volumes.

*Testability*
- Core backend logic shall include unit and integration tests.
- At least 80% coverage shall be achieved for core application logic.

= Design

== System architecture

This semester's project was designed with layered architecture in mind, implementing a component-based system (CBS) design approach focusing on modularity, replaceability and reusability. Components communicate via RESTful API calls, shared databases and services.

=== Application layer diagram

The original design remained largely unchanged from the initial architecture sketch, consisting of two frontends, two backends and two databases. Direct REST calls were chosen instead of introducing an additional API gateway layer. @application_layer_diagram illustrates how the components are connected and how they map to the individual layers of the overall architecture.

#appendix(
  <application_layer_diagram>,
  image(
    "../images/ApplicationDiagram.jpg",
  ),
  "Application Layer Diagram",
)

=== Two monolithic backend approaches

At an early stage, a microservices architecture was evaluated as an alternative to a monolithic approach. Although a microservices architecture would align with the component-based design goals, the overall system scope and project size made a monolithic structure a better fit for this implementation. \

In addition, two separate backends were defined for the two primary use cases. This separation improves reliability, since a failure in one backend does not necessarily affect the availability of the other.

=== Component-Based System Diagram

The Component-Based System (CBS), see @component_based_system_diagram, illustrates how the system is structured into modular components with exposed interfaces. It can be broken down into three main layers: frontend, backend, and services/databases. This design allows individual components to be independently developed and interchanged at runtime.

#appendix(
  <component_based_system_diagram>,
  image(
    "../images/CBSE2.drawio.svg",
  ),
  "Component-Based system diagram",
)
== Tech stack

The choices were made with the following in mind: familiarity with a language, framework or model over technical suitability reduces the learning curve. However, we did research for each layer, and each member evaluated and made a choice based on which technology fits our group and project the best. Faster-Whisper came out as the most reliable in testing, with high transcription accuracy and acceptable speed, when compared to MedASR and NVIDIA Canary Qwen. For documentation, presentation and meeting logs, we used Typst, so it made for the perfect PDF generator. The LLM model was selected with testing as well; with LFM2 from LiquidAI, it was faster and a better fit overall compared to Qwen3, Phi-3.5 and Medgemma.

#figure(
  table(
    columns: 3,
    align: left,
    stroke: 0.5pt,
    inset: 6pt,

    [*Layer*], [*Technology*], [*Purpose*],

    [Frontend], [Next.js / TypeScript], [User/Doctor interface],
    [Backend], [C\# - ASP.NET], [Orchestration & business logic],
    [Speech-to-Text], [Faster-Whisper], [Audio transcription],
    [LLM Runtime], [Ollama + LLM models], [Local AI],
    [PDF Generator], [Typst], [PDF generation],
    [Email], [Mailpit], [Email sending],
    [Data], [PostgreSQL + MongoDB], [Un/structured storage],
    [Deployment], [Docker Compose], [Containerized services & networking],
  ),
  caption: "Application tech stack"
)

== Frontend

The frontend design was based on the user flows (see @activity_bookings and @activity_doctor). We decided to keep the frontend very minimal, as the requirements were flexible regarding styling. There are two different frontends with two separate authentications and backends. This was done with separation of concerns and independent deployability in mind.

== Backend architecture

=== Booking backend

The booking backend was designed as a small ASP.NET service. The architecture is organised into layers: controllers, services, interfaces for the services and the data layer. The controllers only handle HTTP requests, and the actual business logic is being handled by separate services. This backend only uses the relational database for relational queries. We landed on this structure because of the abstraction it provides using interfaces and APIs, which makes the system easier to maintain and keeps the business logic loosely coupled from the data layer.
@uml_booking_backend shows the UML diagram for the booking backend.

#appendix(
  <uml_booking_backend>,
  image(
    "../images/UMLv2.drawio.svg",
    width: 100%,
  ),
  "UML diagram of the booking backend",
)

=== Consultation backend

The consultation backend generally uses the same principle as booking, going through the whole user flow from starting a consultation, then summarising, and finally outputting a PDF sent via email. It also separates the HTTP calls, business logic and the data layer. However, in contrast to the previously mentioned backend, it uses two databases: a relational one for structured data and a non-relational one for storing documents. The matching of each storage type and also the integrations behind interfaces make this backend easier to extend or replace in the future.

== Database design

#appendix(
  <relational_database_er>,
  image(
    "../images/relational_database.drawio.svg",
  ),
  "Relational database Entity Relationship Diagram",
)

As previously mentioned, we have two different kinds of databases. One of them is the relational database, PostgreSQL in our case, for the structured data and the non-relational, MongoDB, for storing documents. We decided to go with this design, because PostgreSQL can handle transactional records where consistency, relations and constraints are important, while MongoDB is a better fit for generated documents such as transcripts and summaries, all the while being faster and more flexible than its relational counterpart.
@relational_database_er shows our entity relationship diagram.

= Implementation

= Validation

= Conclusion

#for i in range(1, 16) {
  appendix(none, align(left, include "../logs/" + str(i) + ".typ"), "Meeting Log " + str(i))
}
