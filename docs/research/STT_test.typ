#import "../templates/research.typ": research

#show: research.with(
  topic: "STT Benchmarking and Stress Testing",
  author: "David Borka",
)

== Introduction

This report summarizes the main outcomes of our stress and benchmark testing for the Speech-to-Text service powered by Faster-Whisper. The goal was to see how the model behaves under increasing load.

The full result files are available at research/STT_test

=== Test methodology

The test was made through a benchmark test file, which:
- loads the audio file
- sends copies of the requests to the API, varying how many run at the same time
- tracks request failures
- reports performance statistics

We ran four test phases in sequence:

1. *Baseline Test* (concurrency 1-2, 30 requests each): Low load scenario to establish normal performance.
2. *Ramp Stress Test* (concurrency 1-16, 100 requests each): Gradually increase pressure to find where performance degrades.
3. *Peak Stress Test* (concurrency 20-24, 120 requests each): Maximum pressure to see how the service handles extreme load.
4. *Recovery Test* (concurrency 1, 30 requests): Return to low load to see if the service recovers to baseline performance.

The test was performed using a single audio file from the test dataset (`src/test.wav`).

=== Definitions

*Concurrency:* The number of requests sent to the API at the exact same time. So how many "people" are using it at the same time.
*Throughput (requests/second):* How many audio files the service can successfully process per second on average.

*Latency (response time, in seconds):* How long a user waits from sending an audio file until they receive the transcribed text back. Lower is better.

*Mean Latency:* The average response time across all requests in a test.

*p95 Latency:* The 95th percentile response time. This means 95% of requests finish faster than this time, and only 5% take longer. It shows how slow the slowest requests get.

*Failure Rate:* The percentage of requests that failed (error responses instead of successful transcription).

*Recovery Check:* After running the heavy stress tests, we run a low-load test again to see if the service returns to its original speed. If it does, the service is not permanently degraded by stress.

=== Results

The following table shows the key performance metrics from each test phase:

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  [*Test Phase*], [*Concurrency*], [*Requests*], [*Throughput (req/s)*], [*Mean Latency (s)*], [*Failure Rate*],
  
  [Baseline], [1], [30], [0.401], [2.49], [0%],
  [Baseline], [2], [30], [0.398], [4.94], [0%],
  
  [Ramp], [1], [100], [0.416], [2.40], [0%],
  [Ramp], [2], [100], [0.417], [4.78], [0%],
  [Ramp], [4], [100], [0.420], [9.38], [0%],
  [Ramp], [8], [100], [0.420], [18.38], [0%],
  [Ramp], [12], [100], [0.421], [26.93], [0%],
  [Ramp], [16], [100], [0.420], [35.20], [0%],
  
  [Peak], [20], [120], [0.420], [43.85], [0%],
  [Peak], [24], [120], [0.420], [51.64], [0%],
  
  [Recovery], [1], [30], [0.415], [2.41], [0%],
) 

=== Conclusion

The service is reliable under stress, but quickly reaches the ceiling.

How the model works: request time is dominated by inference compute. When many requests arrive at once, requests wait in queue and latency rises, but both the error rate and throughput remained stable, so we can conclude there is no correlation between request volume and error rate. Thus, this implementation isn't horizontally scalable, but it is robust.

In summary, the current model deployment is suitable for stable low-concurrency operation (our use case essentially), and can serve as a strong baseline.

For future extension, we can work on improving scalability. 
