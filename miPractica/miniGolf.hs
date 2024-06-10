import Text.Show.Functions
import Data.List

-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

putter jugador = UnTiro{
  velocidad = 10,
  precision = (*2).precisionJugador $ jugador,
  altura = 0
}

madera jugador = UnTiro{
  velocidad = 100,
  altura = 5,
  precision = (`div` 2).precisionJugador $ jugador
}

hierros n jugador = UnTiro{
  velocidad= (*n).fuerzaJugador $ jugador,
  precision = (`div` n).precisionJugador $ jugador,
  altura = max (n-3) 0
}
type Palo = [String]
palos :: [Palo]
hierro = foldl (++) "" [1..10]
palos = [putter, madera] + hierro