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

type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = UnTiro 10 (2* precisionJugador habilidad) 0
madera :: Palo
madera habilidad = UnTiro 100 (precisionJugador habilidad `div` 2) 5
hierros :: Int -> Palo
hierros n habilidad = UnTiro (n* fuerzaJugador habilidad) (precisionJugador habilidad `div` n) (max (n-3) 0)

palos :: [Palo]
palos = [putter,madera] ++ map hierros [1..10]

golpe :: Palo -> Jugador -> Tiro
golpe palo = palo.habilidad

data Obstaculo = UnObstaculo{
  puedeSuperar :: TiroExitoso,
  efectoObstaculo :: ModificarTiro
}deriving (Show)

type ModificarTiro = Tiro -> Tiro
type TiroExitoso = Tiro -> Bool

tiroDetenido :: Tiro
tiroDetenido = UnTiro 0 0 0 

condicionSuperarTunel :: TiroExitoso
condicionSuperarTunel tiro = precision tiro > 90 && altura tiro == 0
modificarTunel :: ModificarTiro
modificarTunel tiro = tiro {velocidad = velocidad tiro *2, precision = 100, altura = 0}

condicionSuperarLaguna :: TiroExitoso
condicionSuperarLaguna tiro = velocidad tiro > 80 && between 1 5 (altura tiro)
modificarLaguna :: Int-> ModificarTiro
modificarLaguna largo tiro = tiro {altura = altura tiro `div` largo}

condicionSuperarHoyo :: TiroExitoso
condicionSuperarHoyo tiro = between 5 20 (velocidad tiro) && precision tiro > 95 && altura tiro == 0
modificarHoyo :: ModificarTiro
modificarHoyo _ = tiroDetenido

tunel :: Obstaculo
tunel = UnObstaculo condicionSuperarTunel modificarTunel
laguna :: Int -> Obstaculo
laguna largo = UnObstaculo condicionSuperarLaguna (modificarLaguna largo)
hoyo :: Obstaculo
hoyo = UnObstaculo condicionSuperarHoyo modificarHoyo

noPuedeSuperarlo :: Tiro
noPuedeSuperarlo = tiroDetenido  

intentaSuperarObstaculo :: Obstaculo -> Jugador -> Palo -> Tiro
intentaSuperarObstaculo obstaculo jugador palo
  |puedeSuperar obstaculo (golpe palo jugador) = efectoObstaculo obstaculo $ (golpe palo jugador)
  |otherwise = noPuedeSuperarlo

palosUtiles :: Obstaculo -> Jugador -> [Palo]
palosUtiles obstaculo persona = filter (leSirve obstaculo persona) palos

leSirve :: Obstaculo -> Jugador -> Palo ->  Bool 
leSirve obstaculo persona palo = puedeSuperar obstaculo (golpe palo persona)

cantidadObstaculosSuperados :: [Obstaculo] -> Tiro -> Int
cantidadObstaculosSuperados obstaculos tiro = length (takeWhile (\obstaculo -> puedeSuperar obstaculo tiro) obstaculos)

paloMasUtil :: [Obstaculo] -> Jugador -> Palo
paloMasUtil obstaculos persona = maximoSegun (\palo -> cantidadObstaculosSuperados obstaculos (golpe palo persona)) palos

type PuntosJugadores = (Jugador,Puntos)

ganador :: [PuntosJugadores] -> PuntosJugadores
ganador jugadoresPuntos = maximoSegun snd jugadoresPuntos

perdedores :: [PuntosJugadores] -> [Jugador]
perdedores jugadoresPuntos = map fst (filter (ganador jugadoresPuntos /=) jugadoresPuntos)

padresQuePierden :: [PuntosJugadores] -> [String]
padresQuePierden jugadoresPuntos = map padre (perdedores jugadoresPuntos)