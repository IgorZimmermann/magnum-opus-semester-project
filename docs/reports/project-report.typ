#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Report",
  authors: json("../team-members.json"),
)

= Introduction

= Methodology

= Problem analysis

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

= Implementation

= Validation

= Conclusion

