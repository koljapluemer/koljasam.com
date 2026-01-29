#set document(
  title: [Integrating LLM-Generated Flashcards as an Adhoc Measure Into a Spaced Repetition Flow],
  author: "Kolja Sam",
)

#show link: underline

#title()

_by Kolja Sam Pluemer, 26-01-21_



#columns(2, gutter: 8pt)[
  = Problem

  1. _Spaced Repetition_ is highly effective, but a given flashcard can only be effectively memorized when it is understood @effective-learning-twenty-rules-of-formulating-knowledge.
  2. When the learner hits as flashcard they don't "get", how do we rectify this without totally disrupting the practice flow?

  = Links

  - #link("https://github.com/koljapluemer/karten")[Repository]
  - *#link("https://sams-karten.netlify.app")[Webapp]*  

  #colbreak()
  = Solution Concept

  1. Integrate the `Confused` option as an answer option after flipping a given flashcard
    - This scores the flashcard as `Again` (using `ts-fsrs` @unknown2026tsfsrs)
    - It also opens a wizard flow which generates flashcards that add context or required knowledge
  2. The newly generated flashcards must be learned _before_ the original flashcard is shown again.  


]



= Screenshots

#columns(3, gutter: 8pt)[
  #figure(
    image("1.png", height: 250pt),
    caption: [The `Confused` option alongside the standard Spaced Repetition buttons. Here, the learner may be confused what "currying" is and why it matters, and in which context. Clicking `Confused` triggers the generation modal.],
  )

    #figure(
    image("2.png", height: 250pt),
    caption: [First step of the generation modal. Basic prompt management allows customizing what kind and how many flashcards will be generated.],
  )

      #figure(
    image("3.png", height: 250pt),
    caption: [The generated flashcards. The user may accept or discard each and is then send back to the normal practice flow.],
  )

]

  #set text(size: 8pt)
  #bibliography("lib.bib")
