jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

esJugador(Jugador):-
    jugador(Jugador,_,_).

/* punto 1 */

existeItem(Item):- 
    jugador(_,Items,_),
    member(Item,Items).

tieneItem(Jugador,Item):-
    jugador(Jugador,Items,_), 
    member(Item,Items).

sePreocupaPorSuSalud(Jugador):-
    jugador(Jugador,Items,_),
    member(Alimento,Items),
    comestible(Alimento),
    member(OtroAlimento,Items),
    comestible(OtroAlimento),
    Alimento\= OtroAlimento.

cantidadDeItem(Jugador,Item,Cantidad):-
    jugador(Jugador,Items,_),
    findall(Item,member(Item,Items),ListaItem),
    length(ListaItem, Cantidad).

tieneMasDe(Jugador,Item):-
    esJugador(Jugador),
    existeItem(Item),
    cantidadDeItem(Jugador,Item,Cantidad),
    forall((esJugador(OtroJugador),OtroJugador\=Jugador,cantidadDeItem(OtroJugador,Item,OtraCantidad)),Cantidad>OtraCantidad).

/* punto 2 */
hayMonstruo(Lugar):-
    lugar(Lugar,_,NivelOscuridad),
    NivelOscuridad>6.

lugarJugador(Jugador,Lugar):-
    lugar(Lugar,ListaJugadores,_),
    member(Jugador,ListaJugadores).

estaHambriento(Jugador):- jugador(Jugador,_,NivelHambre), NivelHambre<4.

tieneItemComestible(Jugador):- 
    comestible(Alimento),
    jugador(Jugador,ListaAlimento,_),
    member(Alimento,ListaAlimento).

correPeligro(Jugador):- 
    esJugador(Jugador),
    lugarJugador(Jugador,mina).

correPeligro(Jugador):- 
    esJugador(Jugador),
    estaHambriento(Jugador),
    not(tieneItemComestible(Jugador)).

porcentajeHambrientos(Lugar,Porcentaje):-
    lugar(Lugar,ListaJugadores,_),
    length(ListaJugadores,CantidadJugadores),
    CantidadJugadores\=0,
    findall(Hambrientos,(member(Hambrientos,ListaJugadores),estaHambriento(Hambrientos)),ListaHambrientos),
    length(ListaHambrientos,CantidadHambrientos),
    Porcentaje is CantidadHambrientos * 100 / CantidadJugadores.

nivelPeligrosidad(Lugar,NivelPeligrosidad):- not(hayMonstruo(Lugar)),porcentajeHambrientos(Lugar,NivelPeligrosidad).
nivelPeligrosidad(Lugar,100):- hayMonstruo(Lugar).
nivelPeligrosidad(Lugar,NivelPeligrosidad):- 
    lugar(Lugar,ListaJugadores,_),
    length(ListaJugadores,0),
    lugar(Lugar,_,NivelOscuridad),
    NivelPeligrosidad is NivelOscuridad * 10.

/* punto 3 */
item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).

puede(Jugador,itemSimple(Item,Cantidad)):- cantidadDeItem(Jugador,Item,CantidadDelJugador), CantidadDelJugador >= Cantidad.
puede(Jugador,itemCompuesto(Item)):- puedeConstruir(Jugador,Item).

puedeConstruir(Jugador,Item):-
    esJugador(Jugador), 
    item(Item,ListaItems),
    forall(member(PrimerItem,ListaItems),puede(Jugador,PrimerItem)).