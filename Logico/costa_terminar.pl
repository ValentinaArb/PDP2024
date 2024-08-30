comida(hamburguesa,2000).
comida(panchitoConPapas,1500).
comida(lomitoCompleto,2500).
comida(caramelo,0).

atraccionTranquila(autitosChocadores,[chicos,adultos]).
atraccionTranquila(casaEmbrujada,[chicos,adultos]).
atraccionTranquila(laberinto,[chicos,adultos]).

atraccionTranquila(tobogan,[chicos]).
atraccionTranquila(calesita,[chicos]).

atraccionIntensa(barcoPirata,14).
atraccionIntensa(tazasChinas,6).
atraccionIntensa(simulador3D,2).

atraccionFuerte(abismoMortalRecargada,3,duracion(2,14)).
atraccionFuerte(paseoPorElBosque,0,duracion(0,45)).

atraccionAcuatica(elTorpedoSalpicon).
atraccionAcuatica(esperoQueHayasTraidoUnaMudaDeRopa).

/* nombre, dinero, edad, grupo,hambre, aburrimiento */
visitante(eusebio,3000,80,viejitos,50,0).
visitante(carmela,0,80,viejitos,0,25).
visitante(valentina,10,19,individual,100,0).
visitante(felipe,4000,19,individual,1000,40).

/* punto 2 */
estadoDeBienestar(visitante(_,_,_,Situacion,Hambre,Aburrimiento),EstadoDeBienestar) :- 
    Estado is Hambre + Aburrimiento,
    condicionesEstadoDeBienestar(Situacion,Estado,EstadoDeBienestar).

condicionesEstadoDeBienestar(Situacion,0, felicidadPlena):- Situacion \= individual.
condicionesEstadoDeBienestar(individual,Estado, podriaEstarMejor) :- between(0,50,Estado).
condicionesEstadoDeBienestar(_,Estado, podriaEstarMejor) :- between(1,50,Estado).
condicionesEstadoDeBienestar(_,Estado, necesitaEntretenerse) :- between(51,99,Estado).
condicionesEstadoDeBienestar(_,Estado, seQuiereIr) :- Estado >= 100.

grupoFamiliar(Grupo):-
    visitante(_,_,_,Grupo,_,_), 
    Grupo \= individual.

/* punto 3 */
satisfaceHambre(Grupo,Comida):- 
    forall(visitante(_,_,_,Grupo,_,_),tieneDineroSuficiente(visitante(_,_,_,Grupo,_,_),Comida)),
    forall(visitante(_,_,_,Grupo,_,_),satisface(Comida,visitante(_,_,_,Grupo,_,_))).

tieneDineroSuficiente(visitante(_,Dinero,_,_,_,_),comida(Nombre,Precio)) :- Dinero > Precio, comida(Nombre,Precio).

satisface(comida(hamburguesa,_),visitante(_,_,_,_,Hambre,_)):- Hambre < 50.
satisface(comida(panchitoConPapas,_),visitante(_,_,Edad,_,_,_)):- Edad < 18.
satisface(comida(lomitoCompleto,_),_).
satisface(comida(caramelo,_),Persona):- Comida \= comida(caramelo,_),tieneDineroSuficiente(Persona,Comida).