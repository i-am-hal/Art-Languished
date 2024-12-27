"Art, Languished - Dreamlands
                    =========   [|   |]   ~~~~~~~~~~~~~~~
                   | UNKNOWN |  [|   |]  ~~~~~~~~~~~~~~~~
                    =========   [|   |] ~~~~~~~~~~~~~~~~~
                       ^|v      [|   |]~~~~~~~~~~~~~~~~~~
 =========       ===============[-----]~~~~~~~~~~~~~~~~~~
| UNKNOWN | <-> | Somber Planes [ DAM ]  Ocean of Blood  
 =========       ===============[-----]~~~~~~~~~~~~~~~~~~
                       ^|v      [|   |]~~~~~~~~~~~~~~~~~~
                    =========   [|   |] ~~~~~~~~~~~~~~~~~
                   | UNKNOWN |  [|   |]  ~~~~~~~~~~~~~~~~
                    =========   [|   |]   ~~~~~~~~~~~~~~~"
<CONSTANT DREAM-DEATH-WAKE-UP-MSG <LTABLE
    "Your eyes fly open, catching the scream leaving your lips, gripping at the bed sheets."
    "You jump from sleep, a primal fear in your eyes. You couldn't sleep the rest of the night."
    "You awake in a cold sweat."
    "You startle awake, arms wrenched together in terror."
    "You wake in the morning, haunted, and weary.">>

;"Ends dream (due to most likely, death in dream.) Death in
a dream gives player +1 DESPAIR. Subs love/loathe to do so"
<ROUTINE DREAMS-UP (MSG)
    <TELL <PICK-ONE-R ,DREAM-DEATH-WAKE-UP-MSG> CR>
    <TELL " *** " .MSG " ***" CR CR>
    <V-MORE-DESPAIR>
    <GOTO ,APARTMENT-BEDROOM>>

<LIGHTROOM A (DESC "A") (SOUTH TO SOMBER-PLANES)>
<LIGHTROOM B (DESC "B") (SOUTH TO SOMBER-PLANES)>

<CONSTANT NO-TRAIL-HEAD-FOUND "You look for some time, yet cannot find the trail head.">
<CONSTANT NORTH-TRAIL-HEAD <LTABLE <> A B>>
<GLOBAL NORTHERN-TRAIL <>>

<ROOM DERELICT-COTTAGE (DESC "Derelict Cottage")
    (IN ROOMS)
    (OUT TO SOMBER-PLANES)
    (FLAGS RLANDBIT LIGHTBIT)>

<ROOM SOMBER-PLANES (DESC "Somber Planes")
    (IN ROOMS)
    (ENTRYFCN SOMBER-PLANES-ENTRY-F)
    (FLAGS RLANDBIT LIGHTBIT)
    (IN TO DERELICT-COTTAGE)
    (NORTH PER DREAM-NORTH-TRAIL-HEAD-F)>

<ROUTINE SOMBER-PLANES-ENTRY-F ()
    <COND
        ;"Upon first entry in dreamlands, and not prologue, select the trail heads"
        (<AND <NOT <FSET? ,SOMBER-PLANES ,TOUCHBIT>> ;,PROLOGUE-COMPLETE>
            <SETG NORTHERN-TRAIL <PICK-ONE-R ,NORTH-TRAIL-HEAD>>)>>

<ROUTINE DREAM-NORTH-TRAIL-HEAD-F ()
    <COND
        ;"No value picked for northern trail or its prologue, can't see a path."
        (<OR ;<NOT ,PROLOGUE-COMPLETE> <NOT ,NORTHERN-TRAIL>>
            <TELL ,NO-TRAIL-HEAD-FOUND CR>
            <RFALSE>)
        
        ;"If there is a trailhead, return that thang"
        (ELSE  ,NORTHERN-TRAIL)>>

