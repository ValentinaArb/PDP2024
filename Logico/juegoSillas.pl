amigo(juan, alberto).
amigo(juan, pedro).
amigo(pedro,mirta).
amigo(alberto, tomas).
amigo(tomas,mirta).

enemigo(mirta,ana).
enemigo(juan,nestor).
enemigo(juan,mirta).

mesaArmada(navidad2010,mesa(1,[juan,mirta,ana,nestor])).
mesaArmada(navidad2010,mesa(5,[andres,german,ludmila,elias])).
mesaArmada(navidad2010,mesa(8,[nestor,pedro])).

esFiesta(Fiesta):- mesaArmada(Fiesta,_).

esPersona(Persona):- amigo(Persona,_).
esPersona(Persona):- amigo(_,Persona).
esPersona(Persona):- enemigo(Persona,_).
esPersona(Persona):- enemigo(_,Persona).

estaSentadaEn(Persona,mesa(Numero,ListaIntegrantes)):-
    esPersona(Persona),
    mesaArmada(_,mesa(Numero,ListaIntegrantes)),
    member(Persona,ListaIntegrantes).

condicionNecesariaSentarse(Persona,PersonasSentadas):-
    esPersona(Persona),    
    not(member(Persona,PersonasSentadas)),
    amigo(Persona,Amigo),
    member(Amigo,PersonasSentadas).

sePuedeSentar(Persona,mesa(_,PersonasSentadas)):-    
    enemigo(Persona,Enemigo),    
    not(member(Enemigo,PersonasSentadas)),
    condicionNecesariaSentarse(Persona,PersonasSentadas).

sePuedeSentar(Persona,mesa(_,PersonasSentadas)):-
    condicionNecesariaSentarse(Persona,PersonasSentadas),
    not(enemigo(Persona,_)).

mesaDeCumpleaniero(Persona,mesa(1,PersonasMesa)):-
    esPersona(Persona),
    findall(Amigo,amigo(Persona,Amigo),ListaAmigos),
    append([Persona],ListaAmigos,PersonasMesa).

incompatible(Persona1,Persona2):- 
    esPersona(Persona1),
    esPersona(Persona2),
    esIncompatible(Persona1,Persona2).

esIncompatible(Persona1,Persona2):-
    amigo(Persona1,Comun),
    enemigo(Persona2,Comun).

esIncompatible(Persona1,Persona2):-
    amigo(Persona2,Comun),
    enemigo(Persona1,Comun).

laPeorOpcion(Persona,mesa(_,PersonasSentadas)):-
    esPersona(Persona),
    findall(Enemigo,enemigo(Persona,Enemigo),PersonasSentadas).

mesasPlanificadas(Fiesta,Mesas):-
    esFiesta(Fiesta),
    findall(Mesa,mesaArmada(Fiesta,Mesa),Mesas).

numeroMesa(mesa(Numero,_),Numero).
personasMesa(mesa(_,PersonasMesa),PersonasMesa).

numeracionCorrecta(Mesas) :-
    length(Mesas, N),
    findall(Numero, (member(Mesa, Mesas), numeroMesa(Mesa, Numero)), NumerosMesas),
    sort(NumerosMesas, NumerosOrdenados),
    findall(X, between(1, N, X), NumerosEsperados),
    NumerosOrdenados = NumerosEsperados.

esViable(Mesas):-
    numeracionCorrecta(Mesas),
    forall(member(Mesa,Mesas),(not(hayEnemigos(Mesa)),hayCantidadPersonas(Mesa))).

sonEnemigos(Persona1,Persona2):- enemigo(Persona1,Persona2).
sonEnemigos(Persona1,Persona2):- enemigo(Persona2,Persona1).

hayEnemigos(Mesa):-
    personasMesa(Mesa,PersonasMesa),
    member(Persona1,PersonasMesa),
    member(Persona2,PersonasMesa),
    sonEnemigos(Persona1,Persona2).

hayCantidadPersonas(Mesa):-
    personasMesa(Mesa,Personas),
    length(Personas,4).