#import "../templates/research.typ": research

#show: research.with(
  topic: "LLM",
  author: "Dávid Borka",
)

= Researched options
- #link("https://ollama.com/library/qwen3:0.6b")[Qwen3:0.6b]
- #link("https://ollama.com/dcarrascosa/medgemma-1.5-4b-it")[Medgemma]
- #link("https://ollama.com/library/phi3.5")[Phi-3.5-mini]
- #link("https://ollama.com/sam860/LFM2:2.6b")[*Liquid AI*]
= Reason

From the researched options Liquid AI hits the sweet spot between the speed and the quality of the output. 

Qwen is the worst in terms of quality but it is the fastest. (avg. time: 3.51s). 

Medgemma and Mediphi provides great summaries and suggestions, but it can be redundant and they are slow in comparison (avg. time: 24.82s and 52s).

Liquid AI's quality is close to them, with less amount of raw text and with a way better generation time (avg. time: 6.35s).

= How to get started

1. You will need to have #link("https://ollama.com/")[Ollama] installed on your machine.

2. Then you will need to paste the following command in your terminal to install Ollama python library:
  ```bash
  pip install ollama
  ```

3. You will need to pull the model:
  ```bash
  ollama pull sam860/LFM2:2.6b
  ``` 

4. Now we can create a python file and run the model:
  ```bash
  from ollama import chat

  response = chat(
      model='sam860/LFM2:2.6b', # you can change this to any pulled model
      format='json',            # forced format for the response
      messages=[{'role': 'user', 'content': 'Hello!'}],
  )
  print(response.message.content)
  ```

= Interactivity

Once the transcript is made it is sent to the LLM through a POST request to Ollama HTTP as an input. It will generate a response and send it back. When the changes are made by the doctor, through the same process the doctor's note is made.

With the code `format='json'` we can force output format, but we need to tell the structure in the prompt. This is a constraint for the LLM not a suggestion, so it works reliably. It's also a good idea to have the input and the prompt in two separate text files, so it's easy to change.

Swapping will be easy, since we would only need to change the model name in the Ollama call.
