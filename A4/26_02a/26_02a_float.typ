#set document(

title: [A Screensaver-Style UI For Passive Flashcard Learning],

)
#show link: underline
#title()
_by Kolja Sam Pluemer, 26-02-05_

=  Problem

- Sometimes, active recall and the continuous choice of flipping another flashcard feels tedious
- In this case, we want to enable the learner to still learn a little, instead of quitting the application 

= Approach

- Multiple due flashcards simply float on the screen, allowing the learner to remember learning content, and perhaps make connections between learning content


    #figure(
    image("s.png"),
    caption: [Screenshot of the feature on desktop],
  ) <fig2>




= Links

  - #link("https://github.com/koljapluemer/karten")[Repository]
  - *#link("https://sams-karten.netlify.app")[Webapp]*)


= Future Work

- Testing the efficacy of this approach is very difficult, since we only have the coarsest of measures which cards the user actually studied. I would love some smart approach here.