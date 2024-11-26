"Art, Languished - Main"

<CONSTANT GAME-BANNER "Art, Languished|Written by Xal|Dedicated to my best friend, Liv">
<CONSTANT RELEASED 1> <VERSION 8>

;"Defines all color globals"
<CONSTANT COLOR-SAME    0>
<CONSTANT COLOR-DEFAULT 1>
<CONSTANT COLOR-BLACK   2>
<CONSTANT COLOR-RED     3>
<CONSTANT COLOR-GREEN   4>
<CONSTANT COLOR-YELLOW  5>
<CONSTANT COLOR-BLUE    6>
<CONSTANT COLOR-MAGENTA 7>
<CONSTANT COLOR-CYAN    8>
<CONSTANT COLOR-WHITE   9>

<CONSTANT H-NONE        0>
<CONSTANT H-INVERSE     1>
<CONSTANT H-BOLD        2>
<CONSTANT H-ITALIC      4>

;"Flags defined for this game:
    * INSPIRATIONBIT ~ Marks object as INSPIRATION which can later be consumed to create art"
<SETG EXTRA-FLAGS '(INSPIRATIONBIT)>


<INSERT-FILE "parser">
<USE         "TEMPLATE">
<USE         "CHOICES">
<USE         "RANDOM">
<INSERT-FILE "Globals">
<INSERT-FILE "Templates">
<INSERT-FILE "Transitions">
<INSERT-FILE "Theater">

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"SO PLAYERS CAN TURN OFF LIVE-EMOTION STAT TRACKING.
SOME MAY PREFER TO NOT BE ABLE TO SEE IT CONSTANTLY."

<GLOBAL SHOW-LIVE-EMOTIONS? <>>
<GLOBAL EMOTION-LINE-USED?  <>>

<SYNTAX HIDE FEELINGS OBJECT (FIND KLUDGEBIT) = V-HIDE-LIVE-EMOTIONS>
<SYNTAX HIDE EMOTIONS OBJECT (FIND KLUDGEBIT) = V-HIDE-LIVE-EMOTIONS>
<SYNTAX SHOW FEELINGS OBJECT (FIND KLUDGEBIT) = V-SHOW-LIVE-EMOTIONS>
<SYNTAX SHOW EMOTIONS OBJECT (FIND KLUDGEBIT) = V-SHOW-LIVE-EMOTIONS>

<ROUTINE V-HIDE-LIVE-EMOTIONS ()
    <SETG SHOW-LIVE-EMOTIONS? <>>
    ;"<SCREEN 1> <CURSET 1 1> <CLEAR 1> <SCREEN 0>"
    <TELL "You feel yourself becoming more withdrawn.|(Live emotion preview off.)" CR>>

<ROUTINE V-SHOW-LIVE-EMOTIONS ()
    <SETG SHOW-LIVE-EMOTIONS? T>
    <TELL "You allow yourself to relax, and show your emotions.|(Live emotion preview is on.)" CR>>

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"DISABLE THIS SO THAT THE DEBUGGING FUNCTIONS
DON'T WORK DURING RELEASE YOU DOLT!"

<CONSTANT ALLOW-DEBUGGING? T>
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<SET REDEFINE T>
<ROUTINE UPDATE-STATUS-LINE ("AUX" WIDTH (SHOW-FEELING-LINE? <>) (DREAD-BALANCE 0))
    <SET SHOW-FEELING-LINE? <AND ;<NOT ,AUGUR-IS-LEADING?> ,SHOW-LIVE-EMOTIONS?>>

    <SCREEN 1>

    ;"Clean up old emotion line if we aren't using it"
    <COND (<AND <NOT .SHOW-FEELING-LINE?> ,EMOTION-LINE-USED?>
        <CURSET 2 1> <CLEAR 1>)>

    <COND
        ;"If we need the extra line, add it in"
        (.SHOW-FEELING-LINE?
            <SETG EMOTION-LINE-USED? T>
            <SPLIT 2>)

        (ELSE <SPLIT 1>)>

    <HLIGHT ,H-INVERSE>
    ;"Clear the second line"
    <COND (.SHOW-FEELING-LINE?  <CURSET 2 1> <CLEAR 1>)>
    <CURSET 1 1> <CLEAR 1>
    <TELL !\ >
    <COND (,HERE-LIT <TELL D ,HERE>)
        (ELSE <TELL "Darkness">)>
    <SET WIDTH <LOWCORE SCRH>>

    ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    ;"Display the current act we're in"
    <COND (<G? ,ACT-NUMBER 0>
        <CURSET 1 <- .WIDTH 6>>
        <TELL "Act " N ,ACT-NUMBER>)>

    
    <COND (.SHOW-FEELING-LINE?
        ;"Only coherence, center on the left"
        <COND (<=? ,PLAYER-COHERENCE ,FEELING-SEVERE> 
            <CURSET 2 <- </ .WIDTH 4> 9>>
            <TELL "Coherence: "> <FEELING-LEVEL-STRING ,PLAYER-COHERENCE>)>
        ;"Only dissonance, center on the left"
        <COND (<=? ,PLAYER-DISSONANCE ,FEELING-SEVERE>
            <CURSET 2 <- </ .WIDTH 4> 10>>
            <TELL "Dissonance: "> <FEELING-LEVEL-STRING ,PLAYER-DISSONANCE>)>
        ;"Only apathy, center on the left"
        <COND (<=? ,PLAYER-APATHY ,FEELING-SEVERE>
            <CURSET 2 <- </ .WIDTH 4> 8>>
            <TELL "Apathy: "> <FEELING-LEVEL-STRING ,PLAYER-APATHY>)>

        ;"Some apathy and some either coherence or dissonance"
        <COND (<AND <G? ,PLAYER-APATHY ,FEELING-ABSENT> <L? ,PLAYER-APATHY ,FEELING-SEVERE>>
            <COND
                ;"If there isn't any dissonance, we have SOME coherence"
                (<0? ,PLAYER-DISSONANCE>
                    <CURSET 2 0>
                    <TELL " Coherence: "> <FEELING-LEVEL-STRING ,PLAYER-COHERENCE>)
                
                ;"Otherwise, some loathing, no love"
                (ELSE
                    <CURSET 2 0>
                    <TELL " Dissonance: "> <FEELING-LEVEL-STRING ,PLAYER-DISSONANCE>)>
            
            <CURSET 2 <- </ .WIDTH 4> 0>>
            <TELL "Apathy: "> <FEELING-LEVEL-STRING ,PLAYER-APATHY>)>

        ;"Display the amount of dread the player has"
        <COND (<G? ,PLAYER-DREAD 0>
            <AND <G=? ,PLAYER-DREAD ,FEELING-INTENSE> <SET DREAD-BALANCE 1>>
            <CURSET 2 <- </ .WIDTH 2> <+ 4 .DREAD-BALANCE>>>
            <TELL "Dread: "> <FEELING-LEVEL-STRING ,PLAYER-DREAD>)>
        
        ;"Only love, center on the right"
        <COND (<=? ,PLAYER-LOVE ,FEELING-SEVERE> 
            <CURSET 2 <- </ <* .WIDTH 3> 4> 6>>
            <TELL "Love: "> <FEELING-LEVEL-STRING ,PLAYER-LOVE>)>
        ;"Only Loathing, center it on the right"
        <COND (<=? ,PLAYER-LOATHE ,FEELING-SEVERE>
            <CURSET 2 <- </ <* .WIDTH 3> 4> 10>>
            <TELL "Loathing: "> <FEELING-LEVEL-STRING ,PLAYER-LOATHE>)>
        ;"Only Despair, center on the right"
        <COND (<=? ,PLAYER-DESPAIR ,FEELING-SEVERE>
            <CURSET 2 <- </ <* .WIDTH 3> 4> 9>>
            <TELL "Despair: "> <FEELING-LEVEL-STRING ,PLAYER-DESPAIR>)>
        
        ;"Love/Loathing AND Despair"
        <COND (<AND <G? ,PLAYER-DESPAIR ,FEELING-ABSENT> <L? ,PLAYER-DESPAIR ,FEELING-SEVERE>>
            <CURSET 2 <- </ <* .WIDTH 3> 4> 8>>
            <TELL "Despair: "> <FEELING-LEVEL-STRING ,PLAYER-DESPAIR>
            
            <COND
                ;"If there isn't any loathing, we have SOME love"
                (<0? ,PLAYER-LOATHE>
                    <CURSET 2 <- .WIDTH 14>>
                    <TELL "Love: "> <FEELING-LEVEL-STRING ,PLAYER-LOVE>)
                
                ;"Otherwise, some loathing, no love"
                (ELSE
                    <CURSET 2 <- .WIDTH 18>>
                    <TELL "Loathing: "> <FEELING-LEVEL-STRING ,PLAYER-LOATHE>)>)>)>

    ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    <SCREEN 0>
    <HLIGHT ,H-NONE>>

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;"Debugging features"

<ROUTINE PRE-DEBUG ()
    <COND (<NOT ,ALLOW-DEBUGGING?>
        <TELL "If only it were that easy." CR>)>>

<SYNTAX MORE DREAD OBJECT (FIND KLUDGEBIT) = V-MORE-DREAD PRE-DEBUG>
<SYNTAX LESS DREAD OBJECT (FIND KLUDGEBIT) = V-LESS-DREAD PRE-DEBUG>

<ROUTINE V-MORE-DREAD () 
    <SETG PLAYER-DREAD <COND
        (<L? ,PLAYER-DREAD ,FEELING-DEBILITATING> <+ 1 ,PLAYER-DREAD>)
        (ELSE                                     ,PLAYER-DREAD)>>>

<ROUTINE V-LESS-DREAD () 
    <SETG PLAYER-DREAD 
        <COND 
            (<G? ,PLAYER-DREAD ,FEELING-ABSENT>
                <- ,PLAYER-DREAD 1>)
            (ELSE ,PLAYER-DREAD)>>>

<SYNTAX MORE LOVE OBJECT (FIND KLUDGEBIT) = V-MORE-LOVE PRE-DEBUG>

<ROUTINE V-MORE-LOVE ()
    <COND 
        (<AND <L? ,PLAYER-LOVE ,FEELING-SEVERE> <G? ,PLAYER-LOATHE ,FEELING-ABSENT>>
            <SETG PLAYER-DESPAIR <+ 1 ,PLAYER-DESPAIR>>
            <SETG PLAYER-LOATHE <- ,PLAYER-LOATHE 1>>)
        
        (<AND <L? ,PLAYER-LOVE ,FEELING-SEVERE> <G? ,PLAYER-DESPAIR ,FEELING-ABSENT>>
            <SETG PLAYER-LOVE <+ ,PLAYER-LOVE 1>>
            <SETG PLAYER-DESPAIR <- ,PLAYER-DESPAIR 1>>)>>

<SYNTAX MORE LOATHE OBJECT (FIND KLUDGEBIT) = V-MORE-LOATHE PRE-DEBUG>
<SYNTAX MORE HATE OBJECT (FIND KLUDGEBIT) = V-MORE-LOATHE PRE-DEBUG>
<SYNTAX MORE HATERED OBJECT (FIND KLUDGEBIT) = V-MORE-LOATHE PRE-DEBUG>

<ROUTINE V-MORE-LOATHE ()
    <COND 
        (<AND <L? ,PLAYER-LOATHE ,FEELING-SEVERE> <G? ,PLAYER-LOVE ,FEELING-ABSENT>>
            <SETG PLAYER-DESPAIR <+ 1 ,PLAYER-DESPAIR>>
            <SETG PLAYER-LOVE <- ,PLAYER-LOVE 1>>)
        
        (<AND <L? ,PLAYER-LOATHE ,FEELING-SEVERE> <G? ,PLAYER-DESPAIR ,FEELING-ABSENT>>
            <SETG PLAYER-LOATHE <+ ,PLAYER-LOATHE 1>>
            <SETG PLAYER-DESPAIR <- ,PLAYER-DESPAIR 1>>)>>

<SYNTAX MORE COHERENCE OBJECT (FIND KLUDGEBIT) = V-MORE-COHERENCE PRE-DEBUG>
<SYNTAX MORE STABILITY OBJECT (FIND KLUDGEBIT) = V-MORE-COHERENCE PRE-DEBUG>
<SYNTAX MORE SANITY OBJECT (FIND KLUDGEBIT) = V-MORE-COHERENCE PRE-DEBUG>

<ROUTINE V-MORE-COHERENCE ()
    <COND 
        (<AND <L? ,PLAYER-COHERENCE ,FEELING-SEVERE> <G? ,PLAYER-DISSONANCE ,FEELING-ABSENT>>
            <SETG PLAYER-APATHY <+ 1 ,PLAYER-APATHY>>
            <SETG PLAYER-DISSONANCE <- ,PLAYER-DISSONANCE 1>>)
        
        (<AND <L? ,PLAYER-COHERENCE ,FEELING-SEVERE> <G? ,PLAYER-APATHY ,FEELING-ABSENT>>
            <SETG PLAYER-COHERENCE <+ ,PLAYER-COHERENCE 1>>
            <SETG PLAYER-APATHY <- ,PLAYER-APATHY 1>>)>>

<SYNTAX MORE DISSONANCE OBJECT (FIND KLUDGEBIT) = V-MORE-DISSONANCE PRE-DEBUG>
<SYNTAX MORE INSANITY OBJECT (FIND KLUDGEBIT) = V-MORE-DISSONANCE PRE-DEBUG>
<SYNTAX MORE CRAZY OBJECT (FIND KLUDGEBIT) = V-MORE-DISSONANCE PRE-DEBUG>
<SYNTAX LESS STABILITY OBJECT (FIND KLUDGEBIT) = V-MORE-DISSONANCE PRE-DEBUG>
<SYNTAX LESS SANITY OBJECT (FIND KLUDGEBIT) = V-MORE-DISSONANCE PRE-DEBUG>

<ROUTINE V-MORE-DISSONANCE ()
    <COND 
        (<AND <L? ,PLAYER-DISSONANCE ,FEELING-SEVERE> <G? ,PLAYER-COHERENCE ,FEELING-ABSENT>>
            <SETG PLAYER-APATHY <+ 1 ,PLAYER-APATHY>>
            <SETG PLAYER-COHERENCE <- ,PLAYER-COHERENCE 1>>)
        
        (<AND <L? ,PLAYER-DISSONANCE ,FEELING-SEVERE> <G? ,PLAYER-APATHY ,FEELING-ABSENT>>
            <SETG PLAYER-DISSONANCE <+ ,PLAYER-DISSONANCE 1>>
            <SETG PLAYER-APATHY <- ,PLAYER-APATHY 1>>)>>

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<ROUTINE GO ()
    <INIT-PLAYER-FEELINGS>
    <THEATER-INTRODUCTION>

    <SETG HERE ,THEATER-ENTRANCE>
    <MOVE ,PLAYER ,HERE>

    ;<CRLF> ;<V-VERSION>
    <CRLF> <V-LOOK>
    <UPDATE-STATUS-LINE>
    <MAIN-LOOP>>

