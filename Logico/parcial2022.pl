
/* usuario(nickname,cantidadSuscriptores,video()).

video(titulo,duración,cantidadViews,likes).
short(duración,cantidadLikes,filtros).
stream. */

/* 1 */
usuario(markitocuchillos,45000,video(gatitoTocaElPiano,45,50,1000)).
usuario(markitocuchillos,45000,video(gatitoTocaElPiano2,65,2,2)).

usuario(sebaElDolar,5000,video(esElDolarOEsparta,60000,2000,1040500)).
usuario(sebaElDolar,5000,stream).

usuario(tiqtoqera,40000,short(15,800000,[goldenHauer,cirugiaEstetica])).
usuario(tiqtoqera,40000,short(20,0,[])).
usuario(tiqtoqera,40000,stream).

usuario(user99018,1,sinContenido).

esUsuario(Usuario):- usuario(Usuario,_,_).

/* 2 */
esMytuber(Usuario):-
    usuario(Usuario,_,Contenido),
    Contenido \= sinContenido.

/* 3 */
esMilenial(Usuario):-
    usuario(Usuario,_,video(_,_,_,1000)).

esMilenial(Usuario):-
    usuario(Usuario,_,video(_,_,1000000,_)).

/* 4 */
subioVideo(Usuario):-
    usuario(Usuario,_,video(_,_,_,_)).

noSubioVideo(Usuario):-
    esUsuario(Usuario),
    not(subioVideo(Usuario)).

/* 5 */
engagement(video(_,_,Views,Likes),NivelEngagement):-
    floor(Views,ViewsSumar),
    NivelEngagement is Likes + ViewsSumar.

engagement(short(_,Likes,_),Likes).
engagement(streams,2000).

/* 6 */
punto(short(_,_,ListaFiltros),2):- 
    length(ListaFiltros,CantidadFiltros),
    CantidadFiltros>0.

punto(Contenido,1):- 
    engagement(Contenido,NivelEngagement),
    NivelEngagement > 10000.

punto(video(_,Duracion,_,_),2):- 
    Duracion > 6000.

punto(Contenido,1):-
    usuario(Usuario,_,Contenido),
    usuario(Usuario,_,OtroContenido),
    Contenido \= OtroContenido.

punto(Usuario,10):-
    esUsuario(Usuario),
    findall(NivelEngagement,(usuario(Usuario,_,Contenido),engagement(Contenido,NivelEngagement)),ListaEngagement),
    sum_list(ListaEngagement,TotalEngagement),
    TotalEngagement>1000000.

punto(Usuario,0):-
    esUsuario(Usuario),
    not(punto(Usuario,10)).

puntajeMytuber(Usuario,Puntaje):-
    esMytuber(Usuario),
    punto(Usuario,PuntoEngagement),
    findall(Punto,(usuario(Usuario,_,Contenido),punto(Contenido,Punto)),ListaEngagement),
    sum_list(ListaEngagement,PuntajeBase),
    Puntaje is PuntajeBase + PuntoEngagement.
    
/* 7 */
mytuberElegido(UsuarioElegido):-
    puntajeMytuber(UsuarioElegido,MayorPuntaje),
    forall(
    (puntajeMytuber(OtroUsuario,OtroPuntaje), UsuarioElegido \= OtroUsuario),
    MayorPuntaje>OtroPuntaje
    ).

/* 8 */
administra(martin,sebaElDolar).
administra(martin,markitocuchillos).
administra(iniaki,martin).
administra(iniaki,gaston).
administra(gaston,tiqtoqera).

representa(Manager,Mytuber):- 
    esMytuber(Mytuber),
    administra(Manager,Mytuber).

representa(Manager,Mytuber):- administra(Manager,OtroManager), representa(OtroManager,Mytuber).