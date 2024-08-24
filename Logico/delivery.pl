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
    findall(Calorias, 
        (member(Ingrediente, Ingredientes), 
            caloriasIngrediente(Ingrediente, Calorias)), 
        ListaCalorias),
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
    