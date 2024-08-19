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
