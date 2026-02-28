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

= Initial Requirements

The following requirements define the core functionality of the project. The prioritization follows the MoSCoW method.

== Functional Requirements

- *MUST have*
  - The system shall allow patients to create, view and cancel appointment bookings.
  - The system shall provide secure login with role-based access for patients and doctors.
  - The system shall record and transcribe consultations locally using an open-source speech-to-text model.
  - The system shall generate a structured consultation summary and prescription using a locally hosted open-source LLM.
  - The system shall implement a “Suggestive Mode” that analyzes the transcript and flags potential missing clinical elements.
  - Doctors shall be able to review, edit and approve or reject AI-generated summaries and suggestions.
  - The system shall generate a PDF prescription after doctor approval.
  - The system shall send the approved prescription to the patient via a secure local email service.
  - The system shall store structured data (users, bookings) in a relational database.
  - The system shall store transcripts and AI-generated content in a non-relational database.

- *SHOULD have*
  - The system should log AI prompts and outputs for evaluation purposes.
  - The system should allow configurable instructions for the Suggestive Mode.

- *COULD have*
  - The system could allow doctors to upload diagnostic images as part of a consultation.
  - The system could provide simple statistics about number of consultations and bookings.

- *WON'T have*
  - The system will not use any cloud-based AI services.
  - The system will not include a mobile application.

== Non-Functional Requirements

- *Performance*
  - The system shall transcribe consultation audio with minimal delay under normal hardware conditions.
  - The system shall generate and deliver a PDF prescription within 5 seconds after approval.
  - Booking-related requests shall respond within 3 seconds under normal usage.

- *Portability*
  - The system shall run identically on Windows, Linux and macOS.
  - All components shall be containerized for consistent deployment.

- *Scalability*
  - The system shall support at least 5 concurrent consultations without service failure.
  - Each infrastructure service shall be independently replaceable without modifying other components.

- *Security*
  - All patient and consultation data shall remain within the local network.
  - User passwords shall be securely hashed before storage.
  - Role-based access control shall prevent unauthorized access to consultation data.

- *Reliability*
  - The system shall recover automatically from container failure.
  - No transcript or approved prescription shall be lost due to service interruption.

- *Testing Coverage*
  - Core backend logic shall include unit and integration tests.
  - At least 80% of core application logic shall be covered by automated tests.


= Methods

- Refer to Group Contract

= Architecture

- Tech stack, refer to Application Diagram

= Risks

- What poses a risk to the success of your project?
- What can you do to mitigate these risks?
