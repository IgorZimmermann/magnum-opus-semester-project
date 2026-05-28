#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Report",
  authors: json("../team-members.json"),
)

= Abstract
This report addresses the administrative burden faced by outpatient departments, where Danish GPs consult an average of 49 patients per day while spending 10-20 hours per week on administrative tasks. To tackle this, a privacy-preserving outpatient department management system was developed, keeping all sensitive patient data within the clinic's network. The motivation is to modernize clinical workflows using open-source AI tools, improve consultation quality through AI-assisted second opinions, and apply the combined knowledge from this semester's courses.

The objectives were to deliver a working consultation management system that automates the workflow from audio recording to prescription delivery, while providing doctors with AI-generated summaries and medical suggestions and allowing patients to manage their bookings.

In a task-driven development environment, the system was developed as two separate web applications backed by locally hosted speech recognition and language models for transcription and document generation, with secure authentication and a consistent deployment environment across all services.

The finished system covers the full consultation workflow, with separate access for doctors and patients, AI-generated summaries and prescriptions that doctors can review and adjust, and automatic prescription delivery to patients by email.

By the end of the semester, a working and secure outpatient consultation system had been built, putting into practice a service-based architecture alongside locally hosted AI. The system can be extended further, for example by incorporating patient history into AI suggestions, processing multiple audio recordings simultaneously, or expanding the AI's role in supporting diagnosis.


= Introduction
Outpatient departments face an ever increasing load and pressure to maintain high patient volumes while maintaining quality patient care, often relying on outdated systems.

This report documents the work of this semester's project, a privacy-preserving OPD (Outpatient Department) management system. The project applies skills gathered from this semester's subjects to provide a working solution for managing consultations in clinical environments, from appointment bookings to AI-assisted prescriptions.

The system consists of a web application that lets patients handle appointments and allows doctors full control over the consultation workflow which can be broken down into the following: audio recording, transcription, AI-generated summary, AI-generated medical suggestions, and finally, delivery of the doctor's note via email to the patient.

This project follows a component-based architecture, where components are connected through well-defined interfaces for an easily maintainable system. Additionally, to ensure better data security and privacy, the AI models are hosted locally to guarantee that no patient data ever leaves the clinic's network.


== Motivation

Danish GPs see an average of 49 patients per day, leaving little to no time for patient care by the administrative overhead. Managing appointments on paper, taking notes during consultations, and writing prescriptions in separate tools, all contributing to staff burnout. As a consequence, patients suffer from longer wait times, shorter consultation time due to lack of time and doctors losing work hours on paperwork. #footnote[
  Beskrivelse af almen praksissektoren i Danmark (2016)
]

To address these problems, AI-based tools can be used to ease this workload by automating the creation of prescriptions, managing doctor's appointments and providing AI-suggested second opinions. Given the sensitivity of medical records / health data and the strict data protection requirements, all of these tools are locally hosted, ensuring patient data never leaves the clinic's network. This was a priority throughout the design and implementation of this project.


== Objective
The project's aim is to deliver a working OPD management system that supports doctors' everyday workflows. The system's design provides doctors with a user-friendly interface to record and manage consultations and easily create prescriptions along with AI suggested medical advice.


The booking system serves as a proof of concept to simulate how a full patient-to-doctor workflow would look like in a production like environment. This also provides the system with patient email needed to send the doctors note to complete the full consultation workflow

To achieve this, the project provides the following core capabilities:
*Appointment Management:*
Patients are able to register, log in, choose from doctors, and create bookings.

*Audio Recording and Transcription:*
Doctors begin and conclude consultations from their portal. The system records the audio and passes it to a local speech-to-text service for transcription.

*Summary Generation:*
A locally hosted LLM, served through Ollama, processes the transcript and produces a structured consultation summary to cut down irrelevant non-medical transcript. The summary is then manually checked by the doctor for accuracy before finalization.

*Prescription Review and Delivery:* Upon summary validation, a prescription is generated along with AI generated suggestions such as overlooked medications or referrals which act as a second opinion. Doctors can then revise the prescription if needed and finally export it as a PDF and send it to patients via email.


This report covers the methodology that shaped the structure in the way we work this project, the problem analysis and the requirements to set boundaries and limitations of our objective, followed by a implementation and design of each component to achieve this motivation. Concluding this report with testing and validation used to verify the set limitations and functions.



= Methodology
Before starting out on our project, we outlined a set of rules and methods that ensured that progression throughout the project would be smooth and continuous.
The methodology and tools used ensured that every contribution made to the project was peer-reviewed which added accountability to each task.

== Task tracking
In order to ensure all of the tasks are accounted for, we made every task (programming, diagramming, documenting) an issue on Jira.
We completed these tasks during one-week-long Sprints, from one Monday to the next.
Some exceptions were made with the length of the Sprints, for example around the spring break.
To see the velocity report chart of this project, see @velocity-report

On Mondays, we held meetings, where we reflected on the Sprint ending that day and planned the one coming up by assigning tasks in the backlog.
On Thursdays, we held stand-up meetings, where everyone gave an update on their issue(s) to track their progress.

To ensure that tasks were distributed fairly, we assigned tasks not based on their sheer quantity, but on actual difficulty.
We agreed collectively on an issue's story point value using Story Point Poker, see example @sprint-4-backlog.

== Documents and Presentations
To create our documentation and presentations, we chose #link("https://typst.app/")[Typst].
As Typst is a text-based document markup language, this allowed us to version control and handle our documents as if they were code.
We have created templates to create a uniform look for all of our reports and presentations.
In order to keep track of our images and diagrams, we have also decided to store them in the same repository as our documents and code.
We have created a meeting log document during each meeting to keep everyone accountable and to allow team members to catch up in case they were absent.

== Repository
To ensure code contributions are safe, each issue had its own branch, and pull requests had to be opened.
Those pull requests had to be reviewed by at least two non-contributing members.
In order to allow for a rigorous and in-depth review of each contribution, we made it a rule that pull requests must be opened by Fridays, which left us the entire weekend for review and refactoring.

To support reviewers and to guarantee a smooth workflow, a Pull Request Template has also been made, see @pr-template.
We merged all pull requests together during our Monday meetings, so we can resolve possible merge conflicts with all contributors' input.
We have created a pipeline that sends a message to our Discord server about a new pull request, and by replying to that message, the PR owner tags the requested reviewers.

#appendix(
  <pr-template>,
  image("../images/pull-request-template.png"),
  "Pull Request Template",
)

#appendix(
  <velocity-report>,
  image("../images/VelocityReport.png"),
  "Velocity report chart - Jira",
)

#appendix(
  <sprint-4-backlog>,
  image("../images/Sprint4Backlog.png"),
  "Sprint 4 backlog & Story point - Jira",
)


All in all, these methods and rules ensured consistent progress across all sprints and an even distribution of work with no missed deadlines, compared to previous semesters. With constant peer reviewing our codebase remained consistent and maintained quality.

= Problem analysis

== Background and Motivation

As mentioned in the introduction outpatient departments face outdated manual processes that drastically slow down operations and put a burden on both patients and medical staff.
One main cause of this problem is due to legacy IT infrastructure. Hospitals run old and outdated systems that are expensive and risky to replace during their constant operation. Additionally integrating new clinical tools require large amount of resources to transfer data, train staff, and follow data privacy compliances. This makes moving on from legacy systems costly and slow. Moreover, these old legacy systems are a large threat to cyber-attacks yet they contain highly sensitive patient health data.

On top of that, GPs and physicians report spending between 10 and 20 hours per week on administrative tasks alone. #footnote[Medscape Physician Compensation Report (2018). American Medical Association.]
This large overhead on top of the stress of patient care causes a large diagnostic errors, with 58% of diagnostic errors occurring during GP consultation. #footnote[Patient Claim Line, Medical Misdiagnosis Statistics (2024). https://www.patientclaimline.com/article/medical-misdiagnosis-statistics/]

Commercial health systems like Epic does exist and is widely used however they are often cloud based. Sending patient data to external servers to process with AI tools creates a large GDPR compliance in risk of data breach. #footnote[GDPR Register, Navigating GDPR in Healthcare. https://gdprregister.eu/gdpr/healthcare-sector-gdpr]

This highlights a need for a solution: a simple AI tools that run entirely locally using open-source models. Keeping all sensitive health information secure within the clinic's network, relieve medical administrative work and modernize facilities quickly and affordably.

== Problem Statement

Danish GPs consult with around 49 patients per day on average.
#footnote[Beskrivelse af almen praksissektoren i Danmark (2016)]
Operating at this quantity and volume leaves little room for error, yet GPs and physicians report spending between 10 and 20 hours per week on administrative tasks alone.
#footnote[Medscape Physician Compensation Report (2018). American Medical Association.]
This administrative overhead impacts doctor to patient care quality, with 58% of diagnostic errors occurring during GP consultations in ODP environments
#footnote[Patient Claim Line, Medical Misdiagnosis Statistics (2024). https://www.patientclaimline.com/article/medical-misdiagnosis-statistics/]
and prescription errors ranging from 1% to 11% of all prescriptions written.#footnote[Wikipedia, Medical Error. https://en.wikipedia.org/wiki/Medical_error]

These statistics clearly highlights a problem and a problem to solve. The current situation on administrative workload contributes to mistakes and affect patient care outcomes on diagnosis and prescribing.

== Aim

The aim of this project is to provide a privacy-preserving, locally hosted OPD management system that automates the workflow from consultation to digital prescription, using open-source speech-to-text and large language models, with a "safety net" of suggestive alerts.

The aim is built on two main technical focus: component-based architecture and privacy first design. Managing such workflow in a single, tightly coupled system would make it difficult to maintain, extend and replace individual parts. At the same time, dealing with health data requires strict precautions, meaning only locally hosted open-source models are used, so that patient data never leaves the hospital's network.

To achieve this, the system is broken down into multiple independent services: appointment management, transcription, clinical summarisation, medical suggestions, and prescription generation. These services are isolated, each with its own runtime environment and well-defined interfaces that connect them and enable easy replacement and seamless upgrades of individual components without affecting the rest of the system.

== Use cases

The following use cases follow the two primary user workflows: Doctor workflow for a consultation broken down into two segments, consultation and then review. Additionally, a booking workflow is included as part of the proof of concept. These following use cases outline the system behaviour and actor interactions.

=== Booking process
- *Primary actor:* Patient
- *Preconditions:* Patient is registered in the system and has valid login credentials
- *Goal:* Book a consultation with a doctor

*Flow* _(see @activity_login, @activity_bookings)_
+ The user navigates to the client website and logs in
+ The user selects a preferred doctor
+ The system displays available time slots
+ The user books an available appointment
+ The user is redirected to a dashboard where they can view their bookings
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

#appendix(
  <activity_doctor>,
  image(
    "../images/ActivityDoctor.drawio.svg",
  ),
  "Activity Diagram - Doctor",
)

=== Consultation process
- *Primary actor:* Doctor
- *Secondary actor:* Patient
- *Preconditions:* An appointment exists in the system and the doctor has valid credentials
- *Goal*
  - Doctor and patient discuss their medical concerns
  - Doctor identifies symptoms, makes a diagnosis, and if necessary prescribes medicine and refers the patient to another department
  - The system internally processes the audio and transcribes the consultation

*Flow* _(see @activity_doctor)_
+ Doctor navigates to the consultation website and logs in
+ The system displays a dashboard with the day's appointments for the doctor
+ The user selects the appropriate appointment and starts consultation
+ The system begins audio recording
+ The system waits until the user ends the consultation
+ Audio recording is stopped and sent to the speech-to-text component for transcription
+ The Doctor validates transcription and can update any mistakes or missing information

=== Review and send doctor's note to patient
- *Primary actor:* Doctor
- *Preconditions:* Consultation recording completed and successfully transcribed
- *Goal:* Review AI-generated documentation, validate clinical suggestions, and send the final doctor's note to the patient

*Flow* _(see @activity_doctor)_
+ The system generates a summary based on the transcription and displays it to the doctor
+ The doctor can either edit or accept the summary
+ When the summary is accepted, the system generates a draft prescription along with suggestions
+ The doctor reviews, edits and approves the final prescription
+ The system exports the prescription as a PDF and emails it to the patient

== Risks

=== Security

The most significant risk in this project is the mishandling of sensitive patient data.
To avoid this, the system is split into two separate locally hosted backends: a
booking service and a clinical workflow service. By keeping them separate, the
booking backend has zero access to clinical data, meaning even if the booking
system is compromised, patient medical records remain unreachable.

As this system handles sensitive EU patient health data data security was a priority throughout
the design and implementation of this project. To reduce the risk of data breaches, all AI models
are locally hosted ensuring no patient data is sent to external servers.


Structured booking data is stored in a relational database, while sensitive clinical
data (transcripts, summaries, and prescriptions) is stored in a separate
non-relational database. Role-based access control and token-based authentication
prevent unauthorised access at the backend level, with doctors and patients
having separate authentication tenants and access scopes. Data in transit is
encrypted in non-development environments to further protect sensitive information.


=== Componentised Architecture

A tightly coupled system would make individual failures spread across the entire
application. By breaking the system into loosely coupled components with clearly
defined interfaces, failures are isolated to the affected component while the rest of
the system continues to function. For example, if the LLM service goes down,
only the summary and prescription generation is affected while the rest of the
system continues to operate. This also simplifies debugging and makes
individual components independently replaceable without affecting others.

Docker containerisation is used to enforce isolation between services. Each
component runs in its own container, which also enables independent scaling and
automatic health checks. Containers that fail to respond can be automatically
restarted, meaning the system recovers from individual failures without any
manual intervention, directly addressing the reliability requirements of the system.


= Requirements

== Functional Requirements

*MUST have*
- The system shall allow patients to create and view bookings.
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
- Transcription request returns within 60 seconds for a 5-minute audio sample on low-end hardware.
- PDF generation and email dispatch complete within 5 seconds after approval under normal load (up to 10 concurrent users).

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
- Passwords and secrets shall never be stored in plain text.
- Role-based authorization rules shall enforce doctor and patient access boundaries.
- Security events (login failure, unauthorized access, approval actions) shall be auditable.
- JWT-based token sessions shall be created and managed by Auth0, protecting private pages

*Reliability / Recoverability*
- No approved prescription or transcript shall be lost across restart events.
- Relational and non-relational stores shall use persistent volumes.

*Testability*
- Core backend logic shall include unit and integration tests.
- At least 80% coverage shall be achieved for core application logic.

= Design

== System architecture

This semester's project was designed with a component-based system (CBS) design approach focusing on modularity and reusability, communicating through well-defined interfaces via RESTful APIs, where components are independently deployed, enabling fault isolation and easy replaceability.

A layered architecture enforces vertical separation of concerns across frontend, backend, databases.

=== Application layer diagram

The system is structured into three main layers: frontend, backend, and services/databases,
as illustrated in @application_layer_diagram.

Two front-ends exists - one for the consultation workflow and one as a proof-of-concept for the booking system.
Each frontend communicates only through with its corresponding backend via RESTful API calls.
An API gateway was not implemented as it was an unnecessary overhead which the backend acted as.

The backend act as a orchestrator, handling business logic and using the developed independent infrastructure to off load tasks such as PDF generation and prompting
LLM. Additionally, two separate database exists for relational booking data and a non-relational for patient health data.

#appendix(
  <application_layer_diagram>,
  image(
    "../images/ApplicationDiagram.jpg",
  ),
  "Application Layer Diagram",
)

=== Two monolithic backend approaches

At an early stage, a microservices architecture was evaluated as an alternative to a monolithic approach.
Although a microservices architecture would align with the component-based design goals,
the overall system scope and operational complexity made a monolithic structure a better fit for this implementation.

In addition, two separate backends were defined for the two primary use cases - main consultation backend and a proof-of-concept booking backend.
This separation improves reliability, since a failure in one backend does not affect the availability of the other.
Additionally by keeping the two system separate, it allows the booking system independent and isolated
of any connection to patient sensitive data and allows the doctors consultation backend to be hosted locally.

=== Component-Based System Diagram

The Component-Based System (CBS), see @component_based_system_diagram,
illustrates how the system is structured into modular components with explicit provided and required interfaces.

The two backends act as the central orchestrators:
- Booking Service: exposes IAuthentication, IBooking and IAvailability interfaces depending on IRelationalDb and IEmailService
- Consultation Service: exposes ITranscription, ISummaryEditor and ISendPrescription among others mentioned previously, depending on all infrastructure

Using a component-based design, with dependencies only on the interfaces allows for interchangable services without modifying the consuming component.

#appendix(
  <component_based_system_diagram>,
  image(
    "../images/CBSE2.drawio.svg",
  ),
  "Component-Based system diagram",
)

== Tech stack

The choices were made with the following in mind: familiarity with the language,
framework or model over technical suitability reduces the learning curve.
However, we did research for each layer, and each member evaluated and made a choice based
on which technology fits our group and project the best.
Faster-Whisper came out as the most reliable in testing, with high transcription accuracy and acceptable speed,
when compared to MedASR and NVIDIA Canary Qwen.
For documentation, presentation and meeting logs, we used Typst, so it made for the perfect PDF generator.
The LLM model was selected with testing as well; with LFM2 from LiquidAI,
it was faster and a better fit overall compared to Qwen3, Phi-3.5 and Medgemma.

The evaluation of the different technologies selected for the project will be covered in detail in the validation chapter of the report.


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
  caption: "Application tech stack",
)

== Frontend

So the user's do not have to manage API requests manually, we designed frontend applications,
that translate the user's clicks to API calls and present the responses from those requests.
We designed two frontends for our project, one for doctors, and one for the patients.
Both frontends were designed based on their respective user flows (see @activity_bookings for the patient flow,
and @activity_doctor for the doctor flow).

We designed two standalone frontends, instead of one with role-based authorization, because in the real-world
the doctor's frontend would be deployed only locally, within the network of the medical institution,
while patients' frontend would be accessible from everywhere in the world.

It's also important to mention, that the frontend for patients is only a proof-of-concept.
It was only designed, so that we can present the entire usage workflow, all the way from start to finish.

== Backend architecture

=== Booking backend

The booking backend was designed as a small ASP.NET service.
The architecture is organised into layers: controllers, services, interfaces for the services and the data layer.
The controllers only handle HTTP requests, and the actual business logic is being handled by separate services.

This backend only uses the relational database for relational queries.
We landed on this structure because of the abstraction it provides using interfaces and APIs,
which makes the system easier to maintain and keeps the business logic loosely coupled from the data layer.
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

The consultation backend generally uses the same principle as booking, going through the whole user flow from starting a consultation,
then summarising, and finally outputting a PDF sent via email.
It also separates the HTTP calls, business logic and the data layer.
However, in contrast to the previously mentioned backend, it uses two databases:
a relational one for structured data and a non-relational one for storing documents.
The matching of each storage type and also the integrations behind interfaces make this backend easier to extend or replace in the future.
This backend was also engineered with a translation layer between the backend logic and the service APIs, called "Infrastructure".
This is another layer of abstraction in our application, making service/component changes even easier.

== Database design

As previously mentioned, we have two different kinds of databases.
One of them is the relational database, PostgreSQL in our case,
for the structured booking data. The second one is a non-relational MongoD, for patient health data as documents.

We decided to go with this design, because PostgreSQL can handle transactional records where consistency,
relations and constraints are important, while MongoDB is a better fit for generated documents such as transcripts and summaries,
all the while being faster for document-oriented queries and more flexible than its relational counterpart.

During the desing phase the most important aspect for the databases were ACID properties, speed and ease-of-use with the built-in object-relational mapping.

=== Relational database
The relational model is designed to reflect the booking workflow:
- `doctors` and `patients` are the core tables, they are also connected with the Auth0 component
- `appointments` handle the metadata such as time, status and date. It's also a junction point for both `doctors` and `patients` modelling a many-to-many relationship.
- `works_on` was designed as an extension to the booking. It would only start working after deployment, as it is time consuming to mock and test during development.

=== Non-relational database

MongoDB stores the documents that we create via the AI. These are large and semi-structured allowing us to keep AI outputs from the relational database, while still being easy to query them by appointment ids. The collactions are `consultations`, `raw_transcripts`, `summaries`, and `doctor_notes`. These are responsible for transcripts, summaries and the generated doctor's note.

For data persistence, Docker mounts volumes, so data is saved even after a restart. This allows us to look back at past records and possibly fine-tune the agents prompt to match our standards.

@relational_database_er shows our entity relationship diagram.

#appendix(
  <relational_database_er>,
  image(
    "../images/relational_database.drawio.svg",
  ),
  "Relational database Entity Relationship Diagram",
)

= Implementation

== Naming conventions

To make the naming conventions clear in the system architecture, we assigned each component a distinct name to make service boundaries easier to identify.

#table(
  columns: 2,
  [*Name*], [*Function*],
  [Echo], [Speech-to-text],
  [Heimdall], [Consultation Backend],
  [Hermes], [Email],
  [Mneme], [Database],
  [Odin], [LLM],
  [Saga], [PDF Generation],
  [Janus], [Booking Backend],
  [Eir], [Consultation Frontend],
  [Iris], [Booking Frontend],
)

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
Hermes is the service that sends the generated doctor's note to the patients as well as booking confirmations. It uses the `axllent/mailpit` Docker image.
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
-- `POST /api/transcript/GenerateTranscript` accepts the audio file, forwards it to Echo and stores the result in `raw_transcripts`.

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
Each external service is registered in Program.cs as a typed HttpClient (see @Heimdall_DI).

Each service has a defined interface (`ILLM`, `IPdf`, `ISpeechToText`, `IEmail`) implemented
in the `Infrastructure/` layer in the consultation backend. This acts as an abstraction for a translation
layer between the business logic and the external service APIs.

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
- The ability to retrieve consultation data and create new consultations.
- The ability to preserve all relevant metadata when creating a consultation record in MongoDB and assign a unique consultation ID.
- The ability to retrieve consultation data and map it to the API response format, ensuring data integrity across relational and non-relational storage layers.

*Transcript Service Tests*

What is tested:
- The ability to upload audio recordings to the speech-to-text service and retrieve accurate transcriptions, ensuring that the transcription process is correctly integrated and functional.
- Ensuring stored transcriptions are accurately retrieved.

*Summary Service Tests*

What is tested:
- Mocks the LLM service to verify that the service correctly passes the transcription to the language model.
- Confirming that the service retrieves the most recent summary version as multiple versions might exist.

*Prescription Service Tests*

What is tested:
- Testing if the service correctly orchestrates between the summary and LLM service and if the output is correctly structured and tracked.
- Ensuring the latest approved prescription is retrieved.

*Mocking Strategy*

External dependencies are mocked to isolate business logic:

- *ILLM Service*: Mocked to return controlled and realistic outputs such as structured medical recommendations.
- *ISpeechToText Service*: Mocked to simulate transcription without requiring actual audio processing.
- *IPdf and IEmail Services*: Mocked to avoid side effects during testing.
- *MongoDB Collections*: Mocked using Moq to capture inserted documents and verify persistence without requiring a live database.

The use of callbacks captures documents during insertion, allowing tests to verify both that the data was stored and that the content is correct.

#footnote[`docs/research/backend.typ`]

=== Booking Backend - ASP.NET

The Booking Backend utilizes the same testing framework as the Consultation Backend: xUnit with Moq. This consistency across backends enables shared testing patterns and allows both services to be validated using identical mocking and isolation strategies.

The testing approach focuses on service-level unit tests that validate the business logic of core operations:

=== Test Coverage and Results for Backends

Code coverage was measured for both backend services using `Coverlet` and `ReportGenerator`, following the .NET testing coverage guidelines. 

The overall line coverage for the Consultation Backend was 19.1% and for the Booking Backend it was 9.8%. These figures are deceiving and low due to the infrastructure of both backends. There are many services used, such as Speech-to-Text or Email, that depend on external services and are not suitable for unit testing. Migrations and auto-generated code also significantly contribute to the uncovered line count.

When looking at core logic, we get a much more representative result. In the Consultation Backend the service layer achieves between 48.6% and 73.3%, with the data models reaching 81.8% to 100% (see @consultation_test_coverage). In the Booking Backend, the appointment and availability services both achieve 100% (see @booking_test_coverage).

#appendix(
  <consultation_test_coverage>,
  image("../images/ConsultationTestCoverage.png"),
  "Consulation Test Coverage",
)

#appendix(
  <booking_test_coverage>,
  image("../images/BookingTestCoverage.png"),
  "Booking Test Coverage",
)

*Appointment Service Tests*

What is tested:
- The ability to save appointments to the database with all metadata as well as generate a unique appointment ID.
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

LLM model selection involved comparative benchmarking using two evaluation approaches. The Summary and Suggestion quality assessment employed ROUGE-1 and BERTScore metrics to measure output accuracy and semantic understanding while the MedQA benchmark assessed medical knowledge accuracy on a standardized dataset of 50 medical multiple-choice questions. This dual-metric approach ensured the selected model (Liquid AI LFM2) balanced both clinical relevance and real-time performance requirements.

*Testing Strategy*
Rather than unit tests, this section uses benchmark metrics to assess output quality and operational performance characteristics. Two models were evaluated: Liquid AI (LFM2 2.6B parameters) and Gemma 4 (4B parameters).

The testing approach focuses on two critical dimensions:
1. Summary and suggestion quality for clinical accuracy.
2. Medical knowledge assessment against benchmark datasets.

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

The Speech-to-Text service runs Faster-Whisper, an optimized implementation of OpenAI's Whisper model for speech recognition. Performance validation employs custom benchmark tooling that measures throughput, latency, and failure rates under varying concurrent loads. This benchmarking approach was used to validate that the service meets our requirements, where transcription must be completed within acceptable timeframes for doctor-patient consultations.

*Testing Strategy*

The Speech-to-text Service validation employs stress testing and benchmark analysis to evaluate performance and reliability under varying loads.

The testing approach employs four sequential test phases to establish performance characteristics:
1. Baseline testing at low concurrency to establish normal operation.
2. Ramp stress testing with gradually increasing concurrency.
3. Peak stress testing at maximum expected load.
4. Recovery testing to verify the service restores to baseline performance.

*Test Methodology*

What is tested:
- The service's ability to process audio transcription requests at low concurrency (1-2 concurrent users) to establish baseline throughput and latency metrics.
- Performance degradation under gradually increasing concurrent load (1-16 concurrent requests) to identify where performance begins to degrade.
- Behavior under peak stress conditions (20-24 concurrent requests) to assess maximum capacity and failure rates.
- Recovery and stability after stress testing to ensure no permanent degradation from heavy load scenarios.

The tests use the same audio file across all phases. The file is a mash-up of audio clips from Mozilla Common Voice dataset. Concurrency levels represent simultaneous transcription requests. Key metrics measured include throughput (requests/second), mean latency, 95th percentile latency (p95), and failure rate.

*Baseline Performance (Concurrency 1-2):*
- Concurrency 1: 0.401 requests/sec, 2.49s mean latency, 0% failure rate
- Concurrency 2: 0.398 requests/sec, 4.94s mean latency, 0% failure rate

*Ramp Stress Results (Concurrency 1-16):*
- Throughput remained stable at \~0.420 requests/sec across all concurrency levels
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
  The service maintains approximately 0.42 requests/sec regardless of concurrency level, indicating that request processing is sequential and request queuing, rather than parallelization, limits throughput.
- *Linear Latency Scaling:*
  Mean latency increases linearly with concurrency, which is expected when requests are queued. With stable throughput and proportional latency, the system remains predictable and reliable.
- *Zero Failure Rate:*
  No requests failed during any test phase, including peak stress conditions, demonstrating robust error handling and no resource exhaustion at the tested concurrency levels.
- *Full Recovery:*
  The recovery test shows the service returns to baseline performance, indicating no permanent degradation or resource leaks from sustained stress testing.

#footnote[`docs/research/STT-test.typ`]
The service represents a strong baseline suitable for stable, low-concurrency operation typical of a single outpatient department.


=== Manual Testing


#figure(
  table(
    columns: (auto, 1.2fr, 2fr, 1.6fr, auto),
    align: horizon,

    [*Test Case ID*], [*Test Scenario*], [*Test Steps*], [*Actual Result*], [*Status*],

    [TC-001],
    [Login via Iris/Eir],
    [1. Navigate to the Iris/Eir login page. \ 2. Enter valid patient credentials. \ 3. Submit the login form.],
    [User is authenticated and redirected to the booking/consultation dashboard],
    [Pass],

    [TC-002],
    [Start a consultation],
    [
      1. Log in as a doctor. \ 2. Select relevant appointment. \ 3. Press start consultation. \ 4. Talk with patient. \ 5. Edit summary.
    ],
    [The full doctor's note is generated with symptoms, diagnosis, description and advice or prescription and is stored in the non-relational database.],
    [Pass],

    [TC-003],
    [Book an appointment],
    [1. Log in as a patient. \ 2. Select a doctor and an available time slot. \ 3. Confirm the booking.],
    [Booking is created, appears on the dashboard and is visible in the doctor's consultation view.],
    [Pass],

    [TC-004],
    [Register with Iris/Eir],
    [1. Press sign up. \ 2. Enter email and password. \ 3. Send the form. \ 4. Log in.],
    [User is created in the local relational database and the Auth0 database.],
    [Pass],
  ),
  caption: "Manual test cases",
)

== Supporting Technologies

*Auth0 for Authentication*

Authentication is provided by Auth0, a third-party identity platform with medical SSO compliance. This choice eliminates the need for custom authentication testing, with
Auth0's certified compliance supporting HIPAA and other healthcare standards.

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


// TODO - TEST COVERAGE RESULT

= Conclusion

== Summary
This semester's project successfully delivered a privacy-preserving OPD (Outpatient Department) management system that meets the main objectives that were defined in collaboration with the case owners at the beginning of the semester. Our solution enables doctors to reduce mistakes made during consultations by reducing consultation administrative work, while the system is secure in terms of handling sensitive patient data on the clinic's network. Additionally, a proof of concept for the booking system was developed to demonstrated the end to end workflow from patient booking to consultation, while separating them.

Reflecting on the project, the following points was a success:
- CBS design - Independently deployed infrastructure allows for easy testability and modularity during development
- Methodology - Two meetings a week ensures constant accountability and progress
- Auth0 Integration - handled both backends cleanly with minimal friction
- Docker compose - full system consistency, reproducible across all machines

What could be improved:
- Booking backend - remains as POC, still lacks business logic validation and development
- Interchangeable infrastructure - have options to change multiple infrastructure models and implement different infrastructure
- Mailpit - remains as a development tool, production would require SMTP service


The system demonstrates the application of the knowledge gained throughout this semester's courses. It demonstrates the design of a component-based system and the use of a self-hosted large language model.

== Future work
There are many improvements, which can be implemented in the future to enhance the system. In terms of clinical capability, the LLM could be expanded, so it looks at past patient history to propose contraindications or warn about possible allergy-related side affects. We could also make the AI use reinforcement learning, where the Doctor can rate the AI's responses to fine-tune the local model over time. Furthermore, AI could help out to assist the Doctor not only with making mistakes and prescribing but also in differential diagnosis.

For the front-end part of our project, we did not spend so much time on making it a very accessible platform, as our project is not a Booking platform, it's an AI service. However, we could extend it to add past consultation summaries and prescriptions after the fact, appointment reminders via the email service and a preconsultation form that the patient can fill out with symptoms to feed into the LLM context.

Furthermore, the speech-to-text (STT) component currently used in the system is not suited for horizontal scaling, because it cannot handle more than one audio file at the same time. We need to find a solution that is concurrent, either using a job queue or async transcriptions. This change would allow the parallel processing of the audio recordings making the waiting time less and the user experience smoother.

In conclusion, these improvements would greatly enhance user experience and the variety of features offered by our application and would make it one step closer to a real-world deployment.

// Meeting logs in appendix
#for i in range(1, 17) {
  appendix(none, align(left, include "../logs/" + str(i) + ".typ"), "Meeting Log " + str(i))
}
