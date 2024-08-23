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

my_sum_elements([], 0).

my_sum_elements([X|Xs], S):-
          my_sum_elements(Xs, S2),
          S is S2 + X.

caloriasTotal(composicion(_,Lista),CantidadCalorias):- 
    findall(member(Ingrediente,Lista),caloriasIngrediente(Ingrediente,_),ListaCalorias),    
    my_sum_elements(ListaCalorias, CantidadCalorias).


caloriasIngrediente(ingrediente(Comida,Cantidad),CaloriasIngrediente):- calorias(Comida,Caloria), CaloriasIngrediente is Caloria * Cantidad.