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

#pagebreak()

= Risks

In this section we will identify potential risk and security factors

== Security

As this project will be used in professional medical environments, making sure that sensitive personal data is handled correctly is our top priority. 

To ensure this, we will be implementing two separate databases. Our PostgreSQL database will be used to store user data such as login, while our MongoDB database will be storing documents generated during the doctor-patient discussions, and doctor notes. 

This approach keeps sensitive data separate, even if one of the database is compromised, the other one will still be secure.

== Componized approach

The componentized architecture addresses the risk of a single point of failure. By breaking down the whole system into smaller components that are independent of each other we can ensure that if one fails, others can still function. This also allows to easily maintain, update and add new components without affecting the whole system.
