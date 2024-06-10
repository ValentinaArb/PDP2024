import Text.Show.Functions
import Data.List

data Perrito = UnPerrito{
    raza :: String,
    juguetesFavoritos :: [String],
    tiempoEstadia :: Float, 
    energia :: Float
} deriving (Show)

type Ejercicio = Perrito -> Perrito
type Actividad = (Ejercicio,Float)

data Guarderia = UnaGuarderia{
    nombreGuarderia :: String,
    rutina :: [Actividad]
}

jugar :: Ejercicio
jugar perrito = perrito {energia = max (energia perrito - 10) 0}
ladrar :: Float -> Ejercicio
ladrar cantidadLadridos perrito = perrito {energia = energia perrito + (cantidadLadridos/2)}
regalar :: String -> Ejercicio
regalar juguete perrito = perrito {juguetesFavoritos = juguetesFavoritos perrito ++ [juguete]}

esRazaExtravagante :: Perrito -> Bool
esRazaExtravagante perrito = raza perrito == "dalmata" || raza perrito == "pomerania"

diaDeSpa :: Ejercicio
diaDeSpa perrito
    |tiempoEstadia perrito > 50 || esRazaExtravagante perrito = regalar "peine de goma" perrito{energia = 100}
    |otherwise = perrito

perderPrimerJuguete :: [String] -> [String]
perderPrimerJuguete (x:xs) = xs

diaDeCampo :: Ejercicio
diaDeCampo perrito = perrito {juguetesFavoritos = perderPrimerJuguete (juguetesFavoritos perrito)}

zara :: Perrito
zara = UnPerrito "Dalmata" ["pelota", "mantita"] 900 80
ema :: Perrito
ema = UnPerrito "Golden" ["kong", "pelota","mantita"] 900 80
{- pi :: Perrito
pi = UnPerrito "Labrador" (map (\x->["soguitas"] ++ x) ["1".."10"]) 314 159 -}

guarderiaPdePerritos = UnaGuarderia "guarderiaPdePerritos" [(jugar,30),(ladrar 18,20),(regalar "pelota",0),(diaDeSpa,120),(diaDeCampo,720)] 

puedeEstar :: Guarderia -> Perrito -> Bool
puedeEstar guarderia perrito = sum (map snd (rutina guarderia)) < tiempoEstadia perrito

cantidadDeJuguetes :: Perrito -> Int
cantidadDeJuguetes = length.juguetesFavoritos

esPerroResponsable :: Perrito -> Bool
esPerroResponsable = (>3).cantidadDeJuguetes.diaDeCampo 

realizaRutinaDeGuarderia :: Guarderia -> Perrito -> Perrito
realizaRutinaDeGuarderia guarderia perrito
    |puedeEstar guarderia perrito = foldl (flip ($)) perrito (map fst (rutina guarderia))
    |otherwise = perrito

quedaCansado :: Guarderia -> Perrito -> Bool
quedaCansado guarderia = (<5).energia.realizaRutinaDeGuarderia guarderia

quedanCansados :: Guarderia -> [Perrito] -> [Perrito]
quedanCansados guarderia = filter (quedaCansado guarderia)
