#set document(
  title: [Flow for Integrating Unordered List Memorization Into a Spaced Repetition Flashcard App],
  author: "Kolja Sam",
)

#show link: underline
  #set text(size: 9pt)

#title()

_by Kolja Sam Pluemer, 26-02-13_



#columns(2, gutter: 8pt)[
  = Problem

  *How can we elegantly memorize unordered lists (such as _The Ten Commandments_, _9 Planetary Boundaries_ or _countries in the EU_) with Spaced Repetition?*
    - being able to easily recite every item when prompted with the list title is the goal, but the list can't be memorized as a whole in one step
    - list items sometimes relate to each other and sometimes don't, so it's not obvious whether we can model each item as its own learning item
    - if we opt to prompt the learners to recall some elements of the list (e.g. "Here are items 1, 2 & 3; please remember 4 and 5"), we have a combinatorial explosion of possible exercises

  = Links

  - #link("https://github.com/koljapluemer/karten")[Repository]
  - *#link("https://sams-karten.netlify.app")[Webapp]*  

  #colbreak()
  = Solution Concept

  *A wizard creation tool to generate a limited, stepped-difficulty set of flashcards to memorize a given list*

  - I implemented the concept as a creation flow in my `karten` app, a web-based spaced repetition app.
    1. The learner inputs the list they want to learn as markdown. Items are automatically detected.
    2. The learner selects how many flashcards they want to generate for this list. 
        - One flashcard where only the list name is shown and every item is clozed is always included
        - The others are randomly chosen from all possibilities of cloze/show combinations and can be rerolled to find a balanced set
    3. The flashcards are automatically connected in blocking relationships, so that flashcards with more clozes —— harder ones — are only presented after easier ones are learned.
- The flashcards are then integrated into the flashcard app, to be practiced in the traditional reveal-and-score paradigm.

]



= Screenshots

#columns(2, gutter: 8pt)[

#figure(
image("s1.png", width: 220pt),
caption: [List Editing & Item Detection],
)


#figure(
image("s2.png", width: 220pt),
caption: [Setting up the desired number of flashcards],
)

#colbreak()


#figure(
image("s3.png"),
caption: [Visualization of flashcard relationships: Harder cards being blocked by easier cards],
)
]