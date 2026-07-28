+++
title = "Memorizing Verbatim Quotes With Interdependent Flashcards"
date = 2026-01-14
+++

## Problem

How can we elegantly memorize a quote like

> Because the sunset, like survival, exists only on the verge of its own disappearing. To be gorgeous, you must first be seen, but to be seen allows you to be hunted.
>
> — Ocean Vuong


## Solution Concept

1. _Spaced Repetition_ is probably great to learn how to remember quotes (_memoria verborum_)
2. However, memorizing a whole quote "in one go" is hard verging on impossible
3. To solve this, we can split the memorization process into parts; we will memorize the quote from back to front (_back-chaining_[^fluent-forever]), using _cloze deletion_ such as:
    - "Complete the missing part: _Because the sunset ＿＿＿＿_"
4. However, for that, we need multiple spaced repetition flashcards per quote to memorize, and need to learn them in a specific order (this is tedious to author, and the ordering is not supported by traditional software such as Anki[^is-it-possible])
5. So we design our own webapp supporting this use case...

## Screenshots

![A special authoring wizard allows generating a set of staggered flashcards with increasing difficulty.](/images/cms.png)
*A special authoring wizard allows to quickly generate a set of staggered flashcards with increasing difficulty.*

![Flashcards are practiced with a classic reveal-score flow.](/images/easier.png)
*Flashcards are practiced with a classic reveal-score flow.*

![Harder flashcards only appear once their prerequisites are practiced.](/images/harder.png)
*Harder flashcards will not come up in practice unless all their prerequisite flashcards are practiced (meaning they came up at least once and are currently not `due` according to the `ts-fsrs`[^ts-fsrs] algorithm).*


## Links

- [Repository](https://github.com/koljapluemer/karten)
- **[Webapp](https://sams-karten.netlify.app)**


[^fluent-forever]: Gabriel Wyner, _Fluent Forever: How to Learn Any Language Fast and Never Forget It_, 2014.
[^is-it-possible]: [Is it possible to link cards?](https://forums.ankiweb.net/t/is-it-possible-to-link-cards/13536), Anki Forums, 2021-09-21.
[^ts-fsrs]: [ts-fsrs](https://github.com/open-spaced-repetition/ts-fsrs)
