#import "../templates/research.typ": research

#show: research.with(
  topic: "TTS Benchmarking and Stress Testing",
  author: "David Borka",
)

== Introduction

This report summarizes the main outcomes of our stress and benchmark testing for the Speech-to-Text service powered by Faster-Whisper. The goal was to see how the model behaves under increasing load.

How the model works: request time is dominated by inference compute. When many requests arrive at once, requests wait in queue and latency rises. Despite error rate remaining stable, we can conclude there is no correlation between request volume and error rate. Thus, this implementation isn't horizontally scalable, but it is robust.

The full result files are available at research/TTS_test
=== Results

Main findings from the benchmark sequence:

- Reliability remained strong: #strong[0% failures] across all tested concurrency levels (1 to 24).
- Throughput saturated early at about #strong[0.42 requests/second] and did not increase meaningfully with higher concurrency.
- Latency increased sharply with concurrency:
  - Concurrency 1: about #strong[2.4s] mean latency.
  - Concurrency 8: about #strong[18.4s] mean latency.
  - Concurrency 24: about #strong[51.6s] mean latency, with p95 around #strong[57.4s].
- Recovery check returned close to baseline (about #strong[2.41s] mean at concurrency 1).

What this means is that the deployment is stable but capacity-limited. Increasing the workload mostly increases waiting time.

=== Conclusion

The service is reliable under stress, but quickly reaches the ceiling.

In summary, the current model deployment is suitable for stable low-concurrency operation (our use case essentially), and can serve as a strong baseline.

For future extension, we can work on improving scalability. 
