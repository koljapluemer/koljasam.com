#set document(
  title: [A Sentence-Based Language Learning Application],
  author: "Kolja Sam"
)

#show link: underline

#title()

_by Kolja Sam Pluemer, 26-01-09_

(that is not much more cognitively exhausting than doom-scrolling)


#columns(2, gutter: 8pt)[

  = Idea

    1. Learner learns the vocabulary needed to understand a specific foreign language sentence
    2. Learner is challenged to translate the sentence
    3. Repeat

  = Tech

    - Sentences are sourced (mainly) from #link("https://tatoeba.org/en/")[Tatoeba]
    - Sentences were split into parts (=needed vocabuarly) and auto-translated via an LLM
    - The app itself is `Vue`+`TS`+`DaisyUI`+`Tailwind` with `JSON` files as data source
    - Data preparation was done in `python`

    = Links
    - #link("https://github.com/koljapluemer/infinite-sentences-frontend")[frontend repository], #link("https://github.com/koljapluemer/glosses4learning-py-tools")[data prep repository], #link("https://github.com/koljapluemer/infinite-sentences-data")[data repository]
    - *#link("https://infinite-sentences.netlify.app/learn")[Infinite Sentences Webapp]*
#colbreak()

    = App Flow

    #figure(
      image("state.svg", width: 100%),
      caption: [Simplified flow of the software.],
    ) <glacier>



]



= Screenshots

#columns(4, gutter: 8pt)[

  #figure(
    image("mem.png", height: 150pt),
    caption: [Prompt to memorize the meaning of a word.],
  ) <glacier>

  #colbreak()
  #figure(
    image("interact.png", height: 150pt),
    caption: [Interactive task to figure out the meaning of a word.],
  ) <glacier>

  #colbreak()
  #figure(
    image("sr.png", height: 150pt),
    caption: [Evaluation screen of Spaced Repetition practice. Words are practiced until the right gets them right.],
  ) <glacier>

  #colbreak()
  #figure(
    image("final_revealed.png", height: 150pt),
    caption: [Sentence translation challenge after reveal.],
  ) <glacier>

  #colbreak()


]

= Evaluation

Works pretty well and is decently fun.
It does get a bit boring, because there rarely is a fun or unexpected "event" happening.
Long-term retention is questionable, since sentences are not repeated after "solving" them once.
