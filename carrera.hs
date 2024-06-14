import Text.Show.Functions
import Data.List

data Auto = UnAuto{
    color :: String,
    velocidad :: Int,
    distancia :: Int
} deriving Show

data Carrera = UnaCarrera{
    autos :: [Auto]
} deriving Show

felipemovil :: Auto
felipemovil = UnAuto "negro" 300 40 

ositamovil :: Auto
ositamovil = UnAuto "rosa" 1 400

emimovil :: Auto
emimovil = UnAuto "amarillo" 500 500 

carrera = UnaCarrera [emimovil, felipemovil,ositamovil]
 
distanciaEntreDosAutos :: Auto -> Auto -> Int
distanciaEntreDosAutos auto1 auto2 = abs (distancia auto1 - distancia auto2)

sonAutosDiferentes :: Auto -> Auto -> Bool
sonAutosDiferentes auto1 auto2 = color auto1 /= color auto2

estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = sonAutosDiferentes auto1 auto2 && distanciaEntreDosAutos auto1 auto2 <10

autosContrarios :: Carrera -> Auto -> [Auto]
autosContrarios carrera auto = filter (\autoContrario -> color autoContrario  /= color auto) (autos carrera) 

noTieneAutosCerca :: [Auto] -> Auto -> Bool
noTieneAutosCerca autosContrarios auto = all (==False) (map (estaCerca auto==True) autosContrarios)  

vaGanando :: [Auto] -> Auto -> Bool
vaGanando autosContrarios auto = maximum (map distancia autosContrarios) < distancia auto

vaTranquilo :: Carrera -> Auto -> Bool
vaTranquilo carrera auto = noTieneAutosCerca (autosContrarios carrera auto) auto && vaGanando (autosContrarios carrera auto) auto 

velocidadesOrdenadas :: Carrera -> [Int]
velocidadesOrdenadas carrera = sort (map distancia (autos carrera))
velocidadesMayoresAlAuto :: Auto -> Carrera -> [Int]
velocidadesMayoresAlAuto auto carrera = filter (> distancia auto) (velocidadesOrdenadas carrera)

puestoEnCarrera :: Carrera -> Auto -> Int
puestoEnCarrera carrera auto = (+1).length.velocidadesMayoresAlAuto auto $ carrera

corre :: Auto -> Int -> Auto
corre auto tiempo = auto{distancia= distancia auto + tiempo * velocidad auto}

modificador :: Int -> Int
modificador velocidadActual = velocidadActual * 10 {- corregir -}

alterarVelocidad :: Auto -> Auto
alterarVelocidad auto = auto {velocidad = modificador.velocidad $ auto}

bajarVelocidad :: Auto -> Int -> Auto
bajarVelocidad auto cantidad = auto {velocidad = max 0 (velocidad auto - cantidad)} 

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
  = (map efecto . filter criterio) lista ++ filter (not.criterio) lista


terremoto carrera auto = 