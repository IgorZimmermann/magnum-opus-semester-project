#import "../templates/research.typ": research

#show: research.with(
  topic: "Backend",
  author: "Örs Tomaj Jeney",
)

= Researched options
- #link("https://example.com")[Microservices architecture]
- #link("https://example.com")[*Two monolithic backends*]
- #link("https://example.com")[Hono framework]
- #link("https://example.com")[*Object oriented language*]
- #link("https://example.com")[Python]

= Reason

First and foremost, when we talk about the backend we only mean the layer between the third-party components and the user interface. The microservices such as LLM, pdf generator, speech to text, and databases not included.

Microservices architecture is an approach to developing software applications as a collection of small, independent services that communicate with each other over a network. Instead of tightly integrating functionality, the application is broken down to smaller loosely coupled services. It gives the flexibility of a variety of programming languages and frameworks, to use and also the fact that the mini-apps can be different than others. Benefits include: easy to scale horizontally, individual services can be deployed separately and flexibility from other services. However, the downsides include: development is more complex due to multiple services, requires more effort to manage multiple services and communication could be corrupted or slowed down due to network calls.

On the other hand a monolithic (in our case two of them) approach in which the entire program is constructed as a single, indivisible unit. Any changes or updates to the application require modifying and redeploying the entire monolith. Monolithic architectures are often characterized by their simplicity and ease of development, especially for small to medium-sized applications. However, they can become complex and difficult to maintain as the size and complexity of the application grow. It is built as one large application with tightly coupled components. Scaling can be challenging but as our project's backend is only for handling the communication between the other microservices, its not a downside for us. The limitation that we will face (talked about later) is the technology stack's choice which is limited due to the structure. The last downside is that if one single part fails in the system the entire application goes down. The choice of having two backends tries to fix this. This way clients can still login and book appointments if the third party services fail.

Hono is a minimal TypeScript framework deisgned for edge runtimes and small APIs. It  intentionally gives freedom for the architecture convention. However, due to many people's missing knowledge in this field we will not choose this, despite the recommendation of the Scrum Master. 

Java with spring boot is used in many systems and proved itself. It has many libraries, including security and data access. However the team is inexperienced with this one as well and also developing for a such a short term this might not be the best choice.

Python with FastAPI was recommended in the beginning with the project kickoff. Not only does the team have experience with python but the language allows us to use machine learning services such as LLM and Speech-to-Text. However as the architecture shows us, these are external HTTP services the backend simply calls the REST APIs. So the ML advantage disappears and pythons dynamic typing makes it harder to scale and debug in our "bigger" project.

Csharp (possibly ASP.NET) is the chosen option. It has rich ecosystem, fast performance and strong typing safety. Also the object oriented part gives the benefit of the four principles: encapsulation, inheritance, polymorphism, and abstraction. The squad also has experience with the language and OOP as well. The downsides inlcude memory footprint, support outside of the microsoft ecosystem, complexity for simple problems and tight coupling. I feel like these could be avoided with thorough and careful planning.


= How to get started

1. Define two backend projects in a repository
2. Plan the container orchestration using docker
3. Initialise each backend independently with its own package/dependency file
   and its own entry point using docker containers
4. Define a shared interfaces folder for the contract types so the frontend and the service api calls remain consistent and componentised.
5. Draw a UML diagram
6. Think about required libraries and services


= Interactivity

The frontend, database and third-party services can interact with the backend using interfaces defined by the component diagram. 
#figure(
  image("../images/CBSE2.drawio.svg"),
  caption: "Interaction between the two backends and the rest of the application",
) <snoop>
