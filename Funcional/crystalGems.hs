import Text.Show.Functions
import Data.List

data Aspecto = UnAspecto {
  tipoDeAspecto :: String,
  grado :: Float
} deriving (Show, Eq)
{- type Situacion = [Aspecto] -}

data Situacion = UnaSituacion{
    aspectos :: [Aspecto],
    incertidumbre :: Int,
    tension :: Int,
    peligro :: Int
}

situacion1 = [UnAspecto "alto" 300000,UnAspecto "feo" 300000, UnAspecto "flaco" 300000]
situacion2 = [UnAspecto "flaco" 1010, UnAspecto "alto" 1040,UnAspecto "feo" 10101]

mejorAspecto :: Aspecto -> Aspecto -> Bool
mejorAspecto mejor peor = grado mejor < grado peor
mismoAspecto :: Aspecto -> Aspecto -> Bool
mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2
buscarAspecto :: Aspecto -> [Aspecto] -> Aspecto
buscarAspecto aspectoBuscado = head.filter (mismoAspecto aspectoBuscado)
buscarAspectoDeTipo :: String -> [Aspecto] -> Aspecto
buscarAspectoDeTipo tipo = buscarAspecto (UnAspecto tipo 0)
reemplazarAspecto :: Aspecto -> [Aspecto] -> [Aspecto]
reemplazarAspecto aspectoBuscado situacion =
    aspectoBuscado : filter (not.mismoAspecto aspectoBuscado) situacion

--1 a 
modificarAspecto :: (Float -> Float) -> Aspecto -> Aspecto
modificarAspecto funcion aspecto = aspecto{grado = funcion (grado aspecto)}
--1 b
situacionMejorIndividual :: [Aspecto] -> [Aspecto] -> [Bool]
situacionMejorIndividual situacion1 (x:xs) 
    |length (x:xs) > 1 =mejorAspecto x (buscarAspecto x situacion1) : situacionMejorIndividual situacion1 xs
    |otherwise = [mejorAspecto x (buscarAspecto x situacion1)]

situacionMejor :: [Aspecto] -> [Aspecto] -> Bool
situacionMejor situacion1 situacion2  = all (== True) (situacionMejorIndividual situacion1 situacion2)
--1 c
modificarSituacion :: (Float -> Float) -> Aspecto -> [Aspecto] -> Aspecto
modificarSituacion funcion aspecto = modificarAspecto funcion . buscarAspecto aspecto

--2 a
data Gema = UnaGema{
    nombre :: String,
    fuerza :: Int,
    personalidad :: Situacion -> Situacion
} 
--2 b
type Personalidad = Situacion -> Situacion
vidente :: Personalidad
vidente situacion = situacion{incertidumbre = incertidumbre situacion `div` 2, tension = tension situacion -10}
relajada :: Int -> Personalidad
relajada nivelRelajamiento situacion = situacion{tension= tension situacion -30, peligro = peligro situacion + nivelRelajamiento} 
-- 2 c
gemaVidente :: Gema
gemaVidente = UnaGema "gemaVidente" 10 vidente
gemaRelajada :: Gema
gemaRelajada = UnaGema "gemaRelajada" 5 (relajada 20)

--3 
esMasFuerte :: Gema -> Gema -> Bool
esMasFuerte gema1 gema2 = fuerza gema1 >= fuerza gema2

mejorSituacionResultante :: Personalidad -> Personalidad -> Situacion -> Bool
mejorSituacionResultante personalidad1 personalidad2 situacion = situacionMejor (aspectos (personalidad1 situacion)) (aspectos (personalidad2 situacion))

leGana :: Gema -> Gema -> Situacion -> Bool
leGana gema1 gema2 situacion = esMasFuerte gema1 gema2 && mejorSituacionResultante (personalidad gema1) (personalidad gema2) situacion

--4 a
nuevoNombre :: Gema -> Gema -> String
nuevoNombre gema1 gema2
    |nombre gema1 == nombre gema2 = nombre gema1 
    |otherwise = nombre gema1 ++ nombre gema2

--4b
bajarAspectos :: Situacion -> Situacion
bajarAspectos situacion = situacion { aspectos = map (modificarAspecto (subtract 10)) (aspectos situacion) }

nuevaPersonalidad :: Gema -> Gema -> Personalidad
nuevaPersonalidad gema1 gema2 = personalidad gema1 . personalidad gema2 . bajarAspectos

--4c
sonCompatibles :: Gema -> Gema -> Situacion -> Bool
sonCompatibles gema1 gema2 situacion = situacionMejor (aspectos(nuevaPersonalidad gema1 gema2 situacion)) (aspectos(personalidad gema1 situacion)) && situacionMejor (aspectos(nuevaPersonalidad gema1 gema2 situacion)) (aspectos(personalidad gema2 situacion))

gemaDominante :: Gema -> Gema -> Gema
gemaDominante gema1 gema2
    |fuerza gema1 > fuerza gema2 = gema1
    |otherwise = gema2

nuevaFuerza :: Situacion -> Gema -> Gema -> Int
nuevaFuerza situacion gema1 gema2 
    |sonCompatibles gema1 gema2 situacion = (fuerza gema1 + fuerza gema2)*10
    |otherwise = fuerza (gemaDominante gema1 gema2) * 7

fusion :: Situacion -> Gema -> Gema -> Gema
fusion situacion gema1 gema2 = UnaGema (nuevoNombre gema1 gema2) (nuevaFuerza situacion gema1 gema2) (nuevaPersonalidad gema1 gema2)

fusionGrupal :: [Gema] -> Situacion -> Gema
fusionGrupal (x:xs) situacion= foldl (fusion situacion) x xs