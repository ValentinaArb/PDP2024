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