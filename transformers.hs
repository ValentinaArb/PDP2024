import Text.Show.Functions
import Data.List

data Autobot = Robot String (Int,Int,Int) ((Int,Int,Int) -> (Int,Int)) | Vehiculo String (Int,Int)

{- data Robot = UnRobot{
    nombreRobot :: String,
    fuezaVelocidadResistencia :: (Int,Int,Int),
    valoresTransformarseVehiculo :: (Int,Int,Int) -> (Int,Int)
} deriving Show

data Vehiculo = UnVehiculo{
    nombreVehiculo :: String,
    velocidadResistencia :: (Int,Int)
} deriving Show -}

optimus :: Autobot
optimus = Robot "Optimus Prime" (20,20,10) optimusTransformacion
optimusTransformacion (_,v,r) = (v * 5, r * 2)

jazz :: Autobot
jazz = Robot "Jazz" (8,35,3) jazzTransformacion
jazzTransformacion (_,v,r) = (v * 6, r * 3)

wheeljack :: Autobot
wheeljack = Robot "Wheeljack" (11,30,4) wheeljackTransformacion
wheeljackTransformacion (_,v,r) = (v * 4, r * 3)

bumblebee :: Autobot
bumblebee = Robot "Bumblebee" (10,33,5) bumblebeeTransformacion
bumblebeeTransformacion (_,v,r) = (v * 4, r * 2)

autobots :: [Autobot]
autobots = [ optimus, jazz, wheeljack, bumblebee ]

--1
maximoSegun :: Ord a => (t -> t -> a) -> t -> t -> t
maximoSegun funcion valor1 valor2
    |funcion valor1 valor2 >= funcion valor2 valor1 = valor1
    |otherwise = valor2

--2
nombreAutobot :: Autobot -> String
nombreAutobot (Robot nombre _ _) = nombre
nombreAutobot (Vehiculo nombre _) = nombre

fuerzaAutobot :: Autobot -> Int
fuerzaAutobot (Robot _ (fuerza, _, _) _) = fuerza
fuerzaAutobot (Vehiculo _ _) = 0

velocidadAutobot :: Autobot -> Int
velocidadAutobot (Robot _ (_, velocidad, _) _) = velocidad
velocidadAutobot (Vehiculo _ (velocidad, _)) = velocidad

resistenciaAutobot :: Autobot -> Int
resistenciaAutobot (Robot _ (_, _, resistencia) _) = resistencia
resistenciaAutobot (Vehiculo _ (_, resistencia)) = resistencia

transformacionRobot :: Autobot -> Maybe ((Int, Int, Int) -> (Int, Int))
transformacionRobot (Robot _ _ transformacion) = Just transformacion

{- Crear la función transformar/1 que permita cambiar un Autobot de un Robot a un Vehículo, teniendo en cuenta que la función de conversión se le aplica a los atributos del Robot. -}

--3