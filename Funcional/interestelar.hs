{- import Text.Show.Functions
import Data.List

type Posicion = (Float, Float, Float)
coordX (x,_,_) = x
coordY (_,y,_) = y
coordZ (_,_,z) = z

data Planeta = UnPlaneta String Posicion (Int -> Int)

posicion (UnPlaneta _ p _) = p
tiempo (UnPlaneta _ _ t) = t

data Astronauta = UnAstronauta String Int Planeta

nombre (UnAstronauta n _ _) = n
edad (UnAstronauta _ e _) = e
planeta (UnAstronauta _ _ p) = p

--1a
elevadoAlCuadrado funcion planeta1 planeta2 = (funcion (posicion planeta1) - funcion (posicion planeta2))^ 2

distancia :: Planeta -> Planeta -> Float
distancia planeta1 planeta2 = sqrt(elevadoAlCuadrado coordX planeta1 planeta2 + elevadoAlCuadrado coordY planeta1 planeta2 + elevadoAlCuadrado coordZ planeta1 planeta2)

--1b 
tiempoTardanza :: Float -> Planeta -> Planeta -> Float
tiempoTardanza velocidad planeta1 planeta2 = distancia planeta1 planeta2 / velocidad

-- 2
pasarTiempo :: Int -> Astronauta -> Int
pasarTiempo anios astronauta = edad astronauta + anios

--3
type Nave = Planeta -> Planeta -> Float
naveVieja velocidad planeta1 planeta2
 -}