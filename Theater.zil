"Art, Languished - Theater"

<ROUTINE THEATER-INTRODUCTION ()
    <TELL CR CR "It is that time again. Another production, another play to watch.
|It has become so routine now that there isn't even a second thought. This old, and increasingly,
|derelict theater has acted as the refuge, distraction, timepiece, of life. No ticket is required
|here. Each production is a second, and the hours shall flow. It is time to progress again." CR>>

<OBJECT THEATER-CARPET (DESC "old carpet")
    (IN LOCAL-GLOBALS)
    (SYNONYM CARPET FLOOR GROUND)
    (ADJECTIVE OLD ANCIENT FRAYED DIRTY)
    (FLAGS NDESCBIT)
    (LDESC "The carpet is showing its age. It used to have a clearly defined pattern of a crimson red and black repeating spiral
pattern. Portions of the carpet are frayed, some curl up from the floor. In some places it is just splotches of black, or red.")>

<OBJECT THEATER-LIGHTS (DESC "dim lights")
    (IN LOCAL-GLOBALS)
    (SYNONYM FIXTURES)
    (ADJECTIVE DIM ORANGE WARM LIGHT LIGHTS)
    (FLAGS NDESCBIT)
    (LDESC "Intermittently along the walls are small ornate light fixtures, which very faintly give off light. However,
most of the light comes from overhead, giving everything long, twisting shadows. You can't locate any lights overhead.")>

<CONSTANT LOOKING-OUTSIDE-THEATER-DOORS "Upon closer inspection it is clear that these aren't truly doors. There are no hinges, nor even handles to
attempt to open them. They give the illusion that this place was built to be entered, or left. In this capacity, this illusion works well. Through
the glass you can see outside. There is nothing. An endless void of black. No light. No heat. A homogeneous nothingness.">

<ROOM THEATER-ENTRANCE (DESC "Theater Entrance")
    (IN ROOMS)
    (GLOBAL THEATER-CARPET THEATER-LIGHTS)
    (FLAGS RLANDBIT LIGHTBIT)
    (NORTH TO THEATER-LOBBY)
    (SOUTH SORRY ,LOOKING-OUTSIDE-THEATER-DOORS)
    (LDESC "Standing before you is an empty tickets booth where one would expect someone to sell tickets to shows. The booth is made of
some kind of dark brown wood. Above the booth is a sign, where the names to the shows could be placed, and the timings for those showings.
Left and right of the booth are two open doorways leading north into the lobby. The room is bathed in a dim, warm light. The wallpaper
is peeling. Behind you are the glass doors which presumably lead outside the theater.")
    (THINGS
        (GLASS) (DOOR DOORS) THEATER-ENTRANCE-DOORS-F
        (WALL) (WALLS PAPER WALLPAPER) ([EXAMINE] "Once the wallpaper was a vibrant red. Now the color has eroded to a sickly pink and beige mixture.
Ribbons of the wallpaper peel away and curl. Underneath is the memory of long lost starlight.")
        (OLD WOODEN TICKET) (BOOTH) ([EXAMINE] "It is made of a dark wood. The varnish has managed to stay fairly intact throughout the years.
A very dusty glass pane seperates the booth propper and the customer. A small hole where the glass meets the top of the desk is where tickets would
be handed out."))>

<OBJECT THEATER-ENTRANCE-SIGN-ART-LANGUISHED (IN THEATER-ENTRANCE)
    (FLAGS NDESCBIT)
    (SYNONYM SIGN)
    (ADJECTIVE TIMINGS SHOWINGS SHOW)
    (FLAGS READBIT)
    (TEXT "Looking at the sign, it appears there is only one show today: \"Art, Languished\"")>

<ROUTINE THEATER-ENTRANCE-DOORS-F ()
    <COND
        (<VERB? OPEN>
            <TELL "For a moment you reach out with one of your gnarled hands towards the closest door.
You stop. There is no door handle, and you know there is no mechanism, at all, for these doors to open.
You retract your hand." CR>)
        
        (<VERB? EXAMINE>
            <TELL ,LOOKING-OUTSIDE-THEATER-DOORS CR>)>>

<ROOM THEATER-LOBBY (DESC "Main Lobby")
    (IN ROOMS)
    (GLOBAL THEATER-CARPET THEATER-LIGHTS)
    (FLAGS RLANDBIT LIGHTBIT)
    (NORTH TO THEATER-HALLWAY)
    (SOUTH TO THEATER-ENTRANCE)
    (LDESC "Echoes of extravagance, or a simulacrum of it. The wallpaper is more intact than the entrance. Small ornate glass fixtures are
spaced out along the walls. Along the walls, and between many of the light fixtures, are frames for the hanging of posters, or artwork. Northwards,
a hallway twists around the small concessions stand.")
    (THINGS
        (WALL) (WALLS PAPER WALLPAPER) ([EXAMINE] "The wallpaper is a sickly pink color. There are seemingly random black stains which run down
the wall, reminiscent of water stains. You can faintly make out the design, which once was a repeating hexagonal pattern."))>

<OBJECT THEATER-CONCESSIONS-STAND (DESC "Concessions Stand")
    (IN THEATER-LOBBY)
    (SYNONYM STAND BOOTH)
    (ADJECTIVE CONCESSIONS CONCESSION SNACK)
    (FLAGS NDESCBIT CONTBIT OPENBIT)
    (LDESC "A small, simple, concessions stand. Built of the same dark wood as so much else here. You can see from behind its dusted glass that there
are no food, or snacks, on display. From memory, you're not certain this stand ever truly had concessions. A vestigial decoration.")>

<ROOM THEATER-AUDIOTORIUM (DESC "Audiotorium")
    (IN ROOMS)
    (GLOBAL THEATER-CARPET THEATER-LIGHTS)
    (FLAGS RLANDBIT LIGHTBIT)
    (EAST TO THEATER-HALLWAY)
    (OUT TO THEATER-HALLWAY)
    (LDESC "A medium-sized audiotorium. Certainly a large one given the diminutive nature of the whole theater. The other aspect which stands out is how
pristine, how well cared for, especially when compared to how dilapidated every other location is. The curtains are a vibrant crimson. They still look soft,
as if they had very recently been washed, or cleaned. There are seven rows of seats.")>

<ROUTINE AUDIOTORIUM-ENTRY ()
    <COND
        ;"Prologue before first act, queue up the show"
        (<0? ,ACT-NUMBER>
            THE-SHOW-BEGINS)

        ;"Otherwise, if no special case is met, just enter the audiotorium"
        (ELSE
            THEATER-AUDIOTORIUM)>>

<OBJECT THEATER-JANITOR-DOOR (DESC "metal door")
    (IN LOCAL-GLOBALS)
    (SYNONYM DOOR SIGN)
    (ADJECTIVE OLD METAL STAFF)
    (FLAGS DOORBIT)
    (ACTION THEATER-JANITOR-DOOR-F)
    (LDESC "A heavy looking metal door. There are indents in the door, as if someone tried to break it down with their fists. The metal is a dark,
tarnished grey. Attached to the door is a sign. In faded red lettering it reads: \"STAFF ONLY\"")>

<ROUTINE THEATER-JANITOR-DOOR-F ()
    <COND
        ;"Close, and then lock the door if trying to lock an open door"
        (<AND <VERB? LOCK> <FSET? ,THEATER-JANITOR-DOOR ,OPENBIT>>
            <AND
                <PERFORM ,PLAYER ,V?CLOSE ,THEATER-JANITOR-DOOR>
                <PERFORM ,PLAYER ,V?LOCK ,THEATER-JANITOR-DOOR>>)>> 

<ROOM THEATER-HALLWAY (DESC "Hallway")
    (IN ROOMS)
    (GLOBAL THEATER-CARPET THEATER-LIGHTS THEATER-JANITOR-DOOR)
    (FLAGS RLANDBIT LIGHTBIT)
    (SOUTH TO THEATER-LOBBY)
    (NORTH TO THEATER-BATHROOM)
    (EAST TO THEATER-JANITORIAL IF THEATER-JANITOR-DOOR IS OPEN ELSE "You try the handle, and find the door to be locked shut.")
    (WEST PER AUDIOTORIUM-ENTRY)
    (LDESC "A small, dirty hallway. At the other end of the hallway, to the north, is what appears to be a small bathroom. Frames for the hanging
of posters are strewn around the walls between the light fixtures. A sole trash can sits nears the entrance to the audiotorium to the west of you.
A metal door with a sign on it is set into the wall east of you. To the south the hallway twists around the concessions stand to the lobby.")>

<OBJECT THEATER-HALLWAY-TRASH-STANDING (DESC "trash can")
    (IN THEATER-HALLWAY)
    (FLAGS NDESCBIT)
    (LDESC "A simple cylindrical trash can. It has a big circular hole on the top for the easy disposal of trash. You can see some old wrappers
and paper within it. The metal its made of has a few blemishes, dents. It has been here a long time.")>

<ROOM THEATER-JANITORIAL (DESC "Janitorial Closet")
    (IN ROOMS)
    (GLOBAL THEATER-JANITOR-DOOR)
    (FLAGS RLANDBIT LIGHTBIT)
    (OUT TO THEATER-HALLWAY)
    (WEST TO THEATER-HALLWAY IF THEATER-JANITOR-DOOR IS OPEN ELSE "You try the handle, and find the door to be locked shut.")
    (LDESC "")>

<ROOM THEATER-BATHROOM (DESC "Small Bathroom")
    (IN ROOMS)
    (FLAGS RLANDBIT LIGHTBIT)
    (SOUTH THEATER-HALLWAY)
    (OUT TO THEATER-HALLWAY)
    (LDESC "This is a small, somewhat delapidated bathroom. The floor is a porcelain tiling that once must have been pearly white, now
is mostly a grey, with some splotches parts eminating a distinct yellow-like color. There is a small porcelain sink with a broken mirror
mounted above it. There is a toilet sat beside you, though the mechanism to flush, has been shattered.")
    (THINGS
        <> (SINK) THEATER-BATHROOM-SINK-F
        (BROKEN BATHROOM) (MIRROR) THEATER-BATHROOM-MIRROR-F)>

<ROUTINE THEATER-BATHROOM-SINK-F ()
    <COND
        (<VERB? EXAMINE>
            <TELL "It is a simple looking sink. The spout and two handles on either side are a brass-like metal. Within the basin the
typical drain-cover is missing, and you can see the dark insides of the piping travelingh down.. and down.. For a moment, you forget
that there couldn't possibly be any functional plumbing here." CR>)

        (<VERB? TURN-ON>
            <TELL "You reach out, and with your twisted hand turn the handle. After a few moments where
nothing pours from the faucet, you turn the handle back." CR>)>>

<ROUTINE THEATER-BATHROOM-MIRROR-F ()
    <COND
        (<VERB? EXAMINE>
            <TELL "The mirror is broken, shattered into dozens of pieces. Each piece reflects a skewed, fragmented,
angle on your face. Not bare, but instead warped. You do not have eyes, and likewise you have no mouth. Your flesh
the ancient twisted bark of a tree. You've yet to spot any new rings." CR>)>>

