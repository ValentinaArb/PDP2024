%composicion(plato, [ingrediente])%
composicion(platoPrincipal(milanesa),[ingrediente(pan,3),ingrediente(huevo,2),ingrediente(carne,2)]).
composicion(entrada(ensMixta),[ingrediente(tomate,2),ingrediente(cebolla,1),ingrediente(lechuga,2)]).
composicion(entrada(ensFresca),[ingrediente(huevo,1),ingrediente(remolacha,2),ingrediente(zanahoria,1)]).
composicion(postre(budinDePan),[ingrediente(pan,2),ingrediente(caramelo,1)]).

%calorías(nombreIngrediente, cantidadCalorias)%
calorias(pan,30).
calorias(huevo,18).
calorias(carne,40).
calorias(caramelo,170).

%proveedor(nombreProveedor, [nombreIngredientes])%
proveedor(disco, [pan, caramelo, carne, cebolla]).
proveedor(sanIgnacio, [zanahoria, lechuga, miel, huevo]).

/* 1) caloriasTotal/2, que relaciona un plato con su cantidad total de calorías por porción. 
Las calorías de un plato se calculan a partir de sus ingredientes.
P.ej. la milanesa tiene 206 calorías (30 * 3 + 18 * 2 + 40 * 2) por porción. */
caloriasTotales(Plato, CaloriasTotales) :-
    composicion(Plato, Ingredientes),
    findall(Calorias, (member(Ingrediente, Ingredientes), caloriasIngrediente(Ingrediente, Calorias)), ListaCalorias),
    sum_list(ListaCalorias, CaloriasTotales).

caloriasIngrediente(ingrediente(Comida,Cantidad),CaloriasIngrediente):- calorias(Comida,Caloria), CaloriasIngrediente is Caloria * Cantidad.

/* 3) platoSimpatico/1
Se dice que un plato es simpático si ocurre alguna de estas condiciones:
· incluye entre sus ingredientes al pan y al huevo.
· tiene menos de 200 calorías por porción.
En el ejemplo, la milanesa es simpática, mientras que el budín de pan no (tiene pan pero no
huevo, y tiene 230 calorías por porción).
Asegurar que el predicado sea inversible. */
/* platoSimpatico(Plato):-  */

incluyeIngrediente(Plato,Ingrediente):- 
    composicion(Plato,ListaIngredientes),
    member(ingrediente(Ingrediente,_),ListaIngredientes).

tieneMenosDeXCalorias(X,Plato):-
    caloriasTotales(Plato, CaloriasTotales),
    CaloriasTotales<X.

platoSimpatico(Plato):-
    incluyeIngrediente(Plato,pan),
    incluyeIngrediente(Plato,huevo).

platoSimpatico(Plato):- tieneMenosDeXCalorias(200,Plato).

/* 4) menuDiet/3
Tres platos forman un menú diet si: el primero es entrada, el segundo es plato principal, el
tercero es postre, y además la suma de las calorías por porción de los tres no supera 450. */

esMenuDiet(Plato1,Plato2,Plato3) :- 
    caloriasTotales(entrada(Plato1), Calorias1),
    caloriasTotales(platoPrincipal(Plato2), Calorias2),
    caloriasTotales(postre(Plato3), Calorias3),
    Calorias1 + Calorias2 + Calorias3 < 450.

/* 5) tieneTodo/2
Este predicado relaciona un proveedor con un plato, si el proveedor provee todos los
ingredientes del plato.
P.ej. Disco “tiene todo” para el budín de pan, pero no para la milanesa. */

tieneIngrediente(Proveedor,Ingrediente):- 
    proveedor(Proveedor,ListaProveedor),
    member(Ingrediente,ListaProveedor).

tieneTodo(Proveedor,Plato) :- 
    composicion(Plato,ListaPlato),
    forall(member(ingrediente(Ingrediente,_),ListaPlato), tieneIngrediente(Proveedor,Ingrediente)).

/* 6) ingredientePopular/1
Decimos que un ingrediente es popular si hay más de 3 platos que lo incluyen. */

ingredientePopular(Ingrediente) :- 
    incluyeIngrediente(Plato1,Ingrediente),
    incluyeIngrediente(Plato2,Ingrediente),
    incluyeIngrediente(Plato3,Ingrediente),
    Plato1 \= Plato2,
    Plato2 \= Plato3.

/* 7) cantidadTotal/3
Relaciona un ingrediente, una lista de cantidades por plato y la cantidad total de unidades del
ingrediente que hacen falta para fabricar la lista.
P.ej. si pregunto
?- cantidadTotal(pan, [cantidad(platoPrincipal(milanesa),5), cantidad(entrada(ensMixta),4), cantidad(postre(budinDePan),3)],Total).
Total = 21
(15 de las milanesas y 6 de los budines, la ensalada mixta no suma).
Pregunta adicional: indicar distintas formas de usar el predicado menuDiet/3, mencionando los
conceptos de múltiples respuestas y de inversibilidad; suponer que el predicado es inversible
para todos los argumentos. */

cantidadIngrediente(Plato,Ingrediente,CantidadPlatos,CantidadNecesaria):-
    composicion(Plato,ListaIngredientes),
    member(ingrediente(Ingrediente,Cantidad),ListaIngredientes),
    CantidadNecesaria is CantidadPlatos * Cantidad.
    

cantidadTotal(Ingrediente,ListaCantidades,Total) :-
    findall(CantidadNecesaria,member(cantidad(Plato,CantidadPlatos),ListaCantidades),cantidadIngrediente(Plato,Ingrediente,CantidadPlatos,CantidadNecesaria),ListaCantidad),
    sum_list(ListaCantidad, Total).

/*  cantidadTotal(pan, [cantidad(platoPrincipal(milanesa),5),cantidad(entrada(ensMixta),4), cantidad(postre(budinDePan),3)],Total).
 */