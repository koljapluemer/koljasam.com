#set document(

title: [A Webapp to Practice Mental Currency Conversion],

)
#show link: underline
#title()
_by Kolja Sam Pluemer, 26-01-29_
#columns(2, gutter: 8pt)[

#columns(2)[

#figure(

image("1.png"),

caption: [Intuitive Guess Challenge],

) <fig1>
#colbreak()
#figure(

image("2.png"),

caption: [Corrective Feedback],

) <fig2>
]

#colbreak()

=  Problem
- When living abroad, "thinking" in a foreign currency is challenging

- People often fall back on heuristics (e.g., "just divide by ten") that cause them to consistently over- or underestimate prices

=  Concept
- The learner is repeatedly challenged to guess, intuit, or calculate converted currency values

- They get immediate visual and textual feedback on their guess and on their general progress
]
= Links

- #link("https://github.com/koljapluemer/currency-conversion-practice")[Repository]
- *#link("https://currency.koljapluemer.com/")[Webapp]*  

= Evaluation
I have not tested the app rigorously, but in my personal experience, even just a few trials of converting _with immediate feedback_ (something you almost never get when handling a foreign currency in situ) was immensely helpful for building a more accurate intuition of value. 

= Future Work

- The app requires the user to input currency codes and the conversion rate. Automating this with a currency API would improve UX.
- Similarly, currencies are handled naively as simple numbers. Correctly handling financial facts, such as the Japanese yen being displayed without decimal places, would improve the app, but also explode complexity.
- Currently, exercises are picked randomly from a linear, numeric range. It would be better usability if currency values were picked from plausible ranges, e.g. "typical meal prices" or "typical used car prices". This is again fairly complex to implement robustly.