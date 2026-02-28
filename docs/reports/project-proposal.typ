#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Proposal",
  authors: json("../team-members.json"),
)

= Background and Motivation

Outpatient departments face outdated manual processes that drastically slow down operations and put burden on both sick patients and medical staff. Doctors and nurses spend too much time on paper schedules, taking notes during consultations, and separate systems for writing prescriptions, which causes long wait times, unsatisfied patient experience (due to the disrupted doctor focus), and errors, plus burnout from extra administrative work. These issues also create serious privacy risks for patient data, which demand strict precautions and careful handling. Our project is relevant because it offers a sollution for a clear gap: the need for simple AI tools that run entirely locally using open-source models, keeping all sensitive health information secure within the clinic's network. By automating the full process; from patient booking and real-time transcription to AI-generated clinical summaries, "safety-net" suggestions, and instant digital prescriptions; it helps healthcare facilities modernize quickly and affordably. This reduces mistakes, speeds up patient flow, and reliaves medical staff from the burden of endless paper work, allowing them to focus on delivering quality care and improve patient satisfaction.

= Aim

- Problem statement

= Objectives

- User stories

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
