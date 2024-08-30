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

entrevista(amigazo,jueves, 1500).
entrevista(amigazo,sabado, 14500).
entrevista(hellMusic,lunes,200).
entrevista(hellMusic,martes,70000).
entrevista(zulemaLogato,domingo,100000).

finde(sabado).
finde(domingo).
diaDeSemana(Dia):- dia(Dia), not(finde(Dia)).
dia(Dia):- member(Dia, [lunes, martes, miercoles, jueves, viernes, sabado, domingo]).

talentosOcultos(Protagonista):- 
    talento(Protagonista,_),
    not(entrevista(Protagonista,_,_)).

esMultifacetico(Protagonista):-
    talento(Protagonista,Talento),
    talento(Protagonista,OtroTalento),
    Talento \= OtroTalento.

indiceSegun(1,1).
indiceSegun(Cantidad,2):- Cantidad>1.

nivelTalento(desmayarse,0).
nivelTalento(actuar,35).
nivelTalento(cantar(NivelCanto,ListaEstilos),Carisma):- 
    length(ListaEstilos, Cantidad),
    indiceSegun(Cantidad,Indice),
    Carisma is NivelCanto * Indice.

nivelTalento(hablar(Estilo),40):- Estilo \= ceceoso.
nivelTalento(hablar(ceceoso),Carisma):- 
    nivelTalento(hablar(noCeceoso),CarismaBase),
    Carisma is CarismaBase + 25.

carisma(Protagonista,Carisma):-
    protagonista(Protagonista),
    findall(NivelCarisma,(talento(Protagonista,Talento),nivelTalento(Talento,NivelCarisma)),ListaCarisma),
    sum_list(ListaCarisma,Carisma).

indiceSegunDia(Dia,0.1):- diaDeSemana(Dia). 
indiceSegunDia(Dia,0.5):- finde(Dia). 

famaEntrevista(Dia,Vistas,Carisma,FamaEntrevista):-     
    indiceSegunDia(Dia,Indice),
    FamaEntrevista is Vistas * Indice * Carisma.

fama(Protagonista,FamaTotal):-
    protagonista(Protagonista),
    findall(Fama,(entrevista(Protagonista,Dia,Vistas),carisma(Protagonista,Carisma),famaEntrevista(Dia,Vistas,Carisma,Fama)),ListaFama),
    sum_list(ListaFama,FamaTotal).

carismaExtra(Talento,Protagonista,0):- talento(Protagonista,Talento).

carismaExtra(Talento,Protagonista,CarismaExtra):- not(talento(Protagonista,Talento)),carisma(Protagonista,CarismaExtra).

carismaTotal(Talento,Protagonista,Carisma):-
    carisma(Protagonista,CarismaBase),
    carismaExtra(Talento,Protagonista,CarismaExtra),
    Carisma is CarismaBase + CarismaExtra.

masApto(Talento,Protagonista):-
    protagonista(Protagonista),
    carismaTotal(Talento,Protagonista,Carisma),
    forall((protagonista(OtroProtagonista),carismaTotal(Talento,OtroProtagonista,OtroCarisma)), Carisma >= OtroCarisma).

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