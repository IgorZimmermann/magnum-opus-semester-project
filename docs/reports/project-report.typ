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

= Design

= Implementation

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

