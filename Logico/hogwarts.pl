/* PARTE 1 */
sangreMago(harry,mestiza).
sangreMago(draco,pura).
sangreMago(hermione,impura).

caracteristicasMago(harry,[coraje,amistoso,orgullo,inteligencia]).
caracteristicasMago(draco,[orgullo,inteligencia]).
caracteristicasMago(hermione,[responsable,orgullo,inteligencia]).

odiaLaCasa(harry,slytherin).
odiaLaCasa(draco,hufflepuff).

esMago(Mago):- esDe(Mago,_).

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

todosSonAmistosos(ListaDeMagos):-
    forall(member(Mago,ListaDeMagos),(caracteristicasMago(Mago,Caracteristicas), member(amistoso,Caracteristicas))).

podriaCompartirCasa([_]). 

podriaCompartirCasa([Mago1, Mago2 | Resto]) :-
    posiblesCasas(Mago1, Casa),
    posiblesCasas(Mago2, Casa),
    podriaCompartirCasa([Mago2 | Resto]).

cadenaDeAmistades(ListaMagos):-
    todosSonAmistosos(ListaMagos),
    podriaCompartirCasa(ListaMagos).

/* PARTE 2 */
accion(harry,andarDeNoche).
accion(hermione,tercerPiso).
accion(hermione,seccionRestringida).
accion(harry,tercerPiso).
accion(harry,bosque).
accion(draco,mazmorras).
accion(ron,ganarPartida).
accion(hermione,salvarAmigos).
accion(harry,ganarleAVoldemort).
accion(hermione,responde(lugarBezoar,20,snape)).
accion(hermione,responde(levitarPluma,25,flitwick)).

puntos(seccionRestringida,-10).
puntos(bosque,-50).
puntos(tercerPiso,-75).
puntos(andarDeNoche,-50).
puntos(ganarPartida,50).
puntos(salvarAmigos,50).
puntos(ganarleAVoldemort,60).
puntos(responde(_,Puntos,Profesor),Puntos):- Profesor \= snape.
puntos(responde(_,Puntos,snape),PuntosFinales):- PuntosFinales is Puntos / 2.

puntos(_,0).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

/* Punto 1 */

malaAccion(Accion):- puntos(Accion, Puntaje), Puntaje < 0.

esBuenAlumno(Mago) :-
    esMago(Mago),
    forall(accion(Mago,Accion), not(malaAccion(Accion))).

esAccionRecurrente(Accion):-
    accion(Mago,Accion),
    accion(OtroMago,Accion),
    Mago \= OtroMago.

/* Punto 2 */

puntajeTotal(Casa, TotalPuntosCasa) :-
    esCasa(Casa),
    findall(Puntaje,
        (esDe(Mago, Casa),
         accion(Mago, Accion),
         puntos(Accion, Puntaje),
         Puntaje \= 0), 
        ListaPuntosCasa),
    sum_list(ListaPuntosCasa,TotalPuntosCasa).

/* Punto 3 */

casaGanadora(EsCasaGanadora):-
    esCasa(EsCasaGanadora),
    puntajeTotal(EsCasaGanadora, MaximoPuntaje),
    forall(
        (esCasa(Casa),puntajeTotal(Casa, Puntaje),Casa\= EsCasaGanadora), MaximoPuntaje>=Puntaje).

/* Punto 4 */
/* 
accion(hermione,responde(lugarBezoar,20,snape)).
accion(hermione,responde(levitarPluma,25,flitwick)).

puntos(responde(_,Puntos,Profesor),Puntos):- Profesor \= snape.
puntos(responde(_,Puntos,snape),PuntosFinales):- PuntosFinales is Puntos / 2.
*/