{- import Text.Show.Functions
import Data.List

type Criterio = Participante -> Bool
type Calculo = Participante -> Float 

data Participante = UnParticipante{
    nombre :: String,
    edad :: Float,
    nivelAtractivo :: Float,
    nivelPersonalidad :: Float,
    nivelInteligencia :: Float,
    criterioDeVoto :: [Criterio]
} deriving (Show)

{- data Prueba = UnaPrueba{
    criterioDeSuperacion :: [Criterio],
    indiceDeExito :: Calculo
} deriving (Show)
 -}
menosInteligente :: Criterio
menosInteligente _ = True

calculoIndiceDeExito :: String -> Calculo
calculoIndiceDeExito prueba participante
    |prueba == "tiktok" = nivelPersonalidad participante + 2* nivelAtractivo participante
    |prueba == "boton" = nivelPersonalidad participante + 2* nivelAtractivo participante
    |prueba == "cuentas" = 100
    |otherwise = 0

{- requerimiento :: Criterio -}
requerimiento criterio condicion n participante = condicion (criterio participante) n

{- baileDeTiktok :: Prueba -}
baileDeTiktok = ([requerimiento nivelPersonalidad (==) 20], (calculoIndiceDeExito "tiktok"))

{- botonRojo :: Prueba -}
botonRojo = ([requerimiento nivelPersonalidad (==) 10, requerimiento nivelInteligencia (==) 20], (calculoIndiceDeExito "boton"))

cuentasRapidas :: Prueba
cuentasRapidas = UnaPrueba [requerimiento nivelInteligencia (==) 40] (calculoIndiceDeExito "cuentas")

superaLaPrueba :: Prueba -> Participante -> Bool
superaLaPrueba prueba participante = all (\x -> x participante == True) (criterioDeSuperacion prueba)

superanPruebas :: [Participante] -> Prueba -> [Participante]
superanPruebas participantes prueba = filter (superaLaPrueba prueba) participantes

promedioIndice :: [Participante] -> Prueba -> Float
promedioIndice participantes prueba = sum (map (indiceDeExito prueba) participantes)/2

{- esFavorito :: Participante -> [Prueba] -> Bool -}
esFavorito participante pruebas = map (\x-> indiceDeExito (x participante)) pruebas

javierTulei = UnParticipante "javierTulei" 52 30 70 35 [menosInteligente]
 -}

import Text.Show.Functions
import Data.List

type Criterio = [Participante] -> Participante

data Participante = UnParticipante{
    nombre :: String,
    edad :: Float,
    nivelAtractivo :: Float,
    nivelPersonalidad :: Float,
    nivelInteligencia :: Float,
    criterioDeVoto :: Criterio
}deriving (Show)

type Prueba = Participante -> (Bool, Float)

requiere :: Float-> Float -> Bool
requiere n nivel = (==) n nivel

baileDeTiktok :: Prueba
baileDeTiktok participante = (requiere 20 (nivelPersonalidad participante), nivelPersonalidad participante + 2* nivelAtractivo participante)
botonRojo :: Prueba
botonRojo participante = (requiere 10 (nivelPersonalidad participante) && requiere 20 (nivelInteligencia participante), 100)
cuentasRapidas :: Prueba
cuentasRapidas participante = (requiere 40 (nivelInteligencia participante), nivelInteligencia participante + nivelPersonalidad participante - nivelAtractivo participante)

superaPrueba :: Prueba -> Participante -> Bool
superaPrueba prueba participante = fst (prueba participante) 

superanPrueba :: Prueba -> [Participante] -> [Participante]
superanPrueba prueba = filter (\x -> True == superaPrueba prueba x)

soloIndiceDeExitoParticipantes :: Prueba -> [Participante] -> [Float]
soloIndiceDeExitoParticipantes prueba = map (\x-> snd(prueba x))

promedioIndiceExito :: Prueba -> [Participante] -> Float
promedioIndiceExito prueba = (/2).sum.soloIndiceDeExitoParticipantes prueba

soloIndiceDeExitoParticipante :: [Prueba] -> Participante -> [Float]
soloIndiceDeExitoParticipante pruebas participante = map (\x-> snd(x participante)) pruebas

esFavorito :: [Prueba] -> Participante -> Bool
esFavorito pruebas participante = all (>50) (soloIndiceDeExitoParticipante pruebas participante)

menosInteligente :: Criterio
menosInteligente = minimumBy (\p1 p2 -> compare (nivelInteligencia p1) (nivelInteligencia p2))
masAtractivo :: Criterio
masAtractivo = maximumBy (\p1 p2 -> compare (nivelAtractivo p1) (nivelAtractivo p2))
masViejo :: Criterio
masViejo = maximumBy (\p1 p2 -> compare (edad p1) (edad p2))

javierTulei :: Participante
javierTulei = UnParticipante "Javier Tulei" 52 30 70 35 menosInteligente
minimoKirchner :: Participante
minimoKirchner = UnParticipante "Mínimo Kirchner" 46 0 40 50 masAtractivo
horacioBerreta :: Participante
horacioBerreta = UnParticipante "Horacio Berreta" 57 10 60 50 masAtractivo 
myriamBregwoman :: Participante
myriamBregwoman = UnParticipante "Myriam Bregwoman" 51 40 40 60 masViejo

participantes :: [Participante]
participantes = [javierTulei,minimoKirchner,horacioBerreta,myriamBregwoman]

enPlaca :: [Participante]
enPlaca = map (\x -> x participantes) (map criterioDeVoto participantes)

{- estaEnPlaca :: Participante -> Bool
estaEnPlaca participante = elem participante enPlaca 

zafo = filter estaEnPlaca participantes -}