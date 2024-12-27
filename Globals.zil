"Art, Languished - Globals

DREAD
COHERENCE <-APATHY-> DISSONANCE
LOVE      <-DESPAIR-> LOATHE"

;"Whether or not the augur is the perspective we're taking"
<GLOBAL AUGUR-IS-LEADING? T>
;"What act we're in"
<GLOBAL ACT-NUMBER        0>

;"The different focuses in terms of artistic expression"
<CONSTANT ART-FOCUS-WRITING   1>
<CONSTANT ART-FOCUS-PAINTING  2>
<CONSTANT ART-FOCUS-SCULPTING 3>
<GLOBAL ART-FOCUS <>>
;"If the prologue has been finished through yet or not"
<GLOBAL PROLOGUE-COMPLETE <>>
;"Specifically if the backstory part of the prologue is complete"
<GLOBAL PROLOGUE-BACKSTORY-COMPLETE <>>

;"Strength of pull towards one of the emotional states.
[1 ~ Typical][2 ~ Significant/Heavy Hitting][3 ~ Life Altering]"
<CONSTANT FEELING-ABSENT       0>
<CONSTANT FEELING-SLIGHT       1>
<CONSTANT FEELING-MODERATE     2>
<CONSTANT FEELING-SEVERE       3>
<CONSTANT FEELING-INTENSE      4>
<CONSTANT FEELING-DEBILITATING 5>

<PROPDEF DREAD      <>> 
<PROPDEF COHERENCE  <>>
<PROPDEF DISSONANCE <>>
<PROPDEF LOVE       <>>
<PROPDEF LOATHE     <>>

<PROPDEF EMOTIONS <>
    (EMOTIONS "OPT" COHERENCE CO:FIX "OPT" DISSONANCE DC:FIX "OPT" LOVE LV:FIX "OPT" LOATHE LT:FIX "OPT" DREAD DD:FIX = (DREAD <WORD .DD>)  (COHERENCE <WORD .CO>) (LOVE <WORD .LV>)
                                                                                                                        (LOATHE <WORD .LT>) (DISSONANCE <WORD .DC>))
    ;(EMOTIONS COHERENCE  CO:FIX "OPT" DREAD DD:FIX = (COHERENCE <WORD .CO>) (DREAD <WORD .DD>))
    ;(EMOTIONS DISSONANCE DC:FIX "OPT" DREAD DD:FIX = (DISSONANCE <WORD .DC>) (DREAD <WORD .DD>))
    ;(EMOTIONS LOVE       LV:FIX "OPT" DREAD DD:FIX = (LOVE <WORD .LV>) (DREAD <WORD .DD>))
    ;(EMOTIONS LOATHE     LT:FIX "OPT" DREAD DD:FIX = (LOATHE <WORD .LT>) (DREAD <WORD .DD>))>

;"Player global versions of properties"
<GLOBAL PLAYER-DREAD      0>
<GLOBAL PLAYER-COHERENCE  0>
<GLOBAL PLAYER-APATHY     0> ;"Stores global apathy, conversion from coherence and dissonance"
<GLOBAL PLAYER-DISSONANCE 0>
<GLOBAL PLAYER-LOVE       0>
<GLOBAL PLAYER-DESPAIR    0> ;"Stores global despair, conversion from love to loathing"
<GLOBAL PLAYER-LOATHE     0>

;"Initialize the feelings of the player"
<ROUTINE INIT-PLAYER-FEELINGS ()
    <SETG PLAYER-DREAD      ,FEELING-ABSENT>

    <SETG PLAYER-COHERENCE  ,FEELING-MODERATE>
    <SETG PLAYER-APATHY     ,FEELING-SLIGHT>
    <SETG PLAYER-DISSONANCE ,FEELING-ABSENT>

    <SETG PLAYER-LOVE       ,FEELING-SLIGHT>
    <SETG PLAYER-DESPAIR    ,FEELING-MODERATE>
    <SETG PLAYER-LOATHE     ,FEELING-ABSENT>>

<ROUTINE FEELING-LEVEL-STRING (STAT)
    <COND
        (<=? .STAT ,FEELING-SLIGHT>       <TELL "Slight">)
        (<=? .STAT ,FEELING-MODERATE>     <TELL "Moderate">)
        (<=? .STAT ,FEELING-SEVERE>       <TELL "Severe">)
        (<=? .STAT ,FEELING-INTENSE>      <TELL "Extreme">)
        (<=? .STAT ,FEELING-DEBILITATING> <TELL "Crippling">)>>

<SYNTAX STATUS OBJECT (FIND KLUDGEBIT) = V-EMOTIONAL-STATUS PRE-EMOTIONAL-STATUS>
<SYNTAX FEELINGS OBJECT (FIND KLUDGEBIT) = V-EMOTIONAL-STATUS PRE-EMOTIONAL-STATUS>
<SYNTAX MY FEELINGS OBJECT (FIND KLUDGEBIT) = V-EMOTIONAL-STATUS PRE-EMOTIONAL-STATUS>
<VERB-SYNONYM FEELINGS EMOTION EMOTIONS>

<ROUTINE PRE-EMOTIONAL-STATUS ()
    <COND (,AUGUR-IS-LEADING?
        <TELL "There is no need to reflect on your feelings." CR>)
    
    (ELSE <RFALSE>)>>

<ROUTINE V-EMOTIONAL-STATUS ("AUX" DD CO AP DC LV DR LT)
    <SET DD ,PLAYER-DREAD>
    <SET CO ,PLAYER-COHERENCE>
    <SET AP ,PLAYER-APATHY>
    <SET DC ,PLAYER-DISSONANCE>
    <SET LV ,PLAYER-LOVE>
    <SET DR ,PLAYER-DESPAIR>
    <SET LT ,PLAYER-LOATHE>
    
    <COND ;"Responses relating to coherence"
        (<=? ,FEELING-SEVERE   .CO> <TELL "Your life is a tapestry, and you're ready to continue your work on it." CR>)
        (<=? ,FEELING-MODERATE .CO> <TELL "Things may not be okay, but you feel like you'll endure." CR>)
        (<=? ,FEELING-SLIGHT   .CO> <TELL "You're holding it together today." CR>)
        ;"Responses relating to dissonance"
        (<=? ,FEELING-SEVERE   .DC> <TELL "You're fraying, being divided amongst a thousand seperate strands. You're going to snap." CR>)
        (<=? ,FEELING-MODERATE .DC> <TELL "The blood gushes from the cracks. How long until you shatter?" CR>)
        (<=? ,FEELING-SLIGHT   .DC> <TELL "You feel as if your very soul is brittle." CR>)>
    <COND ;"Various responses about how apathetic the player"
        (<=? ,FEELING-SEVERE   .AP> <TELL "You look upon your tools and regard them as a cruel joke." CR>)
        (<=? ,FEELING-MODERATE .AP> <TELL "Your motivation runs through your fingers like sand." CR>)
        (<=? ,FEELING-SLIGHT   .AP> <TELL "Your passions seem to ring hollow today." CR>)
        ;(<=? ,FEELING-ABSENT   .AP> <CRLF>)>

    <COND ;"Responses regarding to love"
        (<=? ,FEELING-SEVERE   .LV> <TELL "The light of the sun is warm, reassuring. A laugh easily comes from your lips." CR>)
        (<=? ,FEELING-MODERATE .LV> <TELL "You feel a warmth within you. It's easier to smile today." CR>)
        (<=? ,FEELING-SLIGHT   .LV> <TELL "You feel that your heart is light today." CR>)
        ;"Responses regarding loathing"
        (<=? ,FEELING-SEVERE   .LT> <TELL "Your hands shake. You wish to regard your art like the visera of an enemy." CR>)
        (<=? ,FEELING-MODERATE .LT> <TELL "You long for the satisfaction of snapping your brushes." CR>)
        (<=? ,FEELING-SLIGHT   .LT> <TELL "Every movement of yours lands hard." CR>)>
    <COND ;"Various responses to how much despair the player feels"
        (<=? ,FEELING-SEVERE   .DR> <TELL "There is no end. This is it. A vast plain." CR>)
        (<=? ,FEELING-MODERATE .DR> <TELL "Your future is an unending stairwell." CR>)
        (<=? ,FEELING-SLIGHT   .DR> <TELL "You feel a little lost." CR>)
        (<=? ,FEELING-ABSENT   .DR> <CRLF>)>

    <COND ;"The various statuses for dread"
        (<=? ,FEELING-SLIGHT       .DD> <TELL "You feel uneasy." CR>)
        (<=? ,FEELING-MODERATE     .DD> <TELL "The light shines malevolently." CR>)
        (<=? ,FEELING-SEVERE       .DD> <TELL "As the light falls on you, you know you're being watched." CR>)
        (<=? ,FEELING-INTENSE      .DD> <TELL "You're ceratin something is stalking you. Lurking in the light. Hunting." CR>)
        (<=? ,FEELING-DEBILITATING .DD> <TELL "Your heart grows faint. You know that you cannot forever dwell within darkness." CR>)>>

;"Single function to output the text in bold"
<ROUTINE BOLD (STR)
    <HLIGHT ,H-BOLD>
    <TELL .STR>
    <HLIGHT ,H-NORMAL>>

<ROUTINE BOLD-NUM (X)
    <HLIGHT ,H-BOLD>
    <TELL N .X>
    <HLIGHT ,H-NORMAL>>

<GLOBAL ART-LANGUISHED-ACT      0>

<GLOBAL HAVE-JANITOR-DOOR-KEY? <>>

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;"Tests / Conditions"
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"Randomly tests if Carcosa/Yellow King has successfully influenced the dreamlands.
Every point of dread is +13% probability, and every point of despair +11%"
<ROUTINE CALL-OF-CARCOSA? ()
    <RETURN <PROB <+ <* 13 ,PLAYER-DREAD> <* 11 ,PLAYER-DESPAIR>>>>>
