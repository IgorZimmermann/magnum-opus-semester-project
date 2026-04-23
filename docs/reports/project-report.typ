#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Report",
  authors: json("../team-members.json"),
)

= Introduction
This report documents the work of this semester's project, a privacy-preserving OPD (Outpatient Department) management system. The project relies on skills gathered from this semester's subjects to provide a working solution for managing consultations in clinical environments, from booking to AI-assisted prescription.

The system consists of a web application that lets patients handle appointment booking and lets doctors control the consultation workflow: audio recording, transcription, AI-generated summary and suggestions, and finally, delivery of the doctor's note by email.

Components are connected through well-defined interfaces, and the locally run AI model that  no patient data ever leaves the clinic's network. The project showcases how a component-based design, a local LLM, and a containerized infrastructure can work together in a privacy-sensitive environment.
== Motivation
Outpatient departments spend the majority of their time on administrative work rather than focusing on patient care. Managing appointments on paper, taking notes during consultations, and writing prescriptions in separate tools all contribute to staff burnout. As a consequence, patients suffer from longer waits and less focused consultations.

AI-based tools can be used to ease this workload. However, the solution must not rely on cloud services. Since patient records are sensitive by nature, regulations require that they stay under the control of the facility that holds them.

This project addresses these problems by creating a system that automates the entire clinical workflow from appointment booking to digital prescription while everything is kept local.
== Objective
The project's aim is to deliver a working OPD management system that supports patients' and doctors' everyday workflows. The system's design lets patients easily book and manage appointments with the help of a simple interface, as well as providing doctors a way to record consultations, and easily create a prescription with the locally stored data without it ever leaving the clinic's infrastructure.

To achieve this, the project's structure provides the following core capabilities:

*Appointment Management:*
Patients are able to register, log in, search for doctors, and create or cancel bookings.

*Audio Recording and Transcription:*
Doctors begin and conclude consultations from their portal. The system records the audio and passes it to a local Faster-Whisper service for transcription.

*AI-Generated Summaries and Suggestions:*
A locally hosted LLM, served through Ollama, processes the transcript and produces a structured consultation summary. A "Suggestive Mode" then analyses the summary and flags potentially missing clinical elements, such as overlooked medications and / or referrals.

*Doctor Review and Prescription*: Doctors can edit the AI-generated summary, after which the suggestions and prescription are created. The latter will be validated and edited as needed with the help of the former. Finally, the prescription is exported as a PDF and sent to the patient via email.


= Methodology

= Problem analysis

= Requirements

= Design

= Implementation

= Validation

= Conclusion

