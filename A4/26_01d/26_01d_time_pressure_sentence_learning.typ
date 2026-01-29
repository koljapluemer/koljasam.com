#set document(
  title: [Practicing Target Language Vocabulary With a Time-Pressure Sentence Cloze Game],
)

#show link: underline

#title()

   #set text(size: 9pt)


_by Kolja Sam Pluemer, 26-01-27_



#columns(4)[
  #figure(
    image("1.png"),
    caption: [Sentence challenge],
  ) <fig1>

#colbreak()



    #figure(
    image("2.png"),
    caption: [Reward for correct choice],
  ) <fig2>



#colbreak()

      #figure(
    image("3.png"),
    caption: [Correction after incorrect choice],
  ) <fig3>

#colbreak()


        #figure(
    image("4.png"),
    caption: [Main menu and end screen with score],
  ) <fig4>

]


#columns(2, gutter: 8pt)[


  =  Concept

The learner plays a round-based game where they have to correctly choose the answer for a clozed target language sentence.

1. A sentence is randomly chosen from a natural language database (in this case lisaanmasry @unknown2024egyptian), and clozed randomly (based on a string-splitting on whitespace). The learner sees the clozed sentence, the native language translation, and two answer options. The distractor is generated from the same language database, preferring words with a close-but-not-too-close Levenshtein distance (@fig1).
2. If the learner chooses correctly, they get points based on speed and a bit of bonus time (@fig2) on the game timer (which is initally 60 seconds and counts down during exercises).
3. If the learners selects the wrong answer, they incur a time penalty (which goes up on every error, ensuring the game ending) and see the correct sentence (@fig3).

After the game, players see their score and a personal scoreboard (@fig4).

  = Links
I implemented this concept for Egyptian Arabic:

  - #link("https://github.com/koljapluemer/basic-egyptian-sentences")[Repository]
  - *#link("https://basic-arabic-sentences.koljapluemer.com/")[Webgame]*  

#colbreak()


 = Advantages 

1. The single-choice buttons allow objective scoring (c.f. self-scoring in standard Spaced Repetition).
2. Embedding vocabulary practice in natural sentences allows using paradigms like data-driven learning (_extracting how language is used from a corpus_) and perceptual learning (_"seeing" that a word is right for a given context_).
3. The timer-based rounds form a neat, natural learning unit and foster a feeling of "being done" (c.f. the infinite slog of flashcard learning).
4. Randomness combined with the timer and score mechanic create a variable reward and a game experience that includes both luck and skill, encouraging replay.
5. The scoreboard clearly reflects increases of language proficiency over time.
6. Because the timer is always running, taking an action is encouraged (c.f. flashcard learning where each flip-and-score requires intentional action from the learner).
7. No specific scheduling algorithm is needed for fun gameplay.

= Drawbacks

1. The auto-generated distractors vary in difficulty and are not always well-chosen.
2. Learning is presumably less active and more focussed on recognition than production compared to e.g. traditional flashcard learning or output tasks.

]
   #bibliography("lib.bib")




