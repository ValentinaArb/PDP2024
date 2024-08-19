persona(bakunin).
persona(ravachol).
persona(rosaDubovsky).
persona(emmaGoldman).
persona(judithButler).
persona(elisaBachofen).
persona(juanSuriano). 
persona(sebastienFaure).

habilidad(bakunin, conducirAutos).
habilidad(ravachol, tiroAlBlanco).
habilidad(rosaDubovsky, contruirPuentes).
habilidad(rosaDubovsky, mirarPeppaPig).
habilidad(judithButler, judo).
habilidad(elisaBachofen, armarBombas).
habilidad(emmaGoldman, Habil):- habilidad(judithButler, Habil).
habilidad(emmaGoldman, Habil):- habilidad(elisaBachofen, Habil).
habilidad(juanSuriano, judo).
habilidad(juanSuriano, armarBombas).
habilidad(juanSuriano, ringRaje).

gusto(ravachol, juegosAzar).
gusto(ravachol, ajedrez).
gusto(ravachol, tiroAlBlanco).
gusto(rosaDubovsky, contruirPuentes).
gusto(rosaDubovsky, mirarPeppaPig).
gusto(rosaDubovsky, fisicaCuantica).
gusto(judithButler, judo).
gusto(judithButler, carrerasAutomovilismo).
gusto(emmaGoldman, Hobby) :- gusto(judithButler, Hobby). 
gusto(elisaBachofen, fuego).
gusto(elisaBachofen, destruccion).
gusto(juanSuriano, judo).
gusto(juanSuriano, armarBombas).
gusto(juanSuriano, ringRaje).

historial(bakunin, roboAeronaves).
historial(bakunin, fraude).
historial(bakunin, tenenciaDeCafeina).
historial(ravachol, falsificacionVacunas).
historial(ravachol, fraude).
historial(judithButler, falsificacionCheques).
historial(judithButler, fraude).
historial(juanSuriano, falsificacionDinero).
historial(juanSuriano, fraude).


/* SOLUCIÓN DANI:


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

persona(bakunin).
persona(ravachol).
persona(rosaDubovsky).
persona(emmaGoldman).
persona(judithButler).
persona(elisaBachofen).
persona(juanSuriano).
persona(sebastianFaure).

trabajaEn(aviacionMilitar,bakunin).
trabajaEn(inteligenciaMilitar,ravachol).
trabajaEn(recolectorDeBasura,rosaDubovsky).
trabajaEn(asesinaASueldo,rosaDubovsky).
trabajaEn(profesoraDeJudo,emmaGoldman).
trabajaEn(cineasta,emmaGoldman).
trabajaEn(profesoraDeJudo,judithButler).
trabajaEn(inteligenciaMilitar,judithButler).
trabajaEn(ingenieriaMecanica,elisaBachofen).

leGusta(juegosDeAzar,ravachol).
leGusta(ajedrez,ravachol).
leGusta(tiroAlBlanco,ravachol).
leGusta(construirPuentes,rosaDubovsky).
leGusta(mirarPeppaPig,rosaDubovsky).
leGusta(fisicaCuantica,rosaDubovsky).
leGusta(Hobby,emmaGoldman):-
    leGusta(Hobby,judithButler).
leGusta(judo,judithButler).
leGusta(carrerasDeAutomovilismo,judithButler).
leGusta(fuego,elisaBachofen).
leGusta(destruccion,elisaBachofen).
leGusta(judo,juanSuriano).
leGusta(armarBombas,juanSuriano).
leGusta(ringRaje,juanSuriano).

habilidadDe(conducirAutos,bakunin).
habilidadDe(tiroAlBlanco,ravachol).
habilidadDe(construirPuentes,rosaDubovsky).
habilidadDe(mirarPeppaPig,rosaDubovsky).
habilidadDe(Habilidad,emmaGoldman):-
    habilidadDe(Habilidad,judithButler).
habilidadDe(Habilidad,emmaGoldman):-
    habilidadDe(Habilidad,elisaBachofen).
habilidadDe(judo,judithButler).
habilidadDe(armarBombas,elisaBachofen).
habilidadDe(judo,juanSuriano).
habilidadDe(armarBombas,juanSuriano).
habilidadDe(ringRaje,juanSuriano).

historialCriminal([roboDeAeronaves,fraude,tenenciaDeCafeina],bakunin).
historialCriminal([falsificacionDeVacunas,fraude],ravachol).
historialCriminal([falsificacionDeCheques,fraude],judithButler).
historialCriminal([falsificacionDeDinero,fraude],juanSuriano).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

casa(laSeverino).
casa(comisaria48).
casa(laCasaDePapel).
casa(casaDelSolNaciente).

%cuartoSecreto(Largo,Ancho).
%pasadizo(Cantidad).
%tunelSecreto(Largo).

tiene(cuartoSecreto(4,8), laSeverino).
tiene(pasadizo(1), laSeverino).
tiene(tunelSecreto(8), laSeverino).
tiene(tunelSecreto(5), laSeverino).

tiene(pasadizo(2), laCasaDePapel).
tiene(cuartoSecreto(5,3), laCasaDePapel).
tiene(cuartoSecreto(4,7), laCasaDePapel).
tiene(tunelSecreto(9), laCasaDePapel).
tiene(tunelSecreto(2), laCasaDePapel).

tiene(pasadizo(1), casaDelSolNaciente).

viveEn(laSeverino,bakunin).
viveEn(laSeverino,elisaBachofen).
viveEn(laSeverino,rosaDubosvky).
viveEn(comisaria48,ravachol).
viveEn(laCasaDePapel,emmaGoldman).
viveEn(laCasaDePapel,juanSuriano).
viveEn(laCasaDePapel,judithButler).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tienePotencialRebelde(Casa):-
    viveEn(Casa,Persona),
    esDisidente(Persona),
    superficieClandestina(Casa,Superficie),
    Superficie > 50.

superficieClandestina(Casa,Superficie):-
    casa(Casa),
    findall(Area, areaIndividual(Casa,_,Area), ListaDeAreas),   
    sumlist(ListaDeAreas, Superficie).

areaIndividual(Casa,Escondite,Area):-
    tiene(Escondite,Casa),
    calculoArea(Escondite,Area).

calculoArea(cuartoSecreto(Largo,Ancho),Area):-
    Area is Largo*Ancho.
calculoArea(pasadizo(Cantidad),Cantidad).
calculoArea(tunelSecreto(Largo),Area):-
    Area is Largo*2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

viviendaVacia(Casa):-
    casa(Casa),
    not(viveEn(Casa,_)).

compartenGustosEn(Casa):-
    casa(Casa),
    not(viviendaVacia(Casa)),
    forall(viveEn(Casa,Persona), comparteGusto(Casa,Persona)).
    
comparteGusto(Casa,Persona):-
    leGusta(Accion,Persona),
    viveEn(Casa,OtraPersona),
    leGusta(Accion,OtraPersona), 
    Persona \= OtraPersona.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

esDisidente(Persona):-
    tieneHabilidadTerrorista(Persona),
    gustosComplicados(Persona),
    criminal(Persona).

tieneHabilidadTerrorista(Persona):-
    habilidadDe(Habilidad,Persona),
    esHabilidadTerrorista(Habilidad).

esHabilidadTerrorista(armarBombas).
esHabilidadTerrorista(tirarAlBlanco).
esHabilidadTerrorista(mirarAPeppaPig).

gustosComplicados(Persona):-
    not(leGusta(_,Persona)).
gustosComplicados(Persona):-
    forall(habilidadDe(Habilidad,Persona),leGusta(Habilidad,Persona)).

criminal(Persona):-
    tieneAntecedentes(Persona).
criminal(Persona):-
    viveEn(Casa,Persona),
    viveEn(Casa,OtraPersona),
    Persona \= OtraPersona,
    tieneAntecedentes(OtraPersona).

tieneAntecedentes(Persona):-
    historialCriminal(Historial, Persona),
    length(Historial, Crimenes),
    Crimenes > 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
Si en algún momento se agregara algún tipo nuevo de ambiente en las viviendas, 
por ejemplo bunkers que tienen un perímetro de acceso y una superficie interna, 
de manera de que la superficie total sea superficie interna + perímetro de acceso. 
¿Qué debe modificar de su solución actual?


Gracias al polimorfismo, la unica modificacion que se deberia hacer es agregar a nuestro universo 
un "tiene(bunkers(Perimetro, SuperficieInterna),Casa)"" y agregar una clausula de calculoArea:

calculoArea(bunkers(Perimetro, SuperficieInterna), Area):-
    Area is Perimetro + SuperficieInterna.
*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 7 (inversible) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* batallon(Personas):-
    findall(Persona, (distinct(persona(Persona),criminal(Persona))), PersonasPosibles),
    combinar(PersonasPosibles,Personas),
    habilidadesDeLista(Personas,Cantidad),
    Cantidad > 3.

%combinar lo sacamos de una resolución, del parcial del kioskito.
combinar([Persona|PersonasPosibles], [Persona|Personas]):-
    combinar(PersonasPosibles, Personas).
combinar([_|PersonasPosibles], Personas):-
    combinar(PersonasPosibles, Personas).
combinar([], []).

habilidadesDeLista(PersonasPosibles,Cantidad):-
    findall(Habilidad,(member(Persona,PersonasPosibles), habilidadDe(Habilidad,Persona)),ListaHabilidades),
    length(ListaHabilidades,Cantidad).

%El concepto que entra en juego es el manejo de listas y recursividad.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

terminamosElTp(true).
*/