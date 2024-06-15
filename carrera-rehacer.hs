import Text.Show.Functions
import Data.List

type Color = String

data Auto = UnAuto{
    color :: Color,
    velocidad :: Int,
    distancia :: Int
} deriving Show

felipemovil :: Auto
felipemovil = UnAuto "negro" 300 40 

ositamovil :: Auto
ositamovil = UnAuto "rosa" 1 400

emimovil :: Auto
emimovil = UnAuto "amarillo" 500 500 

type Carrera = [Auto]
carrera :: Carrera
carrera = [emimovil, felipemovil,ositamovil]
 
distanciaEntreDosAutos :: Auto -> Auto -> Int
distanciaEntreDosAutos auto1 auto2 = abs (distancia auto1 - distancia auto2)

sonAutosDiferentes :: Auto -> Auto -> Bool
sonAutosDiferentes auto1 auto2 = color auto1 /= color auto2

estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = sonAutosDiferentes auto1 auto2 && distanciaEntreDosAutos auto1 auto2 <10

autosContrarios :: Carrera -> Auto -> [Auto]
autosContrarios carrera auto = filter (\autoContrario -> color autoContrario  /= color auto) carrera

noTieneAutosCerca :: [Auto] -> Auto -> Bool
noTieneAutosCerca autosContrarios auto = all (==False) (map (estaCerca auto) autosContrarios)

vaGanando :: [Auto] -> Auto -> Bool
vaGanando autosContrarios auto = maximum (map distancia autosContrarios) < distancia auto

vaTranquilo :: Carrera -> Auto -> Bool
vaTranquilo carrera auto = noTieneAutosCerca (autosContrarios carrera auto) auto && vaGanando (autosContrarios carrera auto) auto 

distanciasOrdenadas :: Carrera -> [Int]
distanciasOrdenadas carrera = sort (map distancia carrera)

recorrieronMasDistancia :: Auto -> Carrera -> [Int]
recorrieronMasDistancia auto carrera = filter (> distancia auto) (distanciasOrdenadas carrera)

puestoEnCarrera :: Auto -> Carrera -> Int
puestoEnCarrera auto = (+1).length.recorrieronMasDistancia auto

corre :: Int -> Auto -> Auto
corre tiempo auto = auto{distancia= distancia auto + tiempo * velocidad auto}

modificador :: Int -> Int
modificador velocidadActual = velocidadActual * 10 {- corregir -}

alterarVelocidad :: Auto -> Auto
alterarVelocidad auto = auto {velocidad = modificador.velocidad $ auto}

bajarVelocidad ::  Int -> Auto -> Auto
bajarVelocidad cantidad auto = auto {velocidad = max 0 (velocidad auto - cantidad)} 

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
  = (map efecto . filter criterio) lista ++ filter (not.criterio) lista

type PowerUp = Auto -> Carrera -> Carrera

terremoto :: PowerUp
terremoto auto = afectarALosQueCumplen (estaCerca auto) (bajarVelocidad 50) 

miguelitos :: Int -> PowerUp
miguelitos cantidad auto = afectarALosQueCumplen (vaGanando carrera) (bajarVelocidad cantidad) 

modificarDistancia tiempo auto = auto {distancia = distancia auto + tiempo * velocidad auto * 2}

jetPack :: Int -> PowerUp
jetPack tiempo auto = afectarALosQueCumplen (\autoVer -> color autoVer == color auto) (modificarDistancia tiempo) 

type Evento = Carrera -> Carrera
type TablaPosiciones = [(Int,Color)]

correnTodos :: Int -> Evento
correnTodos tiempo = map (corre tiempo)

usaPowerUp :: Color -> PowerUp -> Evento
usaPowerUp colorAuto powerUp = powerUp (head (filter (\auto -> color auto == colorAuto) carrera)) 

aplicarEventosCarrera :: Carrera -> [Evento] -> Carrera
aplicarEventosCarrera = foldl (flip($))

simularCarrera :: Carrera -> [Evento] -> [(Int, Color)]
simularCarrera carrera eventos = map (\auto -> (puestoEnCarrera auto (aplicarEventosCarrera carrera eventos), color auto)) (aplicarEventosCarrera carrera eventos)

rojo,blanco,azul,negro :: Auto
rojo = UnAuto "rojo" 120 0
blanco = UnAuto "blanco" 120 0
azul = UnAuto "azul" 120 0
negro = UnAuto "negro" 120 0

carreraPrueba :: [Auto]
carreraPrueba = [UnAuto "rojo" 120 0, UnAuto "blanco" 120 0, UnAuto "azul" 120 0, UnAuto "negro" 120 0]
eventosPrueba :: [Evento]
eventosPrueba = [correnTodos 30, jetPack 3 azul, terremoto blanco,correnTodos 40, miguelitos 20 blanco, jetPack 6 negro, correnTodos 10]