puestoHamburguesas(2000).
puestoPanchitosConPapas(1500).
puestoLomitosCompletos(2500).
puestoCaramelos(0).

autitosChocadores(atraccionTranquila,[chicos,adultos]).
casaEmbrujada(atraccionTranquila,[chicos,adultos]).
laberinto(atraccionTranquila,[chicos,adultos]).

tobogan(atraccionTranquila,[chicos]).
calesita(atraccionTranquila,[chicos]).

barcoPirata(atraccionIntensa,14).
tazasChinas(atraccionIntensa,6).
simulador3D(atraccionIntensa,2).

abismoMortalRecargada(atraccionFuerte,3,duracion(2,14)).
paseoPorElBosque(atraccionFuerte,0,duracion(0,45)).

elTorpedoSalpicon(atraccionAcuatica).
esperoQueHayasTraidoUnaMudaDeRopa(atraccionAcuatica).

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

