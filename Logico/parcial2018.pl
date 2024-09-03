% contenido( Titulo, Contenido)
%    peli(Protagonistas, Reparto)
%    serie(Temporada, Protagonistas, Reparto) 
contenido(secretoDeTusOjos, peli([darin, villamil, rago, francella ], [ alarcon, gioia ])).
contenido(elPadrino,peli([alpaccino,brando], [_] )).
contenido(avengers, peli([downeyjr,evans,ruffalo,hemsworth,johansson,pratt],[samuelJackson,dinklage])).
contenido(friends, serie(1, [cox,anniston], [typer])).
contenido(friends, serie(8, [cox,anniston], [pitt])).

% personaje(Nombre, Fans, Skills)
personaje(brando, 4000, [violento, pokerFace]).
personaje(pratt, 2000, [carilindo, comico]).
personaje(francella, 200, [comico, serio]).

persona(Personaje):- personaje(Personaje,_,_).

/* 1 */
popular(Personaje):- 
    personaje(Personaje,CantidadFans,_),
    CantidadFans > 3000.

/* 2 */
perteneceAlContenido(Actor,Protagonistas,_):- member(Actor,Protagonistas).
perteneceAlContenido(Actor,_,Reparto):- member(Actor,Reparto).

participo(Actor,Contenido):-
    persona(Actor),
    contenido(Contenido, peli(Protagonistas,Reparto)),
    perteneceAlContenido(Actor,Protagonistas,Reparto).

participo(Actor,Contenido):-
    persona(Actor),
    contenido(Contenido, serie(_,Protagonistas,Reparto)),
    perteneceAlContenido(Actor,Protagonistas,Reparto).
    
/* 3 */
participoSerie(Actor):-
    contenido(_, serie(_,Protagonistas,Reparto)),
    perteneceAlContenido(Actor,Protagonistas,Reparto).

esEstrellitaDeCine(Actor):-
    persona(Actor),
    not(participoSerie(Actor)).

/* 4 */
/* También, a los docentes les interesa que sepan decir si un actor es de pantalla grande, que eso pasa si participó en al menos un contenido que sea película. */
