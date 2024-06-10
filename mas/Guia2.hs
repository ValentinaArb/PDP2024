{- 1
Definir una función siguiente, que al invocarla con un número cualquiera me devuelve el resultado de sumar a ese número el 1. 
Main> siguiente 3
4  -} 
siguiente x = x+1

{- 2
Definir la función mitad que al invocarla con un número cualquiera me devuelve la mitad de dicho número, ej: 
Main> mitad 5
2.5-} 
mitad x= x/2 

{- 3
Definir una función inversa, que invocando a la función con un número cualquiera me devuelva su inversa. 
Main> inversa 4
0.25
Main> inversa 0.5
2.0-}
inversa x= 1/x

{- 4
Definir una función triple, que invocando a la función con un número cualquiera me devuelva el triple del mismo.
Main> triple 5 
15-}
triple x = 3*x

{- 5
Definir una función esNumeroPositivo, que invocando a la función con un número cualquiera me devuelva true si el número es positivo y false en caso contrario. 
Main> esNumeroPositivo (-5)
False
Main> esNumeroPositivo 0.99
True 
 -}
esNumeroPositivo x = x>0 

{- 6
Resolver la función del ejercicio 2 de la guía anterior esMultiploDe/2, utilizando aplicación parcial y composición.-}

{-7
 Resolver la función del ejercicio 5 de la guía anterior esBisiesto/1, utilizando aplicación parcial y composición.
 -}

{- 8
Resolver la función inversaRaizCuadrada/1, que da un número n devolver la inversa su raíz cuadrada. 
Main> inversaRaizCuadrada 4 
0.5  
Nota: Resolverlo utilizando la función inversa Ej. 2.3, sqrt y composición.-}
inversaRaizCuadrada x = inversa(sqrt x)

{- 9
Definir una función incrementMCuadradoN, que invocándola con 2 números m y n, incrementa un valor m al cuadrado de n por Ej: 
Main> incrementMCuadradoN 3 2 
11  
Incrementa 2 al cuadrado de 3, da como resultado 11. Nota: Resolverlo utilizando aplicación parcial y composición. -}

{- 10
Definir una función esResultadoPar/2, que invocándola con número n y otro m, devuelve true si el resultado de elevar n a m es par. 
Main> esResultadoPar 2 5 
True 
Main> esResultadoPar 3 2
False 
Nota Obvia: Resolverlo utilizando aplicación parcial y composición. -}