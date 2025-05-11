---
layout: post
title: "Occlumask: A Content-based Anonymity Leak Detector"
author: Alice Margatroid
tags: [News]
---

A few weeks ago, we [announced funding]({{ "/2025/03/30/namecoin-tls-anonymity-research-funding-power-up-privacy-nlnet-ngi0-core.html" | relative_url }}) from Power Up Privacy for a number of different projects. One of those projects being "Occlumask". We will be giving some details about Occlumask, the motivations behind it, its methods, challenges, as well as the current status on research.

## What is Occlumask?

Occlumask is an LLM-based tool for detecting content-based anonymity leaks. It is currently built off of the `llama.cpp` inference engine, running a local LLM instance. We are intending it to mainly be used in the context of chat messaging, forum posting or any other personal writing situation.

## Occlumask Motivations

De-anonymization remains a pressing issue for privacy conscious users. To that end, there are many things a prospective anonymous person needs to keep track of to keep their identities hidden. Some of you may be familiar with stylometric analysis, where writing style preferences can be used to identify the writer of a text. Tools for obfuscating stylometry, such as [Anonymouth](https://github.com/psal/anonymouth), have existed for a long time. However, stylometry is only one axis of de-anonymization. Even if your stylometry is perfectly obfuscated, the content of your text can give your identity away. 

A lot of information, even piecemeal, can be used to identify you (See [Always Withhold your Identifying Data]({{ whonix_url }}/wiki/Tips_on_Remaining_Anonymous#Always_Withhold_your_Identifying_Data) on the Whonix wiki for a non-exhaustive list). Famously, Jeremy Hammond was linked to the [2012 Stratfor email leak](https://www.justice.gov/archive/usao/nys/pressreleases/March12/hackers/hammondjeremycomplaint.pdf) through various snippets of personal anecdotes posted in IRC. Keeping in mind human error, it becomes difficult to ensure that one follows all these rules. Occlumask aims to be an aide in this process, catching any lapses in judgment.

## LLM Use Reasoning

Classification has been a long-standing use case for machine learning, and so it would follow naturally to use machine learning models to "classify" if a text is de-anonymizing. Neural networks have already been used in stylometric obfuscation in [ALISON](https://github.com/EricX003/ALISON). LLMs present an interesting opportunity with their unique natural language comprehension capabilities. The increased ability for understanding context in particular allows for more accuracy, differentiating between significant and insignificant mentions of potential identifiers. For example, "[City] has terrible weather" vs. "[City] is well known for its cheeses".

## Challenges With Occlumask

The difficulties involved with using are both in the overall accuracy of the program, as well as the performance. LLMs are, to oversimplify, effectively non-deterministic. There is no guarantee that it will be completely correct in determining the presence of an anonymity leak. A large part of this project will be reducing uncertainty. Keep in mind that Occlumask is an aide, not a replacement for proper privacy practices.

Running an LLM locally is also computationally expensive. Occlumask is planned to allow for any `GGUF`-formatted model. This lets you run less demanding models (i.e. ones with fewer parameters or with more extreme quantization), in exchange for lower quality of output. We also want to minimize the amount of inference any given model does. As such, Occlumask won't suggest any changes to your writing. **It will only warn you that your text has an identity leak, how you handle it is up to you.**

That being said, we still believe that Occlumask is a useful tool (otherwise we wouldn't be making it!). It will still be reducing the amount of identity leaks that happen, and we will be working on reducing that amount as much as possible.

## Current Progress

We are currently in the prompt engineering phase, getting the LLM to produce the outputs that we want, with an acceptable level of consistency. To this end, we are also collecting example texts to test our program on. So far the results have been promising, with the LLM being able to correctly identify what and why a section of identifying text is as well as surprising us on one occasion, with a potential identifier that none of us could find before Occlumask flagged it for us.

This work is funded by Power Up Privacy.