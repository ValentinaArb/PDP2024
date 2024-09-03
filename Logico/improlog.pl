/* grupo - persona - instrumento */
integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).
/* persona - instrumento - bienImprovisando */
nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

/* instrumento - rol */
instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

esPersona(Persona):- nivelQueTiene(Persona,_,_).
/* 1 */
tieneBuenaBase(Grupo):- 
    integrante(Grupo, Integrante1, Instrumento),
    instrumento(Instrumento,ritmico),
    integrante(Grupo, Integrante2, Instrumento),
    instrumento(Instrumento,armonico),
    Integrante1\= Integrante2.

/* 2 */
esDosPuntosMas(Nivel1,Nivel2):- Nivel1 >= (Nivel2 + 2).

seDestaca(Integrante,Grupo):-
    integrante(Grupo,Integrante,Instrumento),
    nivelQueTiene(Integrante, Instrumento, NivelConInstrumento),
    forall(
        (integrante(Grupo,OtroIntegrante,InstrumentoOtraPersona),nivelQueTiene(OtroIntegrante,InstrumentoOtraPersona,OtroNivel),esDosPuntosMas(NivelConInstrumento,OtroNivel)),
        Integrante\=OtroIntegrante
    ).

/* 3 */
grupo(vientosDelEste,bigBand).
grupo(estudio1,ensamble).
grupo(sophieTrio,[contrabajo,guitarra,violin]).
grupo(jazzmin,[bateria,bajo,trompeta,piano,guitarra]).

/* 4 */
instrumentosQueSirven(bigBand,[bateria, bajo, piano]).
instrumentosQueSirven(ensamble,_).
instrumentosQueSirven(Grupo,ListaInstrumentos):- grupo(Grupo,ListaInstrumentos).

hayCupo(NombreInstrumento,bigBand):- instrumento(NombreInstrumento, melodico(viento)).

hayCupo(NombreInstrumento,Grupo):-
    instrumento(NombreInstrumento,_),
    not(integrante(Grupo, _, NombreInstrumento)),
    instrumentosQueSirven(Grupo,ListaInstrumentos),
    member(NombreInstrumento,ListaInstrumentos).

/* 5 */
minimoEsperado(1,bigBand).
minimoEsperado(3,ensamble).

minimoEsperado(Indice,Grupo):-
    Grupo\=bigBand,
    instrumentosQueSirven(Grupo,ListaInstrumentos),
    length(ListaInstrumentos, CantidadInstrumentosBuscados),
    Indice is 7 - CantidadInstrumentosBuscados.

puedeIncorporarse(Persona,Grupo,NombreInstrumento):-
    instrumento(NombreInstrumento,_),
    esPersona(Persona),
    not(integrante(Grupo,Persona,_)),
    hayCupo(NombreInstrumento,Grupo),    
    minimoEsperado(Indice,Grupo),
    nivelQueTiene(Persona, NombreInstrumento, NivelConInstrumento),
    NivelConInstrumento>=Indice.

/* 6 */
quedoEnBanda(Persona,Grupo):-
    esPersona(Persona),
    not(integrante(Grupo, Persona, _)),
    not(puedeIncorporarse(Persona,Grupo,_)).

/* 7 */
puedeTocar(grupo(NombreGrupo,bigBand)):-
    tieneBuenaBase(NombreGrupo),
    findall(NombreInstrumento,(integrante(NombreGrupo,_,NombreInstrumento),instrumento(NombreInstrumento, melodico(viento))),ListaIntegrantes),
    length(ListaIntegrantes,Cantidad),
    Cantidad>=5.

puedeTocar(Grupo):-
    grupo(Grupo,Pertenece),
    Pertenece\=bigBand,
    instrumentosQueSirven(Grupo,ListaInstrumentos),
    forall(member(Instrumento,ListaInstrumentos),integrante(Grupo,_,Instrumento)).

/* 8 */
puedeTocar(ensamble):-
   tieneBuenaBase(ensamble),
   integrante(ensamble, _, Instrumento),
   instrumento(Instrumento, melodico(_)).