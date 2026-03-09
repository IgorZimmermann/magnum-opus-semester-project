#import "../templates/research.typ": research

#show: research.with(
  topic: "Authentication",
  author: "Igor Zimmermann",
)

= Researched options
- #link("https://firebase.google.com/docs/auth")[Firebase Authentication]
- #link("https://better-auth.com")[Better Auth]
- *#link("https://auth0.com/")[Auth0]*

= Reason

Better Auth, although a great authentication framework, only works with Typescript. Another downside is that it is self-hosted, thus does not meet many medical SSO standards.

Firebase Authentication is a hosted service and has an API and SDKs for virtually any language/framework combination, but again does not meet medical SSO standards.

Auth0 on the other hand is a hosted service, has APIs and SDKs for any language/framework combination AND has certificates and compliance with the major medical SSO standards.

= How to get started

Check out the quickstarts at #link("https://auth0.com/docs/quickstarts")[Auth0 Docs].

= Interactivity

Other components (backend) would interact with Auth0 using their SDK specific to the language/framework we choose.
