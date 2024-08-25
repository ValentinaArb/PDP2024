/* punto 1 */
destino(dodian,[pehuenia,sanMartin,esquel,sarmiento,camarones,playasDoradas]).
destino(alf,[bariloche,sanMartin,elBolson]).
destino(nico,[marDelPlata]).
destino(vale,[calafate,elBolson]).
destino(martu,Destino):- destino(nico,DestinoNico),destino(alf,DestinoAlf), my_append(DestinoNico,DestinoAlf,Destino).
destino(valentina,[esquel,villaPehuenia]).
persona(Persona):- destino(Persona,_).

my_append([], Cs, Cs).
my_append([A|As],Bs,[A|Cs]):-
    my_append(As, Bs, Cs).

/* punto 2 */
atracciones(esquel,[parqueNacional(losAlerces),excursion(trochita),excursion(trevelin)]).
atracciones(villaPehuenia, [cerro(bateaMahuida,2000),cuerpoAgua(si,14),cuerpoAgua(si,19)]).

atraccionCopada(cerro(_,Altura)):- Altura>2000.
atraccionCopada(cuerpoAgua(si,_)).
atraccionCopada(cuerpoAgua(_,Temperatura)):- Temperatura>20.
atraccionCopada(playa(DiferenciaMarea)):- DiferenciaMarea<5.
atraccionCopada(excursion(Nombre)):- atom_length(Nombre, CantidadLetras), CantidadLetras>7.
atraccionCopada(parqueNacional(_)).

lugarTieneAtraccionCopada(Lugar) :-
    atracciones(Lugar, Atracciones),
    member(Atraccion, Atracciones),
    atraccionCopada(Atraccion).

vacacionesCopadas(Persona):-
    persona(Persona),
    destino(Persona,ListaDestinos),
    forall(member(Destino,ListaDestinos),lugarTieneAtraccionCopada(Destino)).

/* punto 3 */
/* Cuando dos personas distintas no coinciden en ningún lugar como destino decimos que no se cruzaron. Por ejemplo, Dodain no se cruzó con Nico ni con Vale (sí con Alf en San Martín de los Andes). Vale no se cruzó con Dodain ni con Nico (sí con Alf en El Bolsón). El predicado debe ser completamente inversible. */
seCruzaron(Persona1,Persona2):- 
    destino(Persona1,ListaDestinos1),
    destino(Persona2,ListaDestinos2),
    member(Destino,ListaDestinos1),
    member(Destino,ListaDestinos2).

noSeCruzaron(Persona1,Persona2):-     
    persona(Persona1),
    persona(Persona2),
    not(seCruzaron(Persona1,Persona2)).

/* punto 4 */
costoVida(sarmiento,100).
costoVida(esquel,150).
costoVida(pehuenia,180).
costoVida(sanMartin,150).
costoVida(camarones,135).
costoVida(playasDoradas,170).
costoVida(bariloche,140).
costoVida(elCalafate,240).
costoVida(elBolson,145).
costoVida(marDelPlata,140).

/* punto 4*/
destinoGasolero(Destino):- costoVida(Destino,Costo),Costo<160.
vacacionesGasoleras(Persona):-
    persona(Persona),
    destino(Persona,ListaDestino),
    forall(member(Destino,ListaDestino),destinoGasolero(Destino)).

/* punto 5 */
itinerariosPosibles(Persona,CombinacionesPosibles):-
    persona(Persona),
    destino(Persona,ListaDestinos),
    permutation(ListaDestinos,CombinacionesPosibles).
    
