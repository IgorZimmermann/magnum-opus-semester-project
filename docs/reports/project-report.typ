#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Report",
  authors: json("../team-members.json"),
)

= Introduction
This report documents the work of this semester's project, a privacy-preserving OPD (Outpatient Department) management system. The project relies on skills gathered from this semester's subjects to provide a working solution for managing consultations in clinical environments, from booking to AI-assisted prescription.

The system consists of a web application that lets patients handle appointment booking and doctors to control the consultation workflow: audio recording, transcription, AI-generated summary and suggestions, and finally doctor's note delivery by email.

Communication between components goes through well-defined interfaces, and the  AI model used is run locally so no patient data ever leaves the clinic's network. The project showcases how component-based design, local LLMs, and containerized infrastructure work together in a privacy-sensitive environment.

== Motivation
Outpatient departments spend a large part of their time on administrative work rather than patient care. Managing appointments on paper, taking notes during consultations, and writing prescriptions in separate tools all add friction, and contribute to staff burnout. As a consequence, patients suffer from longer waits and less focused consultations.

AI-based tools could ease this workload. However, the solution needs to not rely on cloud services, which pose a problem when dealing with medical data. Patient records are sensitive by nature, and regulations require that they stay under the control of the faciltiy that holds them.
This project addresses these problems by creating a system that automates the entire clinical workflow from appointment booking to digital presription while everything is kept local.

== Objective
The project's aim is to deliver a working OPD management system that supports patients and doctors' everyday workflow. The system's design lets patients easily book and manage appointments with the help of a simple interface, as well as providing doctors a way to record consultations, and easily create a prescription with the locally stored data without it ever leaving the clinic's infrastructure.

To achieve this, project's structure provides the following core capabilities:

*Appointment Management:*
Patients can register, log in, search for doctors, and create or cancel bookings through a dedicated portal.

*Consultation Recording and Transcription:*
Doctors begin and conclude consultations from their portal. The system records the audio and passes it to a local Faster-Whisper service for transcription.

*AI-Generated Summaries and Suggestions:*
A locally hosted LLM, served through Ollama, processes the transcript and produces a structured consulation summary. A "Suggestive Mode" then analyses the summary and flags potentially missing clinical elements, such as overlooked medications and/or referrals.

*Doctor Review and Transcription*: Doctors can edit the AI-generated summary, thereafter the suggestions and prescription are created. The latter will be validated / edited as needed with the help of the former. Finally the prescription is exported as a PDF and sent to the patient via email.

= Methodology

= Problem analysis

= Requirements

= Design

= Implementation

= Validation

= Conclusion

