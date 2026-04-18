#import "../templates/research.typ": research

#show: research.with(
  topic: "LLM Performance & Quality Testing",
  author: "Sean Larsen",
)

== Introduction

In this research testing topic I will be covering the quality and performance difference between two models of #link("https://ollama.com/sam860/LFM2:2.6b")[*Liquid AI*] and #link("https://ollama.com/library/gemma4:e4b")[*Gemma 4*] LLM models.

During development of this project we have already tested other models such as Qwen3, Medgemma, Phi-3.5-mini and Liquid AI. However with the recent gain of traction with Gemma 4 we will compare our current LLM model to see if its worth changing and to see the capability of both models.

In this testing it will be broken down into the following:

- Summary & suggestion quality assessment using ROUGE and BERTScore
- MedQA medical AI benchmark database

For each of these tests we will be also assessing the performance by measuring its latency and the token usage.


#pagebreak()
=== Summary & Suggestion - Assessment
In order to check the quality of the text generation of the LLM models, we will be giving the LLM models 10 fake transcripts varying in length, complexity and messiness. The output will then be assessed by ROUGE and BERTScore metric. It uses a reference containing key words and summaries to assess generated output.

During this it will be assessed on the following:
- ROUGE-1: counts individual word matches (higher the score the right words are there)
- BERTScore: rates the LLMs understanding of context (higher score means higher understanding)

To also take in count hardware usage, we will be comparing latency and token usage.

=== Summary & Suggestion - Results


*Gemma 4*

#table(
  columns: (auto, auto, auto, auto, auto),
  table.header([*Transcript*], [*Total Latency (s)*], [*Tokens/sec*], [*ROUGE-1*], [*BERTScore F1*]),
  [consult\_01], [289.88], [9.24], [0.563], [0.405],
  [consult\_02], [215.75], [9.03], [0.441], [0.328],
  [consult\_03], [307.35], [8.49], [0.513], [0.277],
  [consult\_04], [293.89], [7.21], [0.459], [0.268],
  [consult\_05], [218.74], [7.91], [0.361], [0.210],
  [consult\_06], [144.91], [7.47], [0.395], [0.268],
  [consult\_07], [309.78], [7.53], [0.578], [0.495],
  [consult\_08], [383.51], [6.99], [0.527], [0.450],
  [consult\_09], [216.92], [8.88], [0.515], [0.378],
  [consult\_10], [297.79], [8.83], [0.570], [0.334],
  [*Average*], [*267.85*], [*8.16*], [*0.487*], [*0.341*],
)

*Liquid AI *

#table(
  columns: (auto, auto, auto, auto, auto),
  table.header([*Transcript*], [*Total Latency (s)*], [*Tokens/sec*], [*ROUGE-1*], [*BERTScore F1*]),
  [consult\_01], [108.93], [13.93], [0.632], [0.441],
  [consult\_02], [85.33], [14.64], [0.519], [0.324],
  [consult\_03], [107.81], [12.73], [0.494], [0.335],
  [consult\_04], [114.97], [12.68], [0.611], [0.431],
  [consult\_05], [105.87], [13.43], [0.617], [0.398],
  [consult\_06], [113.07], [12.52], [0.496], [0.286],
  [consult\_07], [104.69], [12.97], [0.564], [0.431],
  [consult\_08], [124.92], [12.61], [0.563], [0.407],
  [consult\_09], [107.17], [14.03], [0.503], [0.372],
  [consult\_10], [131.29], [14.23], [0.627], [0.427],
  [*Average*], [*110.40*], [*13.38*], [*0.562*], [*0.385*],
)


=== Summary & Suggestion - Result evaluation

From the table above we can draw the following:
- LFM2 is significantly faster than gemma 4 of 110s vs 268s avg latency, making it more desirable for real-time clinical uses
- LFM2 scores higher on both ROUGE-1 and BERTScore, meaning it produces more accurate summaries with better contextual understanding.

Based on the results produced there is no good evidence of switching to Gemma 4 as all results indicate to better results with LFM2. Additionally LFM2 is a much smaller model of 2.6B params compared to the 4b of Gemma4.




#pagebreak()

=== MedQA benchmark - assessment

For this section of the testing we will be using MedQA, a trusted free database composed of over a thousand multiple choice questions used to test LLMs on medical questions. For this testing 50 out of the 1000+ was used.

=== MedQA benchmark - results

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  table.header([*Model*], [*Questions*], [*Correct*], [*Accuracy*], [*Avg Latency (s)*], [*Avg Tokens/sec*]),
  [Liquid AI LFM2], [50], [24], [48.0%], [15.38], [25.80],
  [Gemma 4], [50], [37], [74.0%], [80.97], [11.29],
)


=== MedQA benchmark - result evaluation

From the results above we can conclude the following:
- Gemma4 has a 26% greater accuracy than LiquidAI, meaning it's more capable of medical related questions
- LiquidAI had a avg latency of 5x quicker than Gemma4

Based on the results produced, there is better evidence that Gemma4 could be potentially used for more accurate diagnosis, however the slowness of Gemma4 must be accounted for in a real-time clinical environment.


#pagebreak()

=== Conclusion


Based on the results of the two tests, it can conclude that for the semester project the chosen LLM model will remain as LFM2.
Although Gemma 4 has produced better and more medical related output it generated worse outputs for summaries & suggestions. Additionally the latency and the large parameter of the model does not deem suitable for this real-time clinical environment.

However, we will keep this LLM model in mind for possible expansion of the project to image inputs (which Gemma4 can handle and LFM2 does not) or for more deep diagnosis systems for less real-time environments.
