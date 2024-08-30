findall(Unidad, unidad(Jugador,Unidad),Lista),
/* Agarra Unidad, la opera y si cumple, la mete en "Lista" */

forall(alcanzoTecnologia(_,Tecnologia),alcanzoTecnologia(Civilizacion,Tecnologia)).
/* para todas las tecnologias que se alcanzaron, si las alcanzó Civilización */

tieneCaracterApropiado(Mago, Casa) :-
    caracteristicasMago(Mago, CaracterMago),
    caracteristicasCasa(Casa, CaracterCasa),
    subset(CaracterCasa, CaracterMago). /* comprueba si caracterCasa está dentro de CaracterMago */

subset([], _).
subset([H|T], Lista) :-
    member(H, Lista),
    subset(T, Lista).

posibilidadesAtencion(Dia, Personas):-
    findall(Persona, distinct(Persona, atiende(Persona, Dia, _)), PersonasPosibles),
    combinar(PersonasPosibles, Personas). /* todas las posibles combinaciones de dos listas  */

combinar([], []).
combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).
