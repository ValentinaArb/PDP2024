{- {- ciudad = (nombre,anioFundacion,atracciones,costoDeVida) -}

baradero = ("baradero", 1615, ["Parque del Este", "Museo Alejandro Barbich"] ,150)
nullish = ("nullish", 1800, [] ,140)
caletaOlivia = ("Caleta Olivia", 1901, ["El Gorosito", "Faro Costanera"], 120) 
maipu = ("maipu" , 1878, ["Fortín Kakel"], 115)
azul = ("azul",1832,["Teatro Español", "Parque Municipal Sarmiento","Costanera Cacique Catriel"], 190)

fundacion(_,fundacion,_,_) = fundacion
atracciones(_,_,atracciones,_) = atracciones
costoDeVida(_,_,_,costoDeVida) = costoDeVida
isVowel character = character `elem` "aeiouAEIOU"

cantidadAtracciones ciudad = (length . atracciones) ciudad {- no funciona sin el ciudad, error en length -}

valorCiudad ciudad
    |fundacion(ciudad)<1800 = 5*(1800-fundacion(ciudad))
    |cantidadAtracciones(ciudad) == 0 = costoDeVida(ciudad)*2
    |otherwise = costoDeVida(ciudad)*3

{- HOLA -}
{- ciudadCopada ciudad = ["Teatro Español", "Parque Municipal Sarmiento","Costanera Cacique Catriel"] 3 -} -}