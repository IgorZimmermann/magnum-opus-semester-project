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
  - Start creates a consultation record with status InProgress.
  - End sets consultation status to Completed.

- The system shall transcribe consultation audio locally using an open-source model.
- Acceptance criteria:
  - Uploaded audio returns transcript text.
  - No cloud STT endpoint is called during transcription.

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
- Passwords and secrets shall never be stored in plaintext.
- Role-based authorization rules shall enforce doctor vs patient access boundaries.
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

This semester's project was designed with layered architecture in mind, implementing a component-based system (CBS) design approach focusing on modularity, replaceability and reusability. Components communicate via REST calls, shared databases and services.

=== Application layer diagram

The original design remained largely unchanged from the initial architecture sketch, consisting of two frontends, two backends and two databases. Direct REST calls were chosen instead of introducing an additional API gateway layer. The diagram illustrates how the components are connected and how they map to the individual layers of the overall architecture.

See @application_layer_diagram.
#appendix(
  <application_layer_diagram>,
  image(
    "../images/ApplicationDiagram.jpg",
  ),
  "Application Layer Diagram",
)

=== Two monolithic backend approaches

At an early stage, a microservices architecture was evaluated as an alternative to a monolithic approach. Although microservices would align with the component-based design goals, the overall system scope and project size made a monolithic structure a better fit for this implementation. \

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

The choices we made were along the lines of: familiarity with a language, framework or model over technical suitability reduces the learning curve. However, we did research for each layer, and each member evaluated and made a choice based on which technology fits our group and project the best. Faster-Whisper came out as the most reliable in testing, with high transcription accuracy and acceptable speed, when compared to MedASR and NVIDIA Canary Qwen. For documentation, presentation and meeting logs, we used Typst, so it made for the perfect PDF generator. The LLM model was decided on with testing as well; with LFM2 from LiquidAI, it was faster and a better fit overall compared to Qwen3, Phi-3.5 and Medgemma.

#table(
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
)

Application tech stack

== Frontend

The frontend design was based on the user flows; see @activity_booking and @activity_doctor. We decided not to go into detail with the frontend, as the requirements were flexible regarding styling. There are two different frontends with two separate authentications and backends. This was done separation of concerns and independent deployability in mind.


#appendix(
  <activity_booking>,
  image(
    "../images/ActivityBooking.drawio.svg",
  ),
  "Activity diagram for booking consultations",
)

== Backend architecture.

=== Booking backend

The booking backend was designed as a small ASP.NET service. The architecture is organised into layers: controllers, services, interfaces for the services and the data layer. The controllers only handle HTTP requests, and the actual business logic is being handled by separate services. This backend only uses the relational database for straightforward relational queries. We landed on this structure because of the abstraction it provides using interfaces and APIs, which makes the system easier to maintain and keeps the business logic loosely coupled from the data layer.

See the @uml_booking_backend.

#appendix(
  <uml_booking_backend>,
  image(
    "../images/UMLv2.drawio.svg",
    width: 100%,
  ),
  "UML diagram of the booking backend",
)

=== Consultation backend

The consultation database, nicknamed Heimdall, generally uses the same principle, going through the whole user flow from starting a consultation, then summarising, and finally outputting a PDF sent by email. It also separates the HTTP calls, business logic and the data layer. However, in contrast to the previously mentioned backend, it uses two databases: a relational one for structured data and a non-relational one for document-style data. The matching of each storage type and also the integrations behind interfaces make this backend easier to extend or replace in the future


== Database design

#appendix(
  <relational_database_er>,
  image(
    "../images/relational_database.drawio.svg",
  ),
  "Relational database Entity Relationship Diagram",
)

As previously mentioned, we have two different kinds of databases. One of them is the relational database, PostgreSQL in our case, for the structured data and the non-relational, MongoDB, for the document-style data. We decided to go with this design so that PostgreSQL can handle transactional records where consistency, relations and constraints are important, while MongoDB is a better fit for generated documents such as transcripts and summaries, all the while being faster and more flexible than its relational counterpart.

See @relational_database_er.


= Implementation

== Containerization
Docker and Docker Compose were utilized to containerize each component so as to keep the environment consistent. A single `docker-compose.yml` at the repository root is responsible for the orchestration of the entire system.

=== Startup Order & Healthchecks
Startup order is enforced through Docker's `depends_on` conditions. Four services expose healthcheck endpoints that Docker polls before marking them ready.

- *PostgreSQL's* `pg_isready` confirms the database accepts connections. (see @postgres_image)

- *MongoDB's* `mongosh` makes sure that the document store is responsive.

- *Echo's* Python `urllib` request ensures that the STT service's model has loaded.

- *Saga's* `curl` request confirms the PDF service is ready.

- *Heimdall* and *Janus* declare `condition: service_healthy` for these four dependencies, ensuring neither backend starts before its data stores and other services have become fully available.

- *Odin* and *Hermes* use `condition: service_started` since both services do not expose a meaningful ready signal.

=== Environment Variables
Database credentials are read from an `.env` file. Service-to-service URLs are injected as environment variables at the container level, using Docker Compose's internal DNS to resolve service names (e.g., `http://odin:11434`).

=== Persistent Volumes
Four named volumes ensure that container restarts do not delete data:
- `pgdata` - PostgreSQL database files. (see @postgres_image)
- `mongodata` - MongoDB database files.
- `ollama_data` - Downloaded LLM model weights, so the model is not re-pulled on every restart.
- `hermes_data` - Mailpit's email database.
All services are configured with `restart: unless-stopped`, so the stack recovers automatically from individual container failures with no need of manual intervention.

== Service-by-Service Implementation

=== Speech-to-Text Service (Echo)
A single processing endpoint `POST /process` accepts an audio file as a request and returns a JSON response. The uploaded audio is written to a temporary file and is deleted immediately after transcription.
A `GET /ping` endpoint serves as the health check that confirms the service is ready.

=== LLM Service (Odin)
On container startup, `entrypoint.sh` checks whether the required model `sam860/LFM2:2.6b` is present and pulls it if missing.
Since `/root/.ollama` is mounted to the `ollama_data` volume, the model is persisted and only needs to be pulled once.
Odin is called from Heimdall via the `POST /api/chat` endpoint, which accepts a JSON request body containing the model and input messages and returns the generated response.

=== PDF Generation Service (Saga)
`POST /generate` accepts a JSON body with data of the doctor, patient, diagnosis, description, and prescription. With that information, a binary file buffer is created.
Afterwards, the data is passed against the note template and a PDF file is created. The service reads the file into memory, sends it back as the HTTP response, and deletes the file so it doesn't persist.
When Heimdall calls the service, the file gets attached to the email sent via Hermes.

=== Email Service (Hermes)
Hermes is the service that sends the generated doctor's note to the patients as well as booking confirmations and cancellations. It uses the `axllent/mailpit` Docker image.
`POST /api/v1/send` requests a PDF from the Typst service, then sends it to Hermes as an SMTP message with the PDF attached.



=== Booking Backend (Janus)
This backend has two controllers:
- `AppointmentController` -
-- `POST /api/appointment` creates a booking and triggers a confirmation email via Hermes; `GET /api/appointment` returns the user's appointments. (see @appointment_controller)
- `AvailabilityController` -
-- `GET /api/availability/doctors` returns all doctors and their available time slots.


`AppointmentService` calls `IEmail` after saving the appointment and updates `EmailSentAt` once the email is sent.


=== Consultation Backend (Heimdall)
The consultation backend has four controllers:
- ConsultationController -
-- `POST /api/consultation/StartConsultation` creates a consultation record in MongoDB tied to an existing appointment.

- TranscriptController -
-- `POST /api/transcript/GenerateTranscript` accepts the audio file, forwards it to Echo and stores the result in `raw_transcipts`.

- SummaryController -
-- `POST /api/summary/GenerateSummary` sends the transcript to Odin and stores the output in `summaries`.

`PUT /api/summary/EditSummary` allows the doctor to edit the generated summary.

- PrescriptionController -
-- `POST /api/prescription/GeneratePrescription` sends the summary to Odin again and stores the prescription and suggestions in `summaries`. (see @generate_prescription)

-- `PUT /api/prescription/EditPrescription` allows the doctor to rewrite the prescription.

-- `POST /api/prescription/ApprovePrescription` triggers Saga for PDF generation then Hermes to email it to the patient.

=== Booking Frontend (Iris)
The first page contains the authentication prompt. (`iris/app/page.tsx`)
Iris's booking page displays the patient's existing bookings and allows creating a new one through a form with doctor selection and date/time picker. (`iris/app/booking/page.tsx`) (see @booking_1 and @booking_2)

=== Consultation Frontend (Eir)
There are four pages in this frontend:
- Firstly, the dashboard shows the authentication prompt and all appointments for the day before and after logging in respectively. (`eir/app/page.tsx`) (see @consultation_1)
- Secondly, the doctor can begin the consultation. (`eir/app/appointment/[id]/page.tsx`) (see @consultation_2)
- Thirdly, the generated transcript is shown and ready for review. (`appointment/[id]/transcript/page.tsx`)
- Lastly, the prescription is up for editing and approval. (`appointment/[id]/note/page.tsx`)

== Inter-Service Implementation
Each external service is registered in Program.cs as a typed HttpClient (see @Heimdall_DI). Each has an interface (`ILLM`, `IPdf`, etc.) and is implemented in `Infrastructure/`.

== Authentication & Authorization
Both backends use Auth0 JWT Bearer authentication, configured in Program.cs via AddAuth0ApiAuthentication with domain and audience read from appsettings.json.

Each backend has its own Auth0 tenant and audience — Heimdall expects https://consultation-api and Janus expects https://booking-api.

[Authorize] is applied at the controller class level in both backends, so every endpoint requires a valid token by default.

Both frontends use Auth0 to handle the login flow. It exposes an /api/access-token route that the client calls to retrieve the token, which is then forwarded to Heimdall with each request.




#appendix(
  <postgres_image>,
  image("../images/PostgresImage.png"),
  "PostgreSQL Docker Compose Snippet",
)

#appendix(
  <appointment_controller>,
  image("../images/AppointmentController.png"),
  "Appointment Controller",
)

#appendix(
  <generate_prescription>,
  image("../images/GeneratePrescription.png"),
  "Generate Prescription",
)

#appendix(
  <booking_1>,
  image("../images/Booking1.png"),
  "Iris - Bookings List",
)

#appendix(
  <booking_2>,
  image("../images/Booking2.png"),
  "Iris - New Booking Form",
)

#appendix(
  <consultation_1>,
  image("../images/Consultation1.png"),
  "Eir - Dashboard",
)

#appendix(
  <consultation_2>,
  image("../images/Consultation2.png"),
  "Eir - Consultation Start",
)

#appendix(
  <Heimdall_DI>,
  image("../images/HeimdallDI.png"),
  "Heimdall Dependency Injection",
)

= Validation
== Testing

The project employs a carefully selected technology stack for quality assurance and validation across multiple components.

=== Consultation Backend - ASP.NET

As both backends are built using ASP.NET, we utilized xUnit as the primary testing framework, which is essential for testing asynchronous operations in the backend. Moq provides flexible mocking capabilities, allowing isolation of external dependencies (MongoDB, HTTP services, email services) during testing. This combination enables comprehensive service-level testing without requiring live instances of MongoDB or third-party APIs.

*Consultation Service Tests*

What is tested: 
- The ability to retrieve consultation data and create new consultations
- The ability to preserve all relevant metadata when creating a consultation record in MongoDB and assign a unique consultation ID.
- The ability to retrieve consultation data and map it to the API response format, ensuring data integrity across relational and non-relational storage layers.

*Transcript Service Tests*

What is tested:
- The ability to upload audio recordings to the speech-to-text service and retrieve accurate transcriptions, ensuring that the transcription process is correctly integrated and functional.
- Ensuring stored transcriptions are accurately retrieved.

*Summary Service Tests*

What is tested:
- Mocks the LLM service to verify that the service correctly passes the transcription to the language model.
- Confirming that the service retrieves the most recent summary version, as multiple versions might exist.

*Prescription Service Tests*

What is tested:
- Testing if the service correctly orchestrates between the summary and LLM service and if the output is correctly structured and tracked.
- Ensuring the latest approved prescription is retrieved. 

*Mocking Strategy*

External dependencies are mocked to isolate business logic:

- *ILLM Service*: Mocked to return controlled, realistic outputs such as structured medical recommendations
- *ISpeechToText Service*: Mocked to simulate transcription without requiring actual audio processing
- *IPdf and IEmail Services*: Mocked to avoid side effects during testing
- *MongoDB Collections*: Mocked using Moq to capture inserted documents and verify persistence without requiring a live database

The use of callbacks captures documents during insertion, allowing tests to verify both that data was persisted and that the content is correct.

#footnote[`docs/research/backend.typ`]

=== Booking Backend - ASP.NET

The Booking Backend utilizes the same testing framework as the Consultation Backend: xUnit with Moq. This consistency across backends enables shared testing patterns and allows both services to be validated using identical mocking and isolation strategies.

The testing approach focuses on service-level unit tests that validate the business logic of core operations:

*Appointment Service Tests*

What is tested:
- The ability to save appointments to the database with all metadata and generate a unique appointment ID.
- The ability to persist appointment data to the relational database.
- The automatic handling of email sending, including setting the `EmailSentAt` timestamp when emails are successfully sent to patients.
- Confirming that the email contains relevant details such as the assigned doctor's name and appointment time.
- The ability to retrieve all stored appointments and map them correctly to Data Transfer Objects for API responses.

*Availability Service Tests*

What is tested:
- The ability to retrieve all doctors in the system along with their availability schedules.
- The correct retrieval of all doctors when multiple doctors are present in the system.

*Mocking Strategy*

External dependencies are mocked to isolate business logic:

- *IEmail Service*: Mocked to simulate email sending without actually dispatching emails, allowing tests to verify the email request content and success/failure handling without external dependencies.

#footnote[`docs/research/backend.typ`]

=== LLM Service - Liquid AI

LLM model selection involved comparative benchmarking using two evaluation approaches. The Summary and Suggestion quality assessment employed ROUGE-1 and BERTScore metrics to measure output accuracy and semantic understanding, while the MedQA benchmark assessed medical knowledge accuracy on a standardized dataset of 50 medical multiple-choice questions. This dual-metric approach ensured the selected model (Liquid AI LFM2) balanced both clinical relevance and real-time performance requirements.

*Testing Strategy*
 Rather than unit tests, this section uses benchmark metrics to assess output quality and operational performance characteristics. Two models were evaluated: Liquid AI (LFM2 2.6B parameters) and Gemma 4 (4B parameters).

The testing approach focuses on two critical dimensions:
1. Summary and suggestion quality for clinical accuracy
2. Medical knowledge assessment against benchmark datasets

*Summary & Suggestion Quality Assessment*

What is tested:
- The ability to generate accurate clinical summaries from consultation transcripts using ROUGE-1 metric, which measures individual word matches and validates that key clinical terms are preserved.
- The model's contextual understanding of medical concepts using BERTScore F1 metric, which evaluates semantic similarity and ensures the generated summaries maintain clinical meaning.
- Latency and token throughput to ensure the model operates efficiently for real-time clinical use, with tests run on transcripts ranging from 1 to 14 minutes.

*Medical Knowledge Assessment (MedQA Benchmark)*

What is tested:
- The model's ability to correctly answer medical multiple-choice questions from the MedQA benchmark dataset, measuring medical knowledge accuracy.
- Overall performance on 50 representative questions from the 1000+ question medical knowledge base.
- Latency and token throughput during medical question answering to assess real-time diagnostic support feasibility.

*Test Coverage and Results*

*Summary Quality Results:*
Liquid AI demonstrated superior performance for clinical summary generation:
- ROUGE-1 average: 0.562 vs Gemma 4 at 0.487
- BERTScore F1 average: 0.385 vs Gemma 4 at 0.341
- Average latency: 110.40s vs Gemma 4 at 267.85s
- Throughput: 13.38 tokens/sec vs Gemma 4 at 8.16 tokens/sec

*Medical Knowledge Results:*
Gemma 4 demonstrated superior accuracy on medical knowledge questions:
- Accuracy: 74.0% vs Liquid AI at 48.0%
- However, latency was significantly higher at 80.97s average vs 15.38s for Liquid AI

#footnote[`docs/research/LLM-testing.typ`]

=== Speech-to-text Service - Faster-Whisper

The Speech-to-Text service runs Faster-Whisper, an optimized implementation of OpenAI's Whisper model for speech recognition. Performance validation employs custom benchmark tooling that measures throughput, latency, and failure rates under varying concurrent loads. This benchmarking approach was used to validate that the service meets our requirements, where transcription must complete within acceptable timeframes for doctor-patient consultations.

*Testing Strategy*

The Speech-to-text Service validation employs stress testing and benchmark analysis to evaluate performance and reliability under varying loads.

The testing approach employs four sequential test phases to establish performance characteristics:
1. Baseline testing at low concurrency to establish normal operation
2. Ramp stress testing with gradually increasing concurrency
3. Peak stress testing at maximum expected load
4. Recovery testing to verify the service restores to baseline performance

*Test Methodology*

What is tested:
- The service's ability to process audio transcription requests at low concurrency (1-2 concurrent users) to establish baseline throughput and latency metrics.
- Performance degradation under gradually increasing concurrent load (1-16 concurrent requests) to identify where performance begins to degrade.
- Behavior under peak stress conditions (20-24 concurrent requests) to assess maximum capacity and failure rates.
- Recovery and stability after stress testing to ensure no permanent degradation from heavy load scenarios.

The tests use the same audio file across all phases, which is a mash-up of audio files from Mozilla Common Voice dataset. Concurrency levels represent simultaneous transcription requests. Key metrics measured include throughput (requests/second), mean latency, 95th percentile latency (p95), and failure rate.

*Test Coverage and Results*

*Baseline Performance (Concurrency 1-2):*
- Concurrency 1: 0.401 requests/sec, 2.49s mean latency, 0% failure rate
- Concurrency 2: 0.398 requests/sec, 4.94s mean latency, 0% failure rate

*Ramp Stress Results (Concurrency 1-16):*
- Throughput remained stable at ~0.420 requests/sec across all concurrency levels
- Mean latency increased proportionally with concurrency:
  - Concurrency 4: 9.38s latency
  - Concurrency 8: 18.38s latency
  - Concurrency 12: 26.93s latency
  - Concurrency 16: 35.20s latency
- Zero failures at all concurrency levels

*Peak Stress Results (Concurrency 20-24):*
- Concurrency 20: 0.420 requests/sec, 43.85s mean latency, 0% failure rate
- Concurrency 24: 0.420 requests/sec, 51.64s mean latency, 0% failure rate

*Recovery Test (Return to Concurrency 1):*
- Mean latency: 2.41s (comparable to baseline 2.49s)
- Throughput: 0.415 requests/sec (baseline was 0.401)
- Failure rate: 0% (unchanged)

*Performance Analysis*

- *Stable Throughput:*
 The service maintains approximately 0.42 requests/sec regardless of concurrency level, indicating that request processing is sequential and request queuing rather than parallelization limits throughput.
- *Linear Latency Scaling:*
 Mean latency increases linearly with concurrency, which is expected when requests are queued. With stable throughput and proportional latency, the system remains predictable and reliable.
- *Zero Failure Rate:*
 No requests failed across any test phase, including peak stress conditions, demonstrating robust error handling and no resource exhaustion at the tested concurrency levels.
- *Full Recovery:*
 The recovery test shows the service returns to baseline performance, indicating no permanent degradation or resource leaks from sustained stress testing.

The service represents a strong baseline suitable for stable, low-concurrency operation typical of a single outpatient department.

#footnote[`docs/research/STT-test.typ`]

== Supporting Technologies

*Auth0 for Authentication*

Authentication is provided by Auth0, a third-party identity platform with medical SSO compliance. This choice eliminates the need for custom authentication testing while ensuring HIPAA and other healthcare standards are met through Auth0's certified compliance.

#footnote[`docs/research/authentication.typ`]

*Mailpit for Email Testing*

Email functionality uses Mailpit for development and testing environments, allowing complete control over email delivery without external dependencies. Mailpit runs locally in Docker, enabling email integration testing without affecting external systems.

#footnote[`docs/research/email.typ`]

*Typst for PDF Generation*

PDF prescriptions are generated using Typst, a markup-based document system that allows data-driven PDF generation. Typst's great customizability and data templating capabilities make it suitable for clinical prescription documents with structured, reusable formatting.

#footnote[`docs/research/pdf.typ`]

*Docker and Docker Compose*

The entire system is containerized and orchestrated using Docker and Docker Compose, enabling consistent testing environments across development, CI/CD, and deployment stages. Each service runs in isolated containers.
This containerization enables:

- Reproducible testing environments independent of host machine configuration
- Isolated service testing without cross-contamination between tests
- Stress testing of individual services (e.g., STT service under load) in controlled conditions

= Conclusion

#for i in range(1, 16) {
  appendix(none, align(left, include "../logs/" + str(i) + ".typ"), "Meeting Log " + str(i))
}