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

In this section we will identify potential risk and security factors. As this project will be used in professional medical environments, making sure that sensitive personal data is handled correctly is our top priority.

== Security

To ensure this, we will be implementing two separate databases. Our PostgreSQL database will be used to store user data such as login, while our MongoDB database will be storing documents generated during the doctor-patient discussions, and doctor notes. 

This approach keeps sensitive data separate, even if one of the database is compromised, the other one will still be secure.

Our system will be locally hosted including the LLM, which means no data will be sent to external servers, further reducing the risk of data breaches.

Our API gateway will implement JWT token authentication, so unauthorized access attempts will be rejected, before they can reach the services. Authentication and authorization will be handled by the Authentication Manager component which will be responsible to ensure that users can only access appropriate data based on their permissions.

== Componentized approach

The componentized architecture addresses the risk of tight coupling. By breaking down the whole system into smaller components and separating responsibilities, we can ensure that if one fails, others can still function. This approach also allows us to easily find issues and replace components without affecting the whole system. 

To achieve this we will be using Docker containerization, to isolate each component. This allows us to scale components as needed, and run health checks and automatic recovery. This would mean we could periodically check the availability of components and automatically restart them if they fail to respond, reducing downtime and improving reliability. 
