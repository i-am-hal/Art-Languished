"Art, Languished - Apartment"

<ROOM APARTMENT-LIVINGROOM (DESC "Apartment Livingroom")
    (IN ROOMS)
    (ENTRYFCN APARTMENT-LIVINGROOM-ENTRY)
    (FLAGS RLANDBIT LIGHTBIT)
    (EAST TO APARTMENT-BEDROOM)
    (NORTH TO APARTMENT-KITCHEN)
    (NE TO APARTMENT-BATHROOM)>

<ROUTINE APARTMENT-LIVINGROOM-ENTRY ()
    <COND
        ;"If we're still in the prologue ~ no touchbit (first visit) + in prologue"
        (<AND ,PROLOGUE-BACKSTORY-COMPLETE <NOT <FSET? ,APARTMENT-LIVINGROOM ,TOUCHBIT>> <NOT ,PROLOGUE-COMPLETE>>
            <V-VERSION> <CRLF>
            <SETG ACT-NUMBER 1>
            <TELL "Your reverie fades, and you find yourself standing in the clutterd, what surely was intended to be a, livingroom." CR CR>)>>

<ROOM APARTMENT-KITCHEN (DESC "Small Kitchen")
    (IN ROOMS)
    (FLAGS RLANDBIT LIGHTBIT)
    (OUT TO APARTMENT-LIVINGROOM)
    (SOUTH TO APARTMENT-LIVINGROOM)
    (EAST TO APARTMENT-LIVINGROOM)>

<ROOM APARTMENT-BATHROOM (DESC "Small Bathroom")
    (IN ROOMS)
    (FLAGS RLANDBIT LIGHTBIT)
    (OUT TO APARTMENT-LIVINGROOM)
    (WEST TO APARTMENT-LIVINGROOM)>

<ROOM APARTMENT-BEDROOM (DESC "Your Bedroom")
    (IN ROOMS)
    (FLAGS RLANDBIT LIGHTBIT)
    (OUT TO APARTMENT-LIVINGROOM)
    (WEST TO APARTMENT-LIVINGROOM)>