#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Proposal",
  authors: json("../team-members.json"),
)

= Background and Motivation

- Refer to Project Description Word document

= Aim

- Problem statement

= Use cases

== Booking process
- Primary actor (user)
  - Patient 
- Preconditions
  - Patient is registered in the system
  - Patient has valid login credentials
- Goal
  - Book a consultation with a doctor
- Flow
  - User navigates to client website
  - User logs in
  - User selects a preferred doctor from the availability list
  - The system displays available time slots
  - The user books an available appointment
  - The user gets redirected to a dashboard where they can:
    - See their booking(s)
    - Remove their booking(s)
  - The system sends an email as a confirmation

== Users interacting during consultation process
  - Primary actor (user)
    - Doctor
  - Secondary actor
    - Patient
  - Preconditions
    - Appointment exists in the system
    - Doctor has valid credentials
  - Goal
    - Doctor and patient discuss the issues
    - Doctor identifies symptoms, concludes a diagnosis and if necessary prescribes medicine and refers to other department
    - The system internally processes the audio and transcribes the consultation
  - Flow
    - User navigates to the doctor website
    - User logs in
    - The system display a dashboard with todays bookings related to the user
    - The user selects the appropriate appointment
    - The user presses start consultation
    - The system starts the audio recording
    - The system waits until the user presses end consultation
    - Audio recording is stopped and sent to process by the speech-to-text component

== Review and send doctors note to patient
  - Primary actor (user)
    - Doctor
  - Preconditions
    - Consultation recording completed and successfully transcribed
  - Goal
    - Review AI-generated documentation, validate clinical suggestions and send final doctors note
  - Flow
    - The system generates a summary based on the transcription
    - The system displays the consultaions dashboard:
      - Raw transcription
      - Transcription summary
    - User has the ability to either edit or accept both documents
    - If the user edits the raw transcription
      - Summary is regenerated
    - If the user edits the summary
      - Nothing is regenerated
    - When both documents are accepted the system generates suggestions based on the transcription
    - Suggestions includes:
      - Medicine
      - Referral to other departments
    - The system displays suggestions
    - User has the ability to accept or decline the suggestions
    - The system generates a doctors note
    - The doctors note is solely based on:
      - Transcription
      - Summary
      - Accepted suggestions
    - The doctors note includes:
      - Symptoms
      - Diagnosis
      - Prescriptions
  


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
