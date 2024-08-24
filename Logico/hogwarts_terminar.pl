/*findall(Unidad, unidad(Jugador,Unidad),Lista),
 Agarra Unidad, la opera y si cumple, la mete en "Lista" */

/* forall(alcanzoTecnologia(_,Tecnologia),alcanzoTecnologia(Civilizacion,Tecnologia)).
para todas las tecnologias que se alcanzaron, si las alcanzó Civilización */

/* 
tieneCaracterApropiado(Mago, Casa) :-
    caracteristicasMago(Mago, CaracterMago),
    caracteristicasCasa(Casa, CaracterCasa),
    subset(CaracterCasa, CaracterMago). //comprueba si caracterCasa está dentro de CaracterMago

subset([], _).
subset([H|T], Lista) :-
    member(H, Lista),
    subset(T, Lista).
 */

/* 
posibilidadesAtencion(Dia, Personas):-
    findall(Persona, distinct(Persona, atiende(Persona, Dia, _)), PersonasPosibles),
    combinar(PersonasPosibles, Personas). //todas las posibles combinaciones de dos listas 

combinar([], []).
combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).
*/

sangreMago(harry,mestiza).
sangreMago(draco,pura).
sangreMago(hermione,impura).

caracteristicasMago(harry,[coraje,amistoso,orgullo,inteligencia]).
caracteristicasMago(draco,[orgullo,inteligencia]).
caracteristicasMago(hermione,[responsable,orgullo,inteligencia]).

odiaLaCasa(harry,slytherin).
odiaLaCasa(draco,hufflepuff).

esMago(Mago):- sangreMago(Mago,_).

esCasa(gryffindor).
esCasa(slytherin).
esCasa(revenclaw).
esCasa(hufflepuff).

caracteristicasCasa(gryffindor,[coraje]).
caracteristicasCasa(slytherin,[orgullo,inteligencia]).
caracteristicasCasa(revenclaw,[inteligencia,responsable]).
caracteristicasCasa(hufflepuff,[amistoso]).

/* punto 1 */

lePermiteEntrar(slytherin,Mago) :-
    not(sangreMago(Mago,impura)).

lePermiteEntrar(Casa,Mago):- 
    esCasa(Casa),
    esMago(Mago),
    Casa \= slytherin.

/* punto 2 */

tieneCaracterApropiado(Mago, Casa) :-
    caracteristicasMago(Mago, CaracterMago),
    caracteristicasCasa(Casa, CaracterCasa),
    subset(CaracterCasa, CaracterMago).

subset([], _).
subset([H|T], Lista) :-
    member(H, Lista),
    subset(T, Lista).

/* punto 3 */

posiblesCasas(Mago,Casa):-
    tieneCaracterApropiado(Mago,Casa),
    lePermiteEntrar(Casa,Mago),
    not(odiaLaCasa(Mago,Casa)).

posiblesCasas(hermione,gryffindor).

/* punto 4 */

/* Definir un predicado cadenaDeAmistades/1 que se cumple para una lista de magos 
si todos ellos se caracterizan por ser amistosos y cada uno podría estar en la misma casa que el siguiente. */

todosSonAmistosos(ListaDeMagos):-
    member(Mago,ListaDeMagos),
    forall(caracteristicasMago(Mago,Caracteristicas), member(amistoso,Caracteristicas)).