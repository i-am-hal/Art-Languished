"Art, Languished - Templates"

<OBJECT-TEMPLATE LIGHTROOM = ROOM
    (IN ROOMS)
    (FLAGS RLANDBIT LIGHTBIT)>

;"Text response to inspiration being consumed"
<PROPDEF FLAVOR <>>

<PROPDEF CONSTRENDER <>> ;"Object given ~ only one way to render inspiration into art."
<PROPDEF FCNRENDER   <>> ;"Func given   ~ multiple ways to render inspiration into art."
;"Nice helper prop to conveniently set up rendering inspiration into its different interpretations"
<PROPDEF RENDER <>
    (RENDER F:FCN         = (FCNRENDER <WORD .F>) <BYTE 0>)
    (RENDER WITH F:FCN    = (FCNRENDER <WORD .F>) <BYTE 0>)
    (RENDER O:OBJECT      = (CONSTRENDER <OBJECT .O>))
    (RENDER WITH O:OBJECT = (CONSTRENDER <OBJECT .O>))>

<OBJECT-TEMPLATE INSPIRATION = OBJECT
    (ACTION INSPIRATION-OBJECT-F)
    (FLAGS INSPIRATIONBIT TAKEABLEBIT TRYTAKEBIT)>

;"Removes all items from the player EXCEPT for a given exception. Items LOC set to false."
<ROUTINE REMOVE-ALL-INSPIRATION ("OPT" (EXCEPTION <>) "AUX" OBJ NXT)
    <SET OBJ <FIRST? ,PLAYER>>
    <REPEAT ()
        <COND
            ;"If this is an obj, not exception, remove it from room, grab next obj"
            (<AND .OBJ <FSET? .OBJ ,INSPIRATIONBIT> <N=? .OBJ .EXCEPTION>>
                <SET NXT <NEXT? .OBJ>>
                <REMOVE .OBJ>
                <SET .OBJ .NXT>)
            ;"If this is the exception, skip it"
            (<AND .OBJ <=? .OBJ .EXCEPTION>>
                <SET OBJ <NEXT? .OBJ>>)
            (ELSE <RETURN>)>>>

;"Push towards certain emotion `COUNT` times"
<ROUTINE PUSH-TO-EMOTION (COUNT PULL-FUNC)
    <REPEAT ()
        <COND (<0? .COUNT> <RETURN>)>
        <APPLY .PULL-FUNC>
        <SET COUNT <- .COUNT 1>>>>

;"Default handeler for inspiration objects (to easily cover default
behavior for when being consumed and the like.)"
<ROUTINE INSPIRATION-OBJECT-F ("AUX" (LOVE-DELTA 0) (LOATHE-DELTA 0) (DISSONANCE-DELTA 0) (COHERENCE-DELTA 0) IDEA-TASTE)
    <COND
        ;"If the player is trying to drop inspiration, stop them"
        (<AND <VERB? DROP> <IN? ,PRSO ,PLAYER>>
            <TELL "An idea is not something you can just throw away." CR>)
        
        ;"Prevent eating inspiration until in the cabin"
        (<AND <VERB? EAT> <NOT <FSET? ,PRSO ,EDIBLEBIT>>>
            <TELL "Not yet. We'll make our final decision in the cabin." CR>)
        
        ;"Handles eating inspiration. Modify emotional state based on the
        stats of the inspiration. Should then trigger kicking out of dream"
        (<AND <VERB? EAT> <FSET? ,PRSO ,EDIBLEBIT>>
            <TELL "You take it in your hands and feast upon its radiance.">

            <COND ;"If this has a specific taste, print out that taste"
                (<SET IDEA-TASTE <GETP ,PRSO ,P?FLAVOR>> 
                    <TELL " " .IDEA-TASTE CR>)
                ;"Otherwise, just end off the line."
                (ELSE <CRLF>)>

            <SET LOVE-DELTA       <GETP ,PRSO ,P?LOVE>>
            <SET LOATHE-DELTA     <GETP ,PRSO ,P?LOATHE>>
            <SET DISSONANCE-DELTA <GETP ,PRSO ,P?DISSONANCE>>
            <SET COHERENCE-DELTA  <GETP ,PRSO ,P?COHERENCE>>
            ;"Push emotions based on the stats of inspiration"
            <PUSH-TO-EMOTION .LOVE-DELTA       V-MORE-LOVE>
            <PUSH-TO-EMOTION .LOATHE-DELTA     V-MORE-LOATHE>
            <PUSH-TO-EMOTION .DISSONANCE-DELTA V-MORE-DISSONANCE>
            <PUSH-TO-EMOTION .COHERENCE-DELTA  V-MORE-COHERENCE>
            ;"Remove all inspiration that isn't the one being eaten"
            <REMOVE-ALL-INSPIRATION ,PRSO>
            ;"Finally, remove ediblebit so we cannot re-consume inspiration"
            <FCLEAR ,PRSO ,EDIBLEBIT>
            <RTRUE>)>>

