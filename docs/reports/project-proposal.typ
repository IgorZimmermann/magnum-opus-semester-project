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

#pagebreak()
= Architecture
This semester project will be structured using a layered architecture. Implementing a component-based system (CBS) framework focusing on modularity, replaceability & reusability. Components communicate via an API Gateway implementing a service orchestration pattern. 

  == Application Layer Diagram
  This section analyses the Application diagram, see @appLayer. Breaking down the individual layers of this layered architecture.

  #figure(
  image("../images/applicationLayer.jpg"),
  caption: "Application Layer Diagram", 
  ) <appLayer>

  === Frontend Layer
  
  The main responsibility of this layer is to act as an intermediate between the user and the backend services, by triggering API calls to the orchestration logic.

  - *User Portal (Next.js/Typescript):* Provides user interface for booking management and authentication for clients. Allows users to search for doctors, see availability and create/remove bookings
  - *Doctor Portal (Next.js/Typescript):*  Provides doctor interface for selecting bookings and starting consultation. Allows doctor to record consultation, edit transcription, accept/deny LLM generated suggestions and send prescription notes.
  
  === Gateway Layer

  The main responsibility of this layer is to route frontend requests to the corresponding backend services (e.g. logging in, booking creation, start consultation). This provides a centralised role-based authentication to protects backend endpoints. 

  - *Gateway (Next.js):* Provides an interface for backend access for the frontend.
  \
  === Application Layer:
  
  The main responsibility of this layer is the implementation of orchestration logic to coordinate workflows between services and databases.
  - *Authentication Manager:* Uses relational database to authenticate login requests
  - *Booking Orchestrator:* Uses relational database to read/write data whilst creating / removing bookings. Additionally uses the 'Secure Email' service to send booking confirmation to clients. 
  - *Consultation Manager:* Uses 'Speech To Text' service to transcribe consultation audio to text and write it into non-relational database. 
  - *Suggestive Orchestrator:* Reads consultation data from the non-relational database and forwards it to the 'LLM' service to create suggestions. Stores accepted LLM generated suggestions.
  - *Transcribe Editor Orchestrator:* Allows doctor to correct any transcription errors and rewrites them using 'LLM' service.
  - *Doctor Note Orchestrator:* Uses doctor apporved suggestions and consulation to create a doctor note using 'PDF Generator', 'LLM' and 'Secure Email' service.

  === Infrastructure Services:

  The infrastructure services exposed through stable HTTP interfaces provides specialised functions. These services are isolated Docker containers exposed via an HTTP interface for modularity and follow CBS framework. 
  - *Speech-to-Text (Faster-Whisper):* Transcribes audio files
  - *LLM Runtime (Ollama + model):* Ollama acts as an  intermediary between HTTP requests and the LLM. We have yet to decide on a specific model/s.
  - *PDF Generation (Typst):* Produces exportable PDF files.
  - *Secure Email (Mailpit):* Sends generated outputs to corresponding clients
  
  === Data Layer:

  The main responsibility of this layer is data persistence.
  - *Relational Database (PostgreSQL):* Stores structured data such as users, doctors and booking information. 
  - *Non-relational Database (MongoDB):* Stores unstructured data such as transcripts, accepted AI suggestions, AI summaries and generated doctor notes. 

  == Component-Based System Diagram
  The Component-Based System (CBS)  see @CBSE, illustrates how the system is structured into modular components with exposed interfaces. It can be broken down into three main layers: user interface, orchestrators/managers and services & databases. This design allows individual components to be independently developed and interchanged at runtime. 
  #figure(
  image("../images/CBSDiagram.png"),
  caption: "Component-Based System Diagram", 
  ) <CBSE>

  == Tech Stack
  #figure(
  caption: "Application tech stack",
  table(
  columns: 3,
  align: left,
  stroke: 0.5pt,
  inset: 6pt,

  [*Layer*], [*Technology*], [*Purpose*],

  [Frontend], [Next.js / Typescript], [User/Doctor interface],
  [Gateway], [Next.js], [API entry point & routing],
  [Application Services], [FastAPI], [Orchestration & business logic],
  [Speech-to-Text], [Faster-Whisper], [Audio transcription],
  [LLM Runtime], [Ollama + LLM models], [Local AI],
  [PDF Generator], [Typst], [PDF generation],
  [Email], [Mailpit], [Email sending],
  [Data], [PostgreSQL + MongoDB], [Un/structured storage],
  [Deployment], [Docker Compose], [Containerised services & networking],
  [CI (OPTIONAL)], [GitHub Actions], [Automated test & build checks],
)
)<tech-stack>
  
#pagebreak()
= Risks

- What poses a risk to the success of your project?
- What can you do to mitigate these risks?

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
