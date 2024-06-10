import Text.Show.Functions
import Data.List
import Data.Char (toUpper)

type Objeto = Barbaro -> Barbaro

data Barbaro = Barbaro{
    nombre :: String,
    fuerza :: Int,
    habilidad :: [String],
    objeto :: [Objeto]
} deriving (Show)

dave :: Barbaro
dave = Barbaro "Dave" 100 ["tejer","escribirPoesia"] [ardilla, varitasDefectuosas]

valentina :: Barbaro
valentina = Barbaro "Valentina" 3000 ["tejeera","robar"] [ardilla, varitasDefectuosas, varitasDefectuosas]
felipe :: Barbaro
felipe = Barbaro "Felipe" 3000 ["tejeera","robar"] [ardilla, varitasDefectuosas, varitasDefectuosas]

añadirHabilidad :: String -> Barbaro -> Barbaro
añadirHabilidad nuevaHabilidad unBarbaro = unBarbaro {habilidad  = (habilidad unBarbaro) ++ [nuevaHabilidad]}
vaciarObjetos :: Barbaro -> Barbaro
vaciarObjetos unBarbaro = unBarbaro {objeto = []}
concatenarHabilidades :: Barbaro -> String
concatenarHabilidades unBarbaro = foldr1 (++) (habilidad unBarbaro)
convertirMayuscula :: String -> String
convertirMayuscula = map toUpper

espada :: Int -> Barbaro -> Barbaro
espada peso unBarbaro = unBarbaro {fuerza = (fuerza unBarbaro)+2*peso}
amuletoMistico :: String -> Barbaro -> Barbaro
amuletoMistico = añadirHabilidad
varitasDefectuosas :: Barbaro -> Barbaro
varitasDefectuosas = vaciarObjetos.añadirHabilidad "magia" 
ardilla :: Barbaro -> Barbaro
ardilla unBarbaro = unBarbaro
cuerda :: Objeto -> Objeto -> Barbaro -> Barbaro
cuerda primerObjeto segundoObjeto = primerObjeto.segundoObjeto

megafono :: Barbaro -> Barbaro
megafono unBarbaro = unBarbaro {habilidad = [convertirMayuscula.concatenarHabilidades $ unBarbaro]}

invasionDeSuciosDuendes :: Barbaro -> Bool
invasionDeSuciosDuendes unBarbaro = (elem) "Escribir Poesía Atroz".habilidad $ unBarbaro

sinPulgares :: String -> Bool
sinPulgares nombre = nombre == "Faffy" || nombre == "Astro"

cremalleraDelTiempo :: Barbaro -> Bool
cremalleraDelTiempo unBarbaro= sinPulgares (nombre unBarbaro)

saqueo :: Barbaro -> Bool
saqueo unBarbaro = (elem) "robar" (habilidad unBarbaro) && (>80) (fuerza unBarbaro)

cantidadObjetosBarbaro :: Barbaro -> Int
cantidadObjetosBarbaro = length.objeto

poderGritoDeGuerra :: Barbaro -> Int
poderGritoDeGuerra = length.concatenarHabilidades

gritoDeGuerra :: Barbaro -> Bool
gritoDeGuerra unBarbaro= poderGritoDeGuerra unBarbaro == ((*4).cantidadObjetosBarbaro $ unBarbaro)

isVowel :: Char -> Bool
isVowel c = c `elem` "aeiouAEIOU"

cantidadVocales :: String -> Int
cantidadVocales = length.filter isVowel

vocalesDeHabilidades :: Barbaro -> [Int]
vocalesDeHabilidades unBarbaro = map cantidadVocales (habilidad unBarbaro)

caligrafia :: Barbaro -> Bool
caligrafia unBarbaro = all (>3) (vocalesDeHabilidades unBarbaro)

pruebasQuePasa :: Barbaro -> [Bool]
pruebasQuePasa unBarbaro = [saqueo unBarbaro, gritoDeGuerra unBarbaro,caligrafia unBarbaro]

ritualDeFechorias :: Barbaro -> Bool
ritualDeFechorias unBarbaro= any (==True) (pruebasQuePasa unBarbaro)

type Evento = Barbaro -> Bool
type Aventura = [Evento]
ejemploAventura :: Aventura
ejemploAventura = [cremalleraDelTiempo,ritualDeFechorias]

sobreviveLaAventura :: Aventura -> Barbaro->Bool
sobreviveLaAventura aventura barbaro = all (\x-> x barbaro == True) aventura 

sobrevivientes :: Aventura -> [Barbaro] -> [String]
sobrevivientes aventura barbaros = map nombre (filter (sobreviveLaAventura aventura) barbaros)

sinRepetidos :: [String] -> [String]
sinRepetidos []=[]
sinRepetidos (x:xs) 
    |elem x xs = sinRepetidos xs
    |otherwise = [x]++ sinRepetidos xs

{- 
El descendiente de un bárbaro comparte su nombre, y un asterisco por cada generación. Por ejemplo "Dave*", "Dave**" , "Dave***" , etc. 
Además, tienen en principio su mismo poder, habilidades sin repetidos, y los objetos de su padre, pero antes de pasar a la siguiente generación, utilizan (aplican sobre sí mismos) los objetos. Por ejemplo, el hijo de Dave será equivalente a:
(ardilla.varitasDefectuosas) (Barbaro "Dave*" 100 ["tejer","escribirPoesia"] [ardilla, varitasDefectuosas])
Definir la función descendientes, que dado un bárbaro nos de sus infinitos descendientes. 
C. Pregunta: ¿Se podría aplicar sinRepetidos sobre la lista de objetos? ¿Y sobre el nombre de un bárbaro? ¿Por qué?
-}

{- aplicarObjetos :: Barbaro -> Barbaro
aplicarObjetos unBarbaro = foldl (flip($)) unBarbaro (objeto unBarbaro)
-}
modificarNombre :: Barbaro -> Barbaro
modificarNombre unBarbaro = unBarbaro {nombre = nombre unBarbaro ++ "*"}

{- descendientes :: Barbaro -> [Barbaro]
descendientes unBarbaro = [modificarNombre.aplicarObjetos $ unBarbaro] ++ descendientes (modificarNombre.aplicarObjetos $ unBarbaro)  -}
descendiente :: Barbaro->Barbaro
descendiente unBarbaro= utilizarObjetos.modificarNombre. Gravity Falls.sinRepetidos $ unBarbaro

utilizarObjetos ::Barbaro->Barbaro
utilizarObjetos unBarbaro= foldr ($) unBarbaro (objeto unBarbaro)


descendientes:: Barbaro->[Barbaro]
descendientes unBarbaro= iterate descendiente unBarbaro