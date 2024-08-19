%% solucion.pl
%% alumno: 

/* punto 1
Modelar lo necesario para representar los jugadores, las civilizaciones y las tecnologías, de la forma más conveniente para resolver los siguientes puntos. */

jugador(Jugador) :-
    civilizacion(Jugador,_).

civilizacion(ana,romanos).
civilizacion(beto,incas).
civilizacion(carola,romanos).
civilizacion(dimitri,romanos).

esTecnologia(Tecnologia) :-
    desarrollo(_,Tecnologia).

desarrollo(ana,herreria).
desarrollo(ana,forja).
desarrollo(ana,emplumado).
desarrollo(ana,laminas).
desarrollo(beto,herreria).
desarrollo(beto,forja).
desarrollo(beto,fundicion).
desarrollo(carola,herreria).
desarrollo(dimitri,herreria).
desarrollo(dimitri,fundicion).

/* punto 2
Saber si un jugador es experto en metales, que sucede cuando desarrolló las tecnologías de herrería, forja y o bien desarrolló fundición o bien juega con los romanos.
En los ejemplos, Ana y Beto son expertos en metales, pero Carola y Dimitri no.*/

expertoEnMetales(Jugador) :- 
    desarrollo(Jugador, herreria),
    desarrollo(Jugador, forja), 
    desarrollo(Jugador, fundicion).

expertoEnMetales(Jugador) :- 
    desarrollo(Jugador, herreria),
    desarrollo(Jugador, forja), 
    civilizacion(Jugador, romanos).

/* punto 3
Saber si una civilización es popular, que se cumple cuando la eligen varios jugadores (más de uno).
En los ejemplos, los romanos son una civilización popular, pero los incas no. */

esPopular(Civilizacion) :- 
    civilizacion(Jugador,Civilizacion),
    civilizacion(OtroJugador,Civilizacion),
    Jugador \= OtroJugador.

/* punto 4
Saber si una tecnología tiene alcance global, que sucede cuando a nadie le falta desarrollarla.
En los ejemplos, la herrería tiene alcance global, pues Ana, Beto, Carola y Dimitri la desarrollaron. */

tieneAlcanceGlobal(Tecnologia) :- 
    esTecnologia(Tecnologia),
    forall(jugador(Jugador), desarrollo(Jugador, Tecnologia)).

/* punto 5
Saber cuándo una civilización es líder. Se cumple cuando esa civilización alcanzó todas las tecnologías que alcanzaron las demás. Una civilización alcanzó una tecnología cuando algún jugador de esa civilización la desarrolló.
En los ejemplos, los romanos son una civilización líder pues entre Ana y Dimitri, que juegan con romanos, ya tienen todas las tecnologías que fueron alcanzadas por cualquier otra civilización. */

alcanzoTecnologia(Civilizacion,Tecnologia) :- civilizacion(Jugador,Civilizacion), desarrollo(Jugador, Tecnologia).

esLider(Civilizacion) :-
    civilizacion(_,Civilizacion),
    forall(alcanzoTecnologia(_,Tecnologia),alcanzoTecnologia(Civilizacion,Tecnologia)).

/* punto 6
Modelar lo necesario para representar las distintas unidades de cada jugador */
unidad(ana,jinete(90,caballo)).
unidad(ana,piquero(55,conEscudo,1)).
unidad(ana,piquero(65,sinEscudo,2)).
unidad(beto,campeon(100)).
unidad(beto,campeon(80)).
unidad(beto,piquero(55,conEscudo,1)).
unidad(beto,jinete(80,camello)).
unidad(carola,piquero(70,sinEscudo,3)).
unidad(carola,piquero(71.5,conEscudo,2)).

/* punto 7 
Conocer la unidad con más vida que tiene un jugador*/
vidaUnidad(jinete(Vida, _), Vida).
vidaUnidad(campeon(Vida), Vida).
vidaUnidad(piquero(Vida, _, _), Vida).

vida(Jugador,Vida):- 
    unidad(Jugador,Unidad),
    vidaUnidad(Unidad, Vida),
    forall(
        vidaUnidad(_, OtraVida),
        Vida >= OtraVida
    ).

/* punto 8
Queremos saber si una unidad le gana a otra. Las unidades tienen una ventaja por tipo sobre otras. Cualquier jinete le gana a cualquier campeón, cualquier campeón le gana a cualquier piquero y cualquier piquero le gana a cualquier jinete, pero los jinetes a camello le ganan a los a caballo. En caso de que no exista ventaja entre las unidades, se compara la vida (el de mayor vida gana). 
Este punto no necesita ser inversible.
Por ejemplo, un campeón con 95 de vida le gana a otro con 50, pero un campeón con 100 de vida no le gana a un jinete a caballo.
 */

leGana(jinete(_,_),campeon(_)).
leGana(campeon(_),piquero(_,_,_)).
leGana(piquero(_,_,_),jinete(_,_)).
leGana(jinete(_,camello),jinete(_,caballo)).
/* Ver (depende del 7) leGana(Unidad1,Unidad2):- masVida(Unidad1,Unidad2). */
    
/* punto 9
Saber si un jugador puede sobrevivir a un asedio. Esto ocurre si tiene más piqueros con escudo que sin escudo.
En los ejemplos, Beto es el único que puede sobrevivir a un asedio, pues tiene 1 piquero con escudo y 0 sin escudo. */
