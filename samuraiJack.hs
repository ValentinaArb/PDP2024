import Text.Show.Functions
import Data.List

data Elemento = UnElemento {
    tipo :: String,
    ataque :: Personaje-> Personaje,
    defensa :: Personaje-> Personaje 
} deriving Show
data Personaje = UnPersonaje { 
    nombre :: String,
    salud :: Float,
    elementos :: [Elemento],
    anioPresente :: Int 
} deriving Show

type Transformacion = Personaje -> Personaje
modificarSalud :: Float -> Transformacion
modificarSalud cantidad personaje = personaje{salud= max 0 (salud personaje + cantidad)}
--1 a
mandarAlAnio :: Int -> Transformacion
mandarAlAnio anio personaje = personaje{anioPresente = anio} 
--1 b
meditar :: Transformacion
meditar personaje = modificarSalud (salud personaje / 2) personaje
--1 c
causarDanio :: Float -> Transformacion
causarDanio cantidadSalud = modificarSalud (-cantidadSalud)

--2 a
esMalvado :: Personaje -> Bool
esMalvado personaje = elem "Maldad" (map tipo (elementos personaje))
--2 b
danioQueProduce :: Personaje -> Elemento -> Float
danioQueProduce personaje elemento = salud personaje - salud (ataque elemento personaje) 
--2 c
afectarSalud :: Personaje -> Personaje -> [Personaje]
afectarSalud personaje enemigo= map (\elemento-> ataque elemento personaje) (elementos enemigo)

loMata :: Personaje -> Personaje -> Bool
loMata personaje enemigo = any (\personaje -> salud personaje == 0) (afectarSalud personaje enemigo)

enemigosMortales :: Personaje -> [Personaje] -> [Personaje]
enemigosMortales personaje = filter (loMata personaje)

--3a
noHacerNada = id

defensaConcentracion :: Int -> Personaje -> Personaje
defensaConcentracion nivelConcentracion personaje
    |nivelConcentracion - 1 /= 0 = meditar personaje
    |otherwise = personaje 

concentracion :: Int -> Elemento
concentracion nivelConcentracion = UnElemento "Magia" noHacerNada (defensaConcentracion nivelConcentracion)

--3b 
ataqueEsbirros :: Personaje -> Personaje
ataqueEsbirros = modificarSalud (-1) 

esbirrosMalvados :: Int -> [Elemento]
esbirrosMalvados cantidad = take cantidad (cycle [UnElemento "Maldad" ataqueEsbirros id])

--3c
katanaMagica = UnElemento "Magica"  id
jack = UnPersonaje "Jack" 300 [concentracion 3, katanaMagica] 200