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

= Conclusion
== Summary
This semester's project successfully delivered a privacy-preserving OPD (Outpatient Department) management system that meets the main objectives that were defined by us and the case owners at the beginning of the semester. Our solution enables doctors to reduce mistakes made during consultations, while the system is secure in terms of handling sensitive patient data on the clinic's network.

The system demonstrates the application of the knowledge gained throughout this semester's courses. It demonstrates the design of a component-based system and the use of a self-hosted large language model.
== Future work
There are many improvements, which can be implemented in the future to enhance the system. In terms of clinical capability, the LLM could be expanded, so it looks at past patient history to propose contraindications or warn about possible allergy-related side affects. We could also make the AI use reinforcement learning, where the Doctor can rate the AI's responses to fine-tune the local model over time. Furthermore, AI could help out to assist the Doctor not only with making mistakes and prescribing but also in differential diagnosis.

For the front-end part of our project, we did not spend so much time on making it a very accessible platform, as our project is not a Booking platform, it's an AI service. However, we could extend it to add past consultation summaries and prescriptions after the fact, appointment reminders via the email service and a preconsultation form that the patient can fill out with symptoms to feed into the LLM context.

Furthermore, the speech-to-text (STT) component currently used in the system is not suited for horizontal scaling, because it cannot handle more than one audio file at the same time. We need to find a solution that is concurrent, either using a job queue or async transcriptions. This change would allow the parallel processing of the audio recordings making the waiting time less and the user experience smoother.

In conclusion, these improvements would greatly enhance user experience and the variety of features offered by our application and would make it one step closer to a real-world deployment.