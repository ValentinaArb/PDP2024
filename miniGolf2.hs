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
putter habilidad = UnTiro 10 (precisionJugador habilidad *2) 0
madera :: Palo
madera habilidad = UnTiro 100 (precisionJugador habilidad `div` 2) 5
hierro :: Int -> Palo
hierro n habilidad = UnTiro (fuerzaJugador habilidad*n) (precisionJugador habilidad `div` n) (max 0 n-3)

palos :: [Palo]
palos = [putter,madera] ++ map hierro [1..10]

golpe :: Palo -> Jugador -> Tiro
golpe palo = palo . habilidad {- aplicacion parcial jugador -}

type Requisito = Tiro -> Bool
type Consecuencia = Tiro -> Tiro

data Obstaculo = UnObstaculo {
    nombreObstaculo :: String,
    requisito :: Requisito,
    consecuencia :: Consecuencia
} deriving Show

tiroDetenido :: Consecuencia
tiroDetenido _ = UnTiro 0 0 0

requisitoTunel :: Requisito
requisitoTunel tiro = precision tiro > 90 && altura tiro == 0 
consecuenciaTunel :: Consecuencia
consecuenciaTunel tiro = tiro{velocidad = velocidad tiro *2, precision = 100, altura = 0}
tunel :: Obstaculo
tunel = UnObstaculo "TunelConRampita" requisitoTunel consecuenciaTunel

requisitoLaguna :: Requisito
requisitoLaguna tiro = velocidad tiro > 80 && between 1 5  (altura tiro)
consecuenciaLaguna :: Int -> Consecuencia
consecuenciaLaguna largo tiro = tiro{altura = altura tiro `div` largo}   
laguna :: Int -> Obstaculo
laguna largo = UnObstaculo "Laguna" requisitoLaguna (consecuenciaLaguna largo) 

requisitoHoyo :: Requisito
requisitoHoyo tiro = between 5 20 (velocidad tiro) && altura tiro == 0 && precision tiro > 95
consecuenciaHoyo :: Consecuencia
consecuenciaHoyo = tiroDetenido
hoyo :: Obstaculo
hoyo = UnObstaculo "Hoyo" requisitoHoyo consecuenciaHoyo

intentaSuperarObstaculo :: Tiro -> Obstaculo ->  Consecuencia
intentaSuperarObstaculo tiro obstaculo  
    |requisito obstaculo tiro = consecuencia obstaculo
    |otherwise = tiroDetenido

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles persona obstaculo = filter (\palo -> requisito obstaculo (golpe palo persona)) palos

cuantoSupera :: [Obstaculo] -> Tiro -> Int
cuantoSupera [] tiro = 0
cuantoSupera (x:xs) tiro
    |requisito x tiro = 1 + cuantoSupera xs (consecuencia x tiro)
    |otherwise = 0

paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil jugador obstaculos = maximoSegun (\palo -> cuantoSupera obstaculos (golpe palo jugador)) palos

ninioQueGano :: [(Jugador,Puntos)] -> (Jugador,Puntos)
ninioQueGano = maximoSegun snd
niniosPerdedores :: [(Jugador, Puntos)] -> [(Jugador, Puntos)]
niniosPerdedores lista = filter (/=ninioQueGano lista) lista
padresPerdedores :: [(Jugador, Puntos)] -> [String]
padresPerdedores lista = map (padre . fst) (niniosPerdedores lista)