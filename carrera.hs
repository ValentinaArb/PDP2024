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

carrera = UnaCarrera [felipemovil,ositamovil,emimovil]
 
distanciaEntreDosAutos :: Auto -> Auto -> Int
distanciaEntreDosAutos auto1 auto2 = abs (distancia auto1 - distancia auto2)

sonAutosDiferentes :: Auto -> Auto -> Bool
sonAutosDiferentes auto1 auto2 = color auto1 /= color auto2

estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = sonAutosDiferentes auto1 auto2 && distanciaEntreDosAutos auto1 auto2 <10

autosContrarios :: Carrera -> Auto -> [Auto]
autosContrarios carrera auto = filter (\autoContrario -> color autoContrario  /= color auto) (autos carrera) 
noTieneAutosCerca :: [Auto] -> Auto -> Bool
noTieneAutosCerca autosContrarios auto = all (==False) (map (estaCerca auto) autosContrarios)  
vaGanando :: [Auto] -> Auto -> Bool
vaGanando autosContrarios auto = maximum (map distancia autosContrarios) < distancia auto

vaTranquilo :: Carrera -> Auto -> Bool
vaTranquilo carrera auto = noTieneAutosCerca (autosContrarios carrera auto) auto && vaGanando (autosContrarios carrera auto) auto 

{- Conocer en qué puesto está un auto en una carrera, que es 1 + la cantidad de autos de la carrera que le van ganando. -}
