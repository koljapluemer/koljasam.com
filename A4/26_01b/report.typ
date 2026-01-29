#set document(
  title: [Memorizing Verbatim Quotes With Interdependent Flashcards],
  author: "Kolja Sam",
)

#show link: underline

#title()

_by Kolja Sam Pluemer, 26-01-14_



#columns(2, gutter: 8pt)[
  = Problem

  How can we elegantly memorize a quote like

  #set quote(block: true)
  #quote(
    attribution: [Ocean Vuong],
  )[Because the sunset, like survival, exists only on the verge of its own disappearing. To be gorgeous, you must first be seen, but to be seen allows you to be hunted.]


  = Links

  - #link("https://github.com/koljapluemer/karten")[Repository]
  - *#link("https://sams-karten.netlify.app")[Webapp]*   #figure(image("qr.png", width: 2.5cm))


  #colbreak()
  = Solution Concept

  1. _Spaced Repetition_ is probably great to learn how to remember quotes (_memoria verborum_)
  2. However, memorizing a whole quote "in one go" is hard verging on impossible
  3. To solve this, we can split the memorization process into parts; We will memorize the quote from back to front (_back-chaining_ @fluent-forever), using _cloze deletion_ such as:
    - "Complete the missing part: _Because the sunset ＿＿＿＿_"
  4. However, for that, we need multiple spaced repetition flashcards per quote to memorize, and need to learn them in a specific order (this is tedious to author, and the ordering is not supported by traditional software such as Anki @is-it-possible)
  5. So we design our own Webapp supporting this use case...



]



= Screenshots

#columns(3, gutter: 8pt)[
  #figure(
    image("cms.png", height: 150pt),
    caption: [A special authoring wizard allow to quickly generate a set of staggered flashcards with increasing difficulty.],
  )

    #figure(
    image("easier.png", height: 150pt),
    caption: [Flashcards are practiced with a classic reveal-score flow.],
  )

      #figure(
    image("harder.png", height: 150pt),
    caption: [Harder flashcards will not come up in practice unless all their prerequisite flashcards are practiced (meaning they came up at least once and are currently not `due` according to the `ts-fsrs` @ts-fsrs algorithm).],
  )

]

  #set text(size: 8pt)
  #bibliography("lib.yml")
