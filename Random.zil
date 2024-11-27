<PACKAGE "RANDOM">

<ENTRY RANDINT PROB>

<ROUTINE RANDINT (MIN MAX) 
    <RETURN <+ <- .MIN 1> <RANDOM <- <+ .MAX 1> .MIN>>>>>

;"Given a percentage chance (from 1-100%) roll a random integer
from 1-100 and test against this probability, returning result."
<ROUTINE PROB (CHANCE)
    <RETURN <L=? <RANDINT 1 100> .CHANCE>>>

<ENDPACKAGE>