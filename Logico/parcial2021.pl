/* Un alumno está conformado por su nombre (o nickname), edad e idioma nativo. Además de los alumnos se conoce el plan que tienen contratado(ver punto 7 para más detalle). 
Cada curso tiene veinte (20) niveles y el alumno está en determinado nivel (esto se mantiene fijo ya que la base de conocimientos es de consulta). */

idioma(ingles,gratuito).
idioma(espanol,gratuito).
idioma(portugues,gratuito).

idioma(italiano,premium).
idioma(hebreo,premium).
idioma(frances,premium).
idioma(chino,premium).

/* Cristian, que tiene 22 anos, es nativo del espanol, tiene una subscripción gratuita y está haciendo un curso de inglés (nivel 7) y portugués (nivel 15). */
alumno(cristian,22,espanol).
alumno(maria,34,ingles).
alumno(felipe,60,italiano).
alumno(juan,12,espanol).

suscripcion(cristian,gratuito).
suscripcion(maria,plan(premium,bronce)).
suscripcion(felipe,plan(premium,bronce)).
suscripcion(juan,plan(aCuentaGotas,6)).

curso(maria,nivel(hebreo,1)).
curso(cristian,nivel(ingles,7)).
curso(cristian,nivel(portugues,15)).
curso(juan,nivel(ingles,20)).

/* 2 */
nivelAvanzado(Alumno,Idioma):-
    curso(Alumno,nivel(Idioma,Nivel)),
    Nivel >= 15.

/* 3 */
tieneCertificado(Alumno,Idioma):- curso(Alumno,nivel(Idioma,20)).

/* 4 */
lenguaCodiciada(IdiomaNativo,IdiomaAprender):-
    alumno(_,_,IdiomaNativo),
    idioma(IdiomaAprender,_),
    forall(
        alumno(Alumno,_,IdiomaNativo),
        curso(Alumno,nivel(IdiomaAprender,_))
    ).

/* 5 */
habla(Persona,Idioma):- nivelAvanzado(Persona,Idioma).
habla(Persona,Idioma):- alumno(Persona,_,Idioma).

leFaltaAprender(Persona,Idioma):- 
    alumno(Persona,_,_),
    idioma(Idioma,_),
    not(habla(Persona,Idioma)).

/* 6 */
cantidadIdiomasQueHabla(Persona,CantidadIdiomas):-
    alumno(Persona,_,_),
    findall(
        Idioma,
        habla(Persona,Idioma),
        IdiomasQueHabla
    ),
    length(IdiomasQueHabla, CantidadIdiomas).

poliglota(Persona):-
    cantidadIdiomasQueHabla(Persona,CantidadIdiomas),
    CantidadIdiomas >= 3.
    
/* 7 */
puedeHacerCurso(Persona,Idioma):-    
    suscripcion(Persona,gratuito),
    idioma(Idioma,gratuito).

puedeHacerCurso(Persona,Idioma):- 
    alumno(Persona,_,_),
    suscripcion(Persona,Plan),
    idioma(Idioma,_),
    cantidadPuedeHacer(Plan,CantidadHacer),
    findall(
        Curso,
        curso(Persona,Curso),
        Cursos
    ),
    length(Cursos,CantidadCursos),
    CantidadCursos<CantidadHacer.

cantidadPuedeHacer(plan(aCuentaGotas,Cantidad),Cantidad).
cantidadPuedeHacer(plan(premium,bronce),3).
cantidadPuedeHacer(plan(premium,plata),7).

/* 8 */
sigue(christian, juan).
sigue(juan, martin).
sigue(martin, maria).

esExcentrica(Persona):- habla(Persona,esperanto).
esExcentrica(Persona):- habla(Persona,klingol).
esExcentrica(Persona):- habla(Persona,latin).

esExcentrica(Persona):- 
    alumno(Persona,_,_),
    not(habla(Persona,ingles)), 
    cantidadIdiomasQueHabla(Persona,CantidadIdiomas),
    CantidadIdiomas >= 5.

tieneExcentricismo(Persona):-
    alumno(Persona,_,_),
    forall(
        sigue(Seguidor,Persona),
        esExcentrica(Seguidor)
    ).

/* 9 */
conoce(Persona,Conocido):- sigue(Persona,Conocido).
conoce(Persona,Conocido):- 
    sigue(Persona,Conoce),
    sigue(Conoce,Conocido).

puedeTraducir(Persona,Idioma):-
    habla(Persona,Idioma).

puedeTraducir(Persona,Idioma):-
    conoce(Persona,Conocido),
    habla(Conocido,Idioma).