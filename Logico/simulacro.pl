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

entrevista(amigazo,[vistas(jueves,1500),vistas(sabado,14500)]).
entrevista(hellMusic,[vistas(lunes,200),vistas(martes,70000)]).
entrevista(zulemaLogato,[vistas(domingo,100000)]).

dia(lunes,semana).
dia(martes,semana).
dia(miercoles,semana).
dia(jueves,semana).
dia(viernes,semana).
dia(sabado,finDeSemana).
dia(domingo,finDeSemana).

talentosOcultos(Protagonista):- 
    talento(Protagonista,_),
    not(entrevista(Protagonista,_)).

esMultifacetico(Protagonista):-
    talento(Protagonista,Talento),
    talento(Protagonista,OtroTalento),
    Talento \= OtroTalento.

nivelTalento(actuar,35).
nivelTalento(cantar(NivelCanto,ListaEstilos),NivelCanto):- length(ListaEstilos, 1).
nivelTalento(cantar(NivelCanto,ListaEstilos),Carisma):- Carisma is NivelCanto * 2, length(ListaEstilos, LargoLista),LargoLista \= 1.
nivelTalento(hablar(ceceoso),Carisma):- Carisma is 40 + 25. /* cambiar creo */
nivelTalento(hablar(_),40).

carisma(Protagonista,Carisma):-
    findall(NivelCarisma,(talento(Protagonista,Talento),nivelTalento(Talento,NivelCarisma)),ListaCarisma),
    sum_list(ListaCarisma,Carisma).

calculoFama(semana,Vistas,Carisma,Fama):- Fama is Vistas * 0.1 * Carisma.    
calculoFama(finDeSemana,Vistas,Carisma,Fama):- Fama is Vistas * 0.5 * Carisma.   

fama(Protagonista,Fama):-
    protagonista(Protagonista),
    entrevista(Protagonista,ListaVistas),    
    carisma(Protagonista,Carisma),
    findall(NivelFama,(member(vistas(Dia,Vistas),ListaVistas),dia(Dia,TipoDia),calculoFama(TipoDia,Vistas,Carisma,NivelFama)),ListaFama),
    sum_list(ListaFama,Fama).

carismaResultante(Talento,Protagonista,Carisma):- 
    talento(Protagonista,Talento),
    carisma(Protagonista,Carisma).

carismaResultante(Talento,Protagonista,Carisma):- 
    not(talento(Protagonista,Talento)),
    carisma(Protagonista,BaseCarisma),
    nivelTalento(Talento,MasCarisma),
    Carisma is BaseCarisma + MasCarisma.

masApto(Talento,Protagonista):-
    protagonista(Protagonista),
    carismaResultante(Talento,Protagonista,Carisma),
    forall((protagonista(OtroProtagonista),carismaResultante(Talento,OtroProtagonista,OtroCarisma)), Carisma >= OtroCarisma).

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
seLaPudre(Protagonista1,Protagonista2):- amigo(Protagonista1,AmigoProtagonista1), seLaPudre(AmigoProtagonista1,Protagonista2).