import Text.Show.Functions
import Data.List

data Juguete = UnJuguete{
    nombre :: String,
    duenio :: String,
    nivelFacha :: Float,
    accesorios :: [Accesorio],
    estaVivo :: Bool
} deriving Show

data Accesorio = UnAccesorio{
    efecto :: Efecto,
    eficacia :: Float
} deriving Show

cantidadCaracteresNombre= fromIntegral . length . nombre
cantidadAccesorios= fromIntegral . length . accesorios
{- aplicacion parcial con "juguete" -}

--1a
modificarFacha cantidad juguete = juguete {nivelFacha = nivelFacha juguete + cantidad}
modificarNombre nuevoNombre juguete = juguete{nombre = nuevoNombre}

lucirAmenazante :: Accesorio -> Juguete -> Juguete
lucirAmenazante accesorio = modificarFacha (10 + eficacia accesorio)
{- aplicacion parcial con "juguete" -}

type Efecto = Juguete -> Juguete

--1b
vieneAndy :: Efecto
vieneAndy juguete = juguete {estaVivo = False}

--1c
masSteel :: Accesorio -> Efecto
masSteel accesorio juguete =  modificarNombre "Max Steel". modificarFacha ((* eficacia accesorio) . cantidadCaracteresNombre $ juguete) $ juguete
{- Composicion usando point free -}

--1d
quemadura :: Float -> Accesorio -> Efecto
quemadura gradoQuemadura accesorio = modificarFacha (gradoQuemadura * (eficacia accesorio + 2))
{- aplicacion parcial con "juguete" -}

-- 2a
serpienteEnBota :: Accesorio
serpienteEnBota = UnAccesorio (lucirAmenazante serpienteEnBota) 2
-- 2b 
radio :: Accesorio
radio = UnAccesorio vieneAndy 3
-- 2c
revolver :: Accesorio
revolver = UnAccesorio (masSteel revolver) 5 
-- 2d
escopeta :: Accesorio
escopeta = UnAccesorio (masSteel escopeta) 20 
-- 2e
lanzaLlamas :: Accesorio
lanzaLlamas = UnAccesorio (quemadura 3 lanzaLlamas) 8.5

--3 a
woody :: Juguete
woody = UnJuguete "woody" "andy" 100 [serpienteEnBota,revolver,pasaMontanias] True
-- 3b
soldado :: Juguete
soldado = UnJuguete "soldado" "andy" 5 [lanzaLlamas,radio,pasaMontanias] True
-- 3c
barbie :: Juguete
barbie = UnJuguete "barbie" "danay" 95.5 [lanzaLlamas,escopeta,revolver,pasaMontanias] False

eficaciaDeSusAccesorios juguete = map eficacia (accesorios juguete) 

esImpactante :: Juguete -> Bool
esImpactante juguete = any (>10) (eficaciaDeSusAccesorios juguete)

esDislexico :: Juguete -> Bool
esDislexico juguete = sort (duenio juguete) /= sort "andy"
cantidades funcion = length . filter funcion
{- aplicacion parcial con "juguetes" -}

cantidadImpactantes :: [Juguete] -> Int
cantidadImpactantes = cantidades esImpactante
{- aplicacion parcial con "juguetes" -}

letrasNombreMayorA6 :: Juguete -> Bool
letrasNombreMayorA6 = (>6) . cantidadCaracteresNombre
{- aplicacion parcial con "juguetes" -}
{- composición con point free -}

cantidadLetrasNombreMayorA6 :: [Juguete] -> Int
cantidadLetrasNombreMayorA6 = cantidades letrasNombreMayorA6 
{- aplicacion parcial con "juguetes" -}

cantidadDislexicosYNoVivos :: [Juguete] -> Int
cantidadDislexicosYNoVivos = cantidades (not . estaVivo) . filter esDislexico
{- aplicacion parcial con "juguetes" -}

aplicarEfectoAccesorios :: Juguete -> Juguete
aplicarEfectoAccesorios juguete = foldl (flip($)) juguete (map efecto (accesorios juguete))

formulaAmorPorJuguete :: Juguete -> Float
formulaAmorPorJuguete juguete = nivelFacha juguete + cantidadCaracteresNombre juguete * 5 - cantidadAccesorios juguete * 7
    
amorAndyPorJuguete :: Juguete -> Float
amorAndyPorJuguete juguete 
    |estaVivo juguete = (2*) . formulaAmorPorJuguete . aplicarEfectoAccesorios  $ juguete
    |otherwise = formulaAmorPorJuguete . aplicarEfectoAccesorios  $ juguete

pasaMontanias :: Accesorio
pasaMontanias = UnAccesorio (lucirAmenazante pasaMontanias) 7

amorCajon :: [Juguete] -> Float
amorCajon = sum . map amorAndyPorJuguete
{- aplicacion parcial con "juguetes" -}
