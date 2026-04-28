#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Report",
  authors: json("../team-members.json"),
)

= Introduction

= Methodology

= Problem analysis

= Requirements

= Design

== System architecture

This semester's project was designed with layered architecture in mind, implementing a component-based system (CBS) design approach focusing on modularity, replaceability and reusability. Components communicate via REST calls, shared databases and services.

=== Application layer diagram

The original design remained largely unchanged from the initial architecture sketch, consisting of two frontends, two backends and two databases. Direct REST calls were chosen instead of introducing an additional API gateway layer. The diagram illustrates how the components are connected and how they map to the individual layers of the overall architecture.

See @application_layer_diagram.
#appendix(
  <application_layer_diagram>,
  image(
    "../images/ApplicationDiagram.jpg",
  ),
  "Application Layer Diagram",
)

=== Two monolithic backend approaches

At an early stage, a microservices architecture was evaluated as an alternative to a monolithic approach. Although microservices would align with the component-based design goals, the overall system scope and project size made a monolithic structure a better fit for this implementation. \

In addition, two separate backends were defined for the two primary use cases. This separation improves reliability, since a failure in one backend does not necessarily affect the availability of the other.

=== Component-Based System Diagram

The Component-Based System (CBS), see @component_based_system_diagram, illustrates how the system is structured into modular components with exposed interfaces. It can be broken down into three main layers: frontend, backend, and services/databases. This design allows individual components to be independently developed and interchanged at runtime.

#appendix(
  <component_based_system_diagram>,
  image(
    "../images/CBSE2.drawio.svg",
  ),
  "Component-Based system diagram",
)
== Tech stack

The choices we made were along the lines of: familiarity with a language, framework or model over technical suitability reduces the learning curve. However, we did research for each layer, and each member evaluated and made a choice based on which technology fits our group and project the best. Faster-Whisper came out as the most reliable in testing, with high transcription accuracy and acceptable speed, when compared to MedASR and NVIDIA Canary Qwen. For documentation, presentation and meeting logs, we used Typst, so it made for the perfect PDF generator. The LLM model was decided on with testing as well; with LFM2 from LiquidAI, it was faster and a better fit overall compared to Qwen3, Phi-3.5 and Medgemma.

#table(
  columns: 3,
  align: left,
  stroke: 0.5pt,
  inset: 6pt,

  [*Layer*], [*Technology*], [*Purpose*],

  [Frontend], [Next.js / TypeScript], [User/Doctor interface],
  [Backend], [C\# - ASP.NET], [Orchestration & business logic],
  [Speech-to-Text], [Faster-Whisper], [Audio transcription],
  [LLM Runtime], [Ollama + LLM models], [Local AI],
  [PDF Generator], [Typst], [PDF generation],
  [Email], [Mailpit], [Email sending],
  [Data], [PostgreSQL + MongoDB], [Un/structured storage],
  [Deployment], [Docker Compose], [Containerized services & networking],
)

Application tech stack

== Frontend

The frontend design was based on the user flows; see @activity_booking and @activity_doctor. We decided not to go into detail with the frontend, as the requirements were flexible regarding styling. There are two different frontends with two separate authentications and backends. This was done separation of concerns and independent deployability in mind.


#appendix(
  <activity_booking>,
  image(
    "../images/ActivityBooking.drawio.svg",
  ),
  "Activity diagram for booking consultations",
)



#appendix(
  <activity_doctor>,
  image(
    "../images/ActivityDoctor.drawio.svg",
  ),
  "Activity diagram for Doctors' dashboard",
)

== Backend architecture.

=== Booking backend

The booking backend was designed as a small ASP.NET service. The architecture is organised into layers: controllers, services, interfaces for the services and the data layer. The controllers only handle HTTP requests, and the actual business logic is being handled by separate services. This backend only uses the relational database for straightforward relational queries. We landed on this structure because of the abstraction it provides using interfaces and APIs, which makes the system easier to maintain and keeps the business logic loosely coupled from the data layer.

See the @uml_booking_backend.

#appendix(
  <uml_booking_backend>,
  image(
    "../images/UMLv2.drawio.svg",
    width: 100%,
  ),
  "UML diagram of the booking backend",
)

=== Consultation backend

The consultation database, nicknamed Heimdall, generally uses the same principle, going through the whole user flow from starting a consultation, then summarising, and finally outputting a PDF sent by email. It also separates the HTTP calls, business logic and the data layer. However, in contrast to the previously mentioned backend, it uses two databases: a relational one for structured data and a non-relational one for document-style data. The matching of each storage type and also the integrations behind interfaces make this backend easier to extend or replace in the future


== Database design

#appendix(
  <relational_database_er>,
  image(
    "../images/relational_database.drawio.svg",
  ),
  "Relational database Entity Relationship Diagram",
)

As previously mentioned, we have two different kinds of databases. One of them is the relational database, PostgreSQL in our case, for the structured data and the non-relational, MongoDB, for the document-style data. We decided to go with this design so that PostgreSQL can handle transactional records where consistency, relations and constraints are important, while MongoDB is a better fit for generated documents such as transcripts and summaries, all the while being faster and more flexible than its relational counterpart.

See @relational_database_er.
= Implementation

= Validation

= Conclusion

