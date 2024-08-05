import Text.Show.Functions
import Data.List

data Juguete = UnJuguete{
    nombre :: String,
    nombreDuenio :: String,
    nivelFacha :: Float,
    accesorios :: [Accesorio],
    estaVivo :: Bool
} deriving Show

data Accesorio = UnAccesorio {
    efecto :: Efecto,
    eficacia :: Float
} deriving Show

type Efecto = Float -> Juguete -> Juguete

--FUNCIONES UTILES
aumentarFacha :: Float -> Juguete -> Juguete
aumentarFacha cantidad juguete = juguete {nivelFacha = nivelFacha juguete + cantidad} 
disminuirFacha :: Float -> Juguete -> Juguete
disminuirFacha cantidad = aumentarFacha (-cantidad) {- aplicacion parcial de juguete -}
modificarNombre :: String -> Juguete -> Juguete
modificarNombre nombre juguete = juguete {nombre = nombre} 
cantidadCaracteres :: String -> Float
cantidadCaracteres = fromIntegral . length {- aplicacion parcial de nombre -}

--EFECTOS
lucirAmenazante :: Efecto
lucirAmenazante eficacia = aumentarFacha (10 + eficacia) {- aplicacion parcial de juguete -}

vieneAndy :: Efecto
vieneAndy _ juguete = juguete {estaVivo = False}

masSteel :: Efecto
masSteel eficacia juguete = modificarNombre "Max Steel" . aumentarFacha ((*) eficacia . cantidadCaracteres . nombre $ juguete) $ juguete {- composicion -}

quemadura :: Float -> Efecto
quemadura gradoQuemadura eficacia = disminuirFacha (gradoQuemadura * (eficacia +2)) {- aplicacion parcial de juguete -}

--ACCESORIOS
serpienteEnBota :: Accesorio
serpienteEnBota = UnAccesorio lucirAmenazante 2

radio :: Accesorio
radio = UnAccesorio vieneAndy 3

revolver :: Accesorio
revolver = UnAccesorio masSteel 5

escopeta :: Accesorio
escopeta = UnAccesorio masSteel 20

lanzaLlamas :: Accesorio
lanzaLlamas = UnAccesorio (quemadura 3) 8.5

pasaMontanias :: Accesorio
pasaMontanias = UnAccesorio lucirAmenazante 7

--JUGUETES
woody :: Juguete
woody = UnJuguete "Woody" "Andy" 100 [serpienteEnBota,revolver] True

soldado :: Juguete
soldado = UnJuguete "soldado" "Danay" 5 [lanzaLlamas,radio,pasaMontanias] True

barbie :: Juguete
barbie = UnJuguete "barbie" "Dany" 95.5 [serpienteEnBota,revolver,pasaMontanias] False

--4
esImpactante :: Juguete -> Bool
esImpactante juguete = any ((>10) . eficacia) (accesorios juguete)

--5
mismasLetras duenio nombre = all (\letra -> elem letra nombre) duenio
mismaCantidadLetras nombreDuenio = cantidadCaracteres nombreDuenio == cantidadCaracteres "Andy"

esDislexico :: Juguete -> Bool
esDislexico juguete = not (mismaCantidadLetras (nombreDuenio juguete) && mismasLetras (nombreDuenio juguete) "Andy")

--6
cantidadImpactantes :: [Juguete] -> Int
cantidadImpactantes = length . filter esImpactante {- aplicacion parcial de juguetes y composicion -}

cantidadLetrasMayor6 :: [Juguete] -> Int
cantidadLetrasMayor6 = length . filter ((>6) . cantidadCaracteres) . map nombre {- aplicacion parcial de juguetes y composicion -}

cantidadDislexicos :: [Juguete] -> Int
cantidadDislexicos = length . filter esDislexico {- aplicacion parcial de juguetes y composicion -}

--7
aplicar :: Accesorio -> Juguete -> Juguete
aplicar accesorio = efecto accesorio (eficacia accesorio)  
aplicarEfectoAccesorios :: Juguete -> Juguete
aplicarEfectoAccesorios juguete = foldl (flip aplicar) juguete (accesorios juguete)

calculoAmor :: Juguete -> Float
calculoAmor juguete = nivelFacha juguete + cantidadCaracteres (nombre juguete) * 5 - fromIntegral (length (accesorios juguete)) *7

nivelDeAmor :: Juguete -> Float
nivelDeAmor juguete
    |estaVivo juguete = (* 2) . calculoAmor . aplicarEfectoAccesorios $ juguete
    |otherwise = calculoAmor . aplicarEfectoAccesorios $ juguete

nivelDeAmorCajon :: [Juguete] -> Float
nivelDeAmorCajon = sum . map nivelDeAmor {- aplicacion parcial de juguetes -}