/*
para la natación sabemos el estilo preferido, la cantidad de metros diarios que recorre, y la cantidad de medallas que consiguió a lo largo de su carrera deportiva
para el fútbol conocemos las medallas, los goles convertidos y las veces que fue expulsado
para el rugby, queremos saber la posición que ocupa y luego la cantidad de medallas obtenidas
*/

% natacion: estilo preferido, metros nadados, medallas
practica(phelps, natacion(crawl, 5000, 35)).
practica(juan, natacion(pecho, 500, 0)).
% fútbol: medallas, goles marcados, veces que fue expulsado
practica(messi, futbol(30, 820, 4)).
practica(cape, futbol(0, 36, 0)).
% rugby: posición que ocupa, medallas
practica(pichot, rugby(mariscal, 1)).
practica(pablito, rugby(wing, 0)).
practica(falsoPhelps, rugby(nadador, 34)).
% polo: handicap, medallas
practica(inventado, polo(7,0)).

% Quiénes son nadadores
nadador(Persona) :- practica(Persona,natacion(_,_,_)).

% Medallas obtenidas
medallas(Medallas) :- practica(_,natacion(_,_,Medallas)).
medallas(Medallas) :- practica(_,futbol(Medallas,_,_)).
medallas(Medallas) :- practica(_,rugby(_,Medallas)).

cantidadMedallas(Persona,Medallas) :- practica(Persona, natacion(_,_,Medallas)).
cantidadMedallas(Persona,Medallas) :- practica(Persona, futbol(Medallas,_,_)).
cantidadMedallas(Persona,Medallas) :- practica(Persona, rugby(_,Medallas)).

% ¿Quién tiene más medallas que el resto? /* HACER */
    
% ¿Quién no tiene aún medallas?
sinMedallas(Persona) :- cantidadMedallas(Persona,0).

/* Buen deportista
Quiero saber si alguien es buen deportista
en el caso de la natación, si recorren más de 1.000 metros diarios o su estilo preferido es el crawl
en el caso del fútbol, si la diferencia de goles menos las expulsiones es más de 5
en el caso del rugby, si son wings o pilares*/

/* y si agregamos el polo que solo sabemos el handicap del jugador, es bueno si tiene un handicap mayor a 6 y no tiene medallas */

buenDeportista(Persona) :- practica(Persona, natacion(_, Metros, _)), Metros>1000.
buenDeportista(Persona) :- practica(Persona, natacion(Estilo, _, _)), Estilo==crawl.

buenDeportista(Persona) :- practica(Persona, rugby(Posicion, _)), Posicion==wing.
buenDeportista(Persona) :- practica(Persona, rugby(Posicion, _)), Posicion==pilar.

buenDeportista(Persona) :- practica(Persona, futbol(_,Goles,Expulsiones)), Goles-Expulsiones>5.

buenDeportista(Persona) :- practica(Persona, polo(Numero,_)), Numero>6.