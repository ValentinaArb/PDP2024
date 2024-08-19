persona(Persona):- atiende(Persona,_,_).
dia(Dia):- atiende(_,Dia,_).

atiende(donain,lunes,hora(9,15)).
atiende(donain,miercoles,hora(9,15)).
atiende(donain,viernes,hora(9,15)).
atiende(lucas,martes,hora(10,20)).
atiende(juanC,sabado,hora(18,22)).
atiende(juanC,domingo,hora(18,22)).
atiende(juanFdS,jueves,hora(10,20)).
atiende(juanFdS,viernes,hora(12,20)).
atiende(leoC,lunes,hora(14,18)).
atiende(leoC,miercoles,hora(14,18)).
atiende(martu,miercoles,hora(23,24)).

/* punto 1 */
atiende(vale,Dia,Hora) :- atiende(donain,Dia,Hora).
atiende(vale,Dia,Hora) :- atiende(juanC,Dia,Hora).

/* punto 2 */
quienAtiende(Persona,Dia,Hora) :- atiende(Persona,Dia,hora(Inicio,Fin)), Hora >= Inicio, Fin >= Hora.

/* punto 3 */
foreverAlone(Persona,Dia,Hora) :- 
    quienAtiende(Persona,Dia,Hora),
    quienAtiende(OtraPersona,Dia,Hora),
    not(Persona \= OtraPersona).

/* punto 4 */
/* posibleAtencion(Dia,Lista) :- 
    persona(Persona),
    findall(Persona, atiende(Persona,Dia,_),Lista).
 */

venta(dodain,fecha(lunes,10,agosto),[golosinas(1200),cigarrillos([jockey]),golosinas(50)]).
venta(dodain,fecha(miercoles,12,agosto),[bebida(alcoholica,8),bebida(no-alcoholica,1),golosinas(10)]).
venta(martu,fecha(miercoles,12,agosto),[golosinas(1000),cigarrillos([chesterfield,colorado,parisiennes])]).
venta(lucas,fecha(martes,11,agosto),[golosinas(600)]).
venta(lucas,fecha(martes,18,agosto),[bebida(no-alcoholica,2),cigarrillos([derby])]).

ventaImportante(golosinas(Precio)):- Precio>100.
ventaImportante(cigarrillos(Marcas)):- length(Marcas)>2.
ventaImportante(bebida(alcoholica,_)).
ventaImportante(bebida(_,Cantidad)):- Cantidad>8.