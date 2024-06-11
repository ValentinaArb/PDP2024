module Lib where

import Text.Show.Functions

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
putter habilidad = UnTiro {
  velocidad = 10,
  precision = precisionJugador habilidad * 2,
  altura = 0
  }
madera :: Palo
madera habilidad = UnTiro {
  velocidad = 100,
  precision = precisionJugador habilidad `div` 2,
  altura = 5
  }

hierro :: Int -> Palo
hierro n habilidad = UnTiro {
  velocidad = fuerzaJugador habilidad * n,
  precision = precisionJugador habilidad `div` n,
  altura = (n - 3) `max` 0
}

palos :: [Palo]
palos = [putter , madera] ++ map hierro [1..10]

golpe :: Jugador -> Palo -> Tiro
golpe jugador palo = palo (habilidad jugador)

golpe' :: Palo -> Jugador -> Tiro
golpe' palo = palo . habilidad

golpe'' :: Jugador -> Palo -> Tiro
golpe'' jugador palo = (palo.habilidad) jugador

tiroDetenido = UnTiro 0 0 0

intentarSuperarObstaculo :: Obstaculo -> Tiro -> Tiro
intentarSuperarObstaculo obstaculo tiroOriginal
  | puedeSuperar obstaculo tiroOriginal = efectoLuegoDeSuperar obstaculo tiroOriginal
  | otherwise = tiroDetenido

tunelConRampita :: Obstaculo
tunelConRampita = UnObstaculo superaTunelConRampita efectoTunelConRampita

data Obstaculo = UnObstaculo {
  puedeSuperar :: Tiro -> Bool,
  efectoLuegoDeSuperar :: Tiro -> Tiro
}

superaTunelConRampita :: Tiro -> Bool
superaTunelConRampita tiro = precision tiro > 90 && vaAlRasDelSuelo tiro

efectoTunelConRampita :: Tiro -> Tiro
efectoTunelConRampita tiro = UnTiro {velocidad = velocidad tiro * 2, precision = 100, altura = 0}

vaAlRasDelSuelo = (==0).altura

laguna :: Int -> Obstaculo
laguna largo = UnObstaculo superaLaguna (efectoLaguna largo)

superaLaguna :: Tiro -> Bool
superaLaguna tiro = velocidad tiro > 80 && (between 1 5.altura) tiro
efectoLaguna :: Int -> Tiro -> Tiro
efectoLaguna largo tiroOriginal = tiroOriginal {altura = altura tiroOriginal `div` largo}

hoyo :: Obstaculo
hoyo = UnObstaculo superaHoyo efectoHoyo
superaHoyo tiro = (between 5 20.velocidad) tiro && vaAlRasDelSuelo tiro
efectoHoyo _ = tiroDetenido

{-
Definir palosUtiles que dada una persona y un obstáculo, permita determinar qué palos le sirven para superarlo.
-}

-- golpe :: Jugador -> Palo -> Tiro
{- palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles jugador obstaculo = filter (leSirveParaSuperar jugador obstaculo) palos

leSirveParaSuperar :: Jugador -> Obstaculo -> Palo -> Bool
leSirveParaSuperar jugador obstaculo palo = puedeSuperar obstaculo (golpe jugador palo) -}




-- golpe :: Jugador -> Palo -> Tiro
palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles jugador obstaculo = filter (leSirveParaSuperar jugador obstaculo) palos

leSirveParaSuperar :: Jugador -> Obstaculo -> Palo -> Bool
leSirveParaSuperar jugador obstaculo palo = puedeSuperar obstaculo (golpe jugador palo)