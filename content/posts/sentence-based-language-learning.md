+++
title = "A Sentence-Based Language Learning Application (that is not much more cognitively exhausting than doom-scrolling)"
date = 2026-01-09
+++

## Idea

1. Learner learns the vocabulary needed to understand a specific foreign language sentence
2. Learner is challenged to translate the sentence
3. Repeat

## Tech

- Sentences are sourced (mainly) from [Tatoeba](https://tatoeba.org/en/)
- Sentences were split into parts (=needed vocabulary) and auto-translated via an LLM
- The app itself is `Vue`+`TS`+`DaisyUI`+`Tailwind` with `JSON` files as data source
- Data preparation was done in `python`

## Links

- [frontend repository](https://github.com/koljapluemer/infinite-sentences-frontend), [data prep repository](https://github.com/koljapluemer/glosses4learning-py-tools), [data repository](https://github.com/koljapluemer/infinite-sentences-data)
- **[Infinite Sentences Webapp](https://infinite-sentences.netlify.app/learn)**

## App Flow

![Simplified flow of the software.](/images/state.svg)
*Simplified flow of the software.*

## Screenshots

![Prompt to memorize the meaning of a word.](/images/mem.png)
*Prompt to memorize the meaning of a word.*

![Interactive task to figure out the meaning of a word.](/images/interact.png)
*Interactive task to figure out the meaning of a word.*

![Evaluation screen of Spaced Repetition practice.](/images/sr.png)
*Evaluation screen of Spaced Repetition practice. Words are practiced until the right gets them right.*

![Sentence translation challenge after reveal.](/images/final_revealed.png)
*Sentence translation challenge after reveal.*

## Evaluation

Works pretty well and is decently fun.
It does get a bit boring, because there rarely is a fun or unexpected "event" happening.
Long-term retention is questionable, since sentences are not repeated after "solving" them once.
