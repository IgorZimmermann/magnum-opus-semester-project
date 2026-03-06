#import "../templates/research.typ": research

#show: research.with(
  topic: "LLM",
  author: "Dávid Borka",
)

= Researched options
- #link("https://ollama.com/library/qwen3:0.6b")[Qwen3:0.6b]
- #link("https://ollama.com/sam860/LFM2:2.6b")[Liquid AI]
- #link("https://ollama.com/library/phi3.5")[Phi-3.5-mini]
- #link("https://ollama.com/sam860/LFM2:2.6b")[*Liquid AI*]
= Reason

From the researed options Liquid AI hits the sweet spot between the speed and the quality of the output. 

Qwen is the worst in terms of quality but it is the fastest. (avg. time: 3.51s). 

Medgemma and Mediphi provides great sumaries and suggestions, but it can be redundant and they are slow in comparison (avg. time: 24.82s and 52s).

Liquid AI's quality is close to them, with less amount of raw text and with a way better generation time (avg. time: 6.35s).

= How to get started

1. You will need to have #link("https://ollama.com/")[Ollama] installed on your machine.

2. Then you will need to paset the following command in your terminal to install olama python library:
  ```bash
  pip install ollama
  ```

3. you will need to pull the model:
  ```bash
  ollama pull sam860/LFM2:2.6b
  ``` 

4. Now we can create a python file and run the moddel:
  ```bash
  from ollama import chat

  response = chat(
      model='sam860/LFM2:2.6b', # you can change this to any pulled model
      messages=[{'role': 'user', 'content': 'Hello!'}],
  )
  print(response.message.content)
  ```

= Interactivity

Once the transcrip is made it is sent to the LLM through a POST request to Olama HTTP as a prompt. It will genarate a response and send it back.
When the changes are made by the doctor, through the same procces the doctor's note is made.

Swaping will be easy, since we would only need to change the model name in the Olama call.
