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

<CONSTANT NO-TRAIL-HEAD-FOUND <LTABLE 
    "You look for some time, yet cannot find the trail head."
    "You see no trail, it's just endless rows of trees and brush."
    "After a few moments it is clear to you there is no path.">>

<INSERT-FILE "Dreamlands North">
<INSERT-FILE "Dreamlands South">
<INSERT-FILE "Dreamlands West">

<GLOBAL NORTHERN-TRAIL <>>
<GLOBAL SOUTHERN-TRAIL <>>
<GLOBAL WESTERN-TRAIL  <>>

;"Will randomly select a trailhead"
<ROUTINE SELECT-TRAIL-HEAD (TBL "AUX" (TRAILHEAD <>))
    <SET TRAILHEAD <PICK-ONE-R .TBL>>

    <REPEAT ((TRIGGER-FCN <GETP .TRAILHEAD ,P?TRIGGER>))
        <COND 
            ;"If hasn't been picked before, has trigger fcn which returns true w/ params carcosa? and azagarath?, valid pick"
            (<AND .TRAILHEAD <NOT <FSET? .TRAILHEAD ,VISITEDBIT>> .TRIGGER-FCN <APPLY .TRIGGER-FCN>>
                <RETURN>)>
        
        <SET TRAILHEAD   <PICK-ONE-R .TBL>>
        <SET TRIGGER-FCN <GETP .TRAILHEAD ,P?TRIGGER>>>
    
    ;"Now mark this trailhead as having been visited, and return it"
    <AND .TRAILHEAD <FSET .TRAILHEAD ,VISITEDBIT>>
    <RETURN .TRAILHEAD>>

<ROOM DERELICT-COTTAGE (DESC "Derelict Cottage")
    (IN ROOMS)
    (OUT TO SOMBER-PLANES)
    (SOUTH TO SOMBER-PLANES)
    (FLAGS RLANDBIT LIGHTBIT)>

<OBJECT DREAMLANDS-SKY (DESC "sky")
    (IN LOCAL-GLOABLS)
    (ADJECTIVE DARK NIGHT)
    (SYNONYM STARS SKY)
    (FLAGS NDESCBIT)>

<OBJECT IMMENSE-BLOOD-DAM (DESC "Monolithic Dam")
    (IN LOCAL-GLOBALS)
    (ADJECTIVE MONOLITHIC IMMENSE CRACKED DAMAGED BLOOD BLEEDING)
    (SYNONYM DAM)
    (FLAGS NDESCBIT)
    (LDESC "Made of smooth grey concrete it looms over all. You've never seen a structure so large.
Not even in the metropolis you reside in- no sky scraper evokes in you the awe and dread that one
could imagine having at seeing the Tower of Babel. You weren't even sure how you initially tapped
this as a dam, and not some great wall or fortification. The size makes you wonder how much water
it could possibly be holding back. Surely only an ocean would be beffitting such a structure.")>

<INSPIRATION BLOOD-DAMN-INSPO (DESC "")>

<ROOM SOMBER-PLANES (DESC "Somber Planes")
    (IN ROOMS)
    (ENTRYFCN SOMBER-PLANES-ENTRY-F)
    (FLAGS RLANDBIT LIGHTBIT)
    (IN TO DERELICT-COTTAGE)
    (NORTH PER DREAM-NORTH-TRAIL-HEAD-F)
    (SOUTH PER DREAM-SOUTH-TRAIL-HEAD-F)
    (WEST  PER DREAM-WEST-TRAIL-HEAD-F)>

<ROUTINE SOMBER-PLANES-ENTRY-F ()
    ;"Check on the influences on this dream"
    <CALL-OF-CARCOSA?> <NAME-OF-THE-ONE?>
    <COND
        (<AND <NOT ,PROLOGUE-COMPLETE> <NOT <FSET? ,SOMBER-PLANES ,TOUCHBIT>>>
            )

        ;"Upon first entry in dreamlands, and not prologue, select the trail heads"
        (<AND <NOT <FSET? ,SOMBER-PLANES ,TOUCHBIT>> ,PROLOGUE-COMPLETE>
            <SETG NORTHERN-TRAIL <SELECT-TRAIL-HEAD ,NORTH-TRAIL-HEAD>>
            ;<SETG SOUTHERN-TRAIL <SELECT-TRAIL-HEAD ,SOUTH-TRAIL-HEAD>>
            ;<SETG WESTERN-TRAIL  <SELECT-TRAIL-HEAD ,WEST-TRAIL-HEAD>>)>>

<ROUTINE DREAM-NORTH-TRAIL-HEAD-F ()
    <COND
        ;"No value picked for northern trail or its prologue, can't see a path."
        (<OR ;<NOT ,PROLOGUE-COMPLETE> <NOT ,NORTHERN-TRAIL>>
            <TELL <PICK-ONE-R ,NO-TRAIL-HEAD-FOUND> CR>
            <RFALSE>)
        
        ;"If there is a trailhead, return that thang"
        (ELSE  ,NORTHERN-TRAIL)>>

<ROUTINE DREAM-SOUTH-TRAIL-HEAD-F ()
    <COND
        (<OR <NOT ,PROLOGUE-COMPLETE> <NOT ,SOUTHERN-TRAIL>>
            <TELL <PICK-ONE-R ,NO-TRAIL-HEAD-FOUND> CR>
            <RFALSE>)
        
        (ELSE  ,SOUTHERN-TRAIL)>>

<ROUTINE DREAM-WEST-TRAIL-HEAD-F ()
    <COND
        (<OR <NOT ,PROLOGUE-COMPLETE> <NOT ,WESTERN-TRAIL>>
            <TELL <PICK-ONE-R ,NO-TRAIL-HEAD-FOUND> CR>
            <RFALSE>)
        
        (ELSE  ,WESTERN-TRAIL)>>

