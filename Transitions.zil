"Art, Languished - Transitions"

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Prologue ~ The Artist takes the Stage"

<LIGHTROOM THE-SHOW-BEGINS (DESC "Audiotorium")
    (LDESC "Where the rest of the building, the rest of this theater, looks as if it had been abandoned and neglected for
decades, the audiotorium looks pristine. This difference is so stark that someone would be forgiven in thinking that they had gone back in time, or that
perhaps, by some mechanism unknown, preternaturally held this place in a kind of stasis. A second within the life of this room, held in suspension,
prolonged throughout the countless years. The curtains are a vibrant crimson, like blood on snow. There are seven rows of seats, and each of them still
has their cushions intact. It is easy to recognize that the cushions mirror the design of the wallpaper. A repeating trailing black line, endlessly
carving hollow hexagons amidst the crimson backdrop. The brass and glass light fixtures along either wall evoke the stylings of the art-deco movement.
A large stage light throws its warm hue upon the center of the curtains.")
    (CHOICES 1 "The faceless figure makes their way to their seat." TO DIM-THE-LIGHTS-OPEN-THE-CURTAINS)>

<LIGHTROOM DIM-THE-LIGHTS-OPEN-THE-CURTAINS (DESC "Audiotorium")
    (LDESC "The cloaked figure drifts over to the fourth row of seats and sit roughly in the middle of the row. On que the lights on either side of the rows
slowly dim until the light is snuffed out. The other seats, the rows, ornate light fixtures, it all melts away. The curtains slowly part, revealing a person
standing on stage. The light of the stage light falls on their face, and truly it is only their upper body that is visible. The actor looks past the
audience, past the void around them. For a few moments it is as if the actor was a statue. Not moving, breathing, not feeling the warmth of the stage light
on their face. Then, like the tide, something washes over them. The actor blinks. You blink, your vision swimming. You're in a void. An endless void. In the
distance a pale, warped face, coldly observes you. There's a glare in your eyes, and your face feels hot.")
    (CHOICES
        1 "Where... am I?" TO PROLOGUE-I-AM-AN-ARTIST
        2 "You feel compelled to speak." TO PROLOGUE-I-AM-AN-ARTIST)>

<LIGHTROOM PROLOGUE-I-AM-AN-ARTIST (DESC "Prologue")
    (LDESC "The heat of the light makes the air hot. It's.. difficult to breathe. Your mind is racing, screaming, and it feels as if a heavy hand is forcing
your mind along some unseen track. You... are a lot of things. You like to think that you are a lot of things. Your eyes search the darkness for something, anything
that isn't that face. Your family- your parents- they never fully accepted that; you need a career, a stable long-term path to secure your own future. A future where
each day, each week, every year, you are slowly ground into a shape suitable and pallatable for this career path. That fire, that fire on your face, the fire in your
heart, it will not die, it will not wither, will it? You feel your mouth move, and you say to the audience,")
    (CHOICES
        1 "\"All my life I have loved art.\"" TO PROLOGUE-LOVE-THE-ARTS                         ;"Change to 2 love"
        2 "\"I'm tired. Exausted of this mold.\"" TO PROLOGUE-TIRED-OF-MOLD                     ;"Change to 1 dissonance"
        3 "\"I have to be more. I'm not just a single note.\"" TO PROLOGUE-DESPERATE-FOR-MORE)> ;"Change to 3 despair, 2 dissonance ~ unravelling"

;"Modify stats so player starts with 2 love, 1 despair"
<ROUTINE PROLOGUE-LOVE-THE-ARTS-F ()
    <SETG PLAYER-LOVE    ,FEELING-MODERATE>
    <SETG PLAYER-DESPAIR ,FEELING-SLIGHT>>

<LIGHTROOM PROLOGUE-LOVE-THE-ARTS (DESC "An Insatiable Fire")
    (ENTRYFCN PROLOGUE-LOVE-THE-ARTS-F)
    (LDESC "It burns so brightly within you, it always has. Some days it was overwelming, like a supernova, so hot and intense that it consumes an entire
solar system, all of you. It was only natural to take to art in that context. Every work you made allowed you to release that pressure, cool down the heat
within you. As you grew up and grew older, you recognized the cruel reality that, most likely, it would be infeasible to sustain yourself on your artistic works.
Your parents, loving as they were, and concerned for your well-being, tried to guide you onto a path of stability. The light within you never dimmed, though.
Every step towards this stability made you feel more and more hollow, less and less real. Then, one late autumn night you found yourself walking the trails
by your home. You marveled at the setting sun, its vibrant streaks of golden and orange light. The clouds a soft pink color. You couldn't help but notice
your scene. The leaves a fabulous managerie of violets, golds, and reds, almost harmonizing with the setting sun. In that moment it was as if you had awoken
from some fugue. You had almost completely forgotten about this, the beauty of the world around you. You eventually found yourself in a small clearing, and
continued to watch the setting sun. You felt that all too familliar swell within you, that burning fire within your chest. The beauty of the world, of nature,
was clearly something to be captured, to be revered. People, all people, ought to be able to marvel at its splendor as you do now. The light within you whispered
a conclusion that you could now understand. The chilled air enters your lungs, stimulating your senses by its cooling of your lungs. You know of only one way
to capture and share this splendor. As the last rays of that golden light faded,")
    (CHOICES
        1 "you had made up your mind to study in the arts." TO PROLOGUE-SO-YOU-WENT-TO-UNIVERSITY)>

;"Modify stats so player starts with 1 dissonance, 2 apathy"
<ROUTINE PROLOGUE-TIRED-OF-MOLD-F ()
    <SETG PLAYER-COHERENCE  ,FEELING-ABSENT>
    <SETG PLAYER-APATHY     ,FEELING-MODERATE>
    <SETG PLAYER-DISSONANCE ,FEELING-SLIGHT>>

<LIGHTROOM PROLOGUE-TIRED-OF-MOLD (DESC "Hollow Chorus of the Heart")
    (ENTRYFCN PROLOGUE-TIRED-OF-MOLD-F)
    (LDESC "For a time you sought to find the stability in a career. You worked, slept, ate, every day, a loathesome drone of life. You did make progress,
you were seeing the fruits of this hard labor, but it costed you. Each hour, each day, week, year, that light within you grew hotter and more caustic. It burned
and began to eat away at something within you, something you never knew you had, something you had not a name for. A hollowness within your very soul began
to fester, and you found yourself thinking of yourself, your life, more and more like that of an automaton than a person. After years of this it all suddenly
washed over you late one autumn night. You had been walking. Perhaps it was the chill in the air, perhaps the tired feeling behind your eyes. You happened upon
a felled tree, which from months of decay, and the unrelenting rains had split it in two. It was hollow inside. Each step closer you were greeted by the crunch
of leaves. It was there, as you stared at that ancient twisted bark, the hollow cavity within, that you began to sob uncontrollably. There was no doubt within
you that you were staring at your own future if you stayed the course on your current path.")
    (CHOICES
        1 "It would be the next day that you applied to study in the arts at university." TO PROLOGUE-SO-YOU-WENT-TO-UNIVERSITY)>

;"Modify stats so player starts with 3 despair, 2 dissonance"
<ROUTINE PROLOGUE-DESPERATE-FOR-MORE-F ()
    <SETG PLAYER-DESPAIR ,FEELING-SEVERE>
    <SETG PLAYER-LOVE    ,FEELING-ABSENT>
    <SETG PLAYER-LOATHE  ,FEELING-ABSENT>
    
    <SETG PLAYER-DISSONANCE ,FEELING-MODERATE>
    <SETG PLAYER-APATHY     ,FEELING-SLIGHT>
    <SETG PLAYER-COHERENCE  ,FEELING-ABSENT>>

<LIGHTROOM PROLOGUE-DESPERATE-FOR-MORE (DESC "Fraying of the Self")
    (ENTRYFCN PROLOGUE-DESPERATE-FOR-MORE-F)
    (LDESC "Years. Years passed, but to you it has felt like an eternal shamble. Your work, meaningless work, consumed you, your time, your life. Your social
engagements eroded away like tombstones against the endless caustic rain born of industry and pollution. Your mind a confused waste, home to only that black
fog which made it difficult to think, difficult to breathe. Your heart fluttered gently, that light within you flickering like a latern in a great tempest.
It was difficult, if not impossible to seperate your life from your work, and truly you could not remember what you did for leisure. A great, smooth wasteland
is what you wandered for an unidentifiably long period of your life. You tried to harness that flickering flame within you, but always, always, you would be
left with only scraps, morsels of a spiritual delicacy which did not nourish you, did not replenish you, but only abated that grinding, endless waste from
wholly snuffing that light from you. It was on one of your weekends, one late October night, you found yourself walking the small foottrails near your home.
The wires, those cords of your being which composed the music of your soul snapped. In the wilderness, amongst the dying leaves and abandonment of the sun that
you screamed, clapsed to your face, and wept. The years of tension on those cords finally giving way to this; and in the afterglow of your mania, as that fetid
smog in your mind parted for a moment, you saw what your life was becoming. What you were becoming- not a person, not a human, but a shambling lever, an implement,
for the cold churning of the world around you. In the quiet of the soft rain, you heard that faint flame that still remained. It had always been within you,
and it was this flame which managed to stave your spiritual starvation for so long. It felt like the last thing you had, the last part of your self which had not
been ground into a fine power to be swept away. Tears streamed down your face, like rivers greeting an ancient arid wasteland, you held onto this fragment of
yourself. You would not let the whole of you be snuffed out.")
    (CHOICES
        1 "Study in the arts, keep the flame alive, keep yourself alive." TO PROLOGUE-SO-YOU-WENT-TO-UNIVERSITY)>

<LIGHTROOM PROLOGUE-SO-YOU-WENT-TO-UNIVERSITY (DESC "So You Went to University")>

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
