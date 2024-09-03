protagonista(amigazo).
protagonista(zulemaLogato).
protagonista(hellMusic).
protagonista(ogiCuenco).
protagonista(elGigolo).

talento(amigazo, hablar(ceceoso)).
talento(amigazo, desmayarse).
talento(zulemaLogato, actuar).
talento(zulemaLogato, cantar(20, [teatro])).
talento(hellMusic, cantar(30, [deathMetal, rock])).
talento(hellMusic, hablar(ingles)).
talento(ogiCuenco, actuar).

esTalento(Talento):- talento(_,Talento).
/* 1 */
entrevista(amigazo,jueves, 1500).
entrevista(amigazo,sabado, 14500).
entrevista(hellMusic,lunes, 200).
entrevista(hellMusic,martes, 70000).
entrevista(zulemaLogato,domingo, 100000).

/* 2 */
talentosOcultos(Protagonista):- 
    talento(Protagonista,_),
    not(entrevista(Protagonista,_,_)).

/* 3 */
esMultifacetico(Protagonista):-
    talento(Protagonista,Talento),
    talento(Protagonista,OtroTalento),
    Talento\=OtroTalento.

/* 4 */
carisma(actuar,35).
/* carisma(desmayarse,0). */
carisma(cantar(NivelCanto, Estilos),NivelCanto):- length(Estilos,1).
carisma(cantar(NivelCanto, Estilos),Carisma):- 
    length(Estilos,Cantidad),
    Cantidad > 1,
    Carisma is NivelCanto * 2.
carisma(hablar(Idioma),Carisma):-
    calcularNivelExtra(Idioma,Extra),
    Carisma is 40 + Extra.

calcularNivelExtra(ceceoso,25).
calcularNivelExtra(Idioma,0):- Idioma \= ceceoso.

carismaTotal(Protagonista,TotalCarisma):-
    protagonista(Protagonista),
    findall(Carisma,(talento(Protagonista,Talento),carisma(Talento,Carisma)),Carismas),
    sum_list(Carismas,TotalCarisma).

/* 5 */
famaEntrevista(entrevista(Entrevistado,Dia, Vistas),FamaEntrevista):-
    dia(Dia,Tipo),
    multiplicador(Tipo,IndiceMultiplicador),
    carismaTotal(Entrevistado,CarismaTotal),
    FamaEntrevista is Vistas * IndiceMultiplicador * CarismaTotal.

multiplicador(semana,0.1).
multiplicador(finDeSemana,0.5).

dia(Dia,semana):- member(Dia, [lunes,martes,miercoles,jueves,viernes]).
dia(Dia,finDeSemana):- member(Dia, [sabado,domingo]).

fama(Protagonista,Fama):-
    protagonista(Protagonista),
    findall(FamaEntrevista,(entrevista(Protagonista,Dia,Vistas),famaEntrevista(entrevista(Protagonista,Dia, Vistas),FamaEntrevista)),Famas),
    sum_list(Famas,Fama).

/* 6 */
carismaQueSuma(Protagonista,Talento,0):- talento(Protagonista, Talento).
carismaQueSuma(Protagonista,Talento,CarismaQueSuma):- 
    protagonista(Protagonista),
    not(talento(Protagonista, Talento)),
    carisma(Talento,CarismaQueSuma).

masApto(ProtagonistaMasApto,Talento):-
    protagonista(ProtagonistaMasApto),
    esTalento(Talento),
    carismaTotal(ProtagonistaMasApto,Carisma),
    carismaQueSuma(ProtagonistaMasApto,Talento,CarismaQueSuma), 
    TotalCarisma is Carisma + CarismaQueSuma,
    forall(
        (protagonista(OtroProtagonista), 
        (carismaTotal(OtroProtagonista,OtroCarisma), carismaQueSuma(OtroProtagonista,Talento,OtroCarismaQueSuma), OtroTotalCarisma is OtroCarisma + OtroCarismaQueSuma),
        OtroProtagonista \= ProtagonistaMasApto), 
        TotalCarisma > OtroTotalCarisma
    ).

/* 7 */
amigo(zulemaLogato, inia).
amigo(hellMusic, martin).
amigo(amigazo, cappe).
amigo(amigazo, edu).
amigo(inia, martin).
amigo(martin, ogiCuenco).

bronca(samid, viale).
bronca(martin, amigazo).
bronca(ogiCuenco, mirtaLagrande).

seLaPudre(Protagonista1,Protagonista2):- bronca(Protagonista1,Protagonista2).
seLaPudre(Protagonista1,Protagonista2):- 
    amigo(Protagonista1,Amigo),
    seLaPudre(Amigo,Protagonista2).
