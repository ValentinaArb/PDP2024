import Text.Show.Functions
import Data.List
import Data.Data (ConIndex)

type Condicion = Viaje -> Bool

data Chofer = UnChofer{
    nombreChofer :: String,
    kilometraje :: Int,
    viajes :: [Viaje],
    tomarViaje :: Viaje -> Bool
} deriving Show

data Viaje = UnViaje {
    fecha :: Int,
    cliente :: Cliente,
    costo :: Int
} deriving Show

data Cliente = UnCliente {
    nombreCliente :: String,
    vivienda :: String
} deriving Show

cualquiera :: Condicion
cualquiera _ = True

{- uso composicion y aplicacion parcial con "viaje" en los 3 siguientes: -}
masDe200 :: Condicion
masDe200 = (> 200) . costo
masDeNLetras :: Int -> Condicion
masDeNLetras n = (>n) . length . nombreCliente . cliente
noVivenEnZona :: String -> Condicion
noVivenEnZona zona = (/=zona) . vivienda . cliente

lucas :: Cliente
lucas = UnCliente "Lucas" "Victoria"
daniel :: Chofer
daniel = UnChofer "Daniel" 23500 [UnViaje 20042017 lucas 150] (noVivenEnZona "olivos")
alejandra :: Chofer
alejandra = UnChofer "Alejandra" 180000 [] cualquiera

puedeTomarViaje :: Chofer -> Condicion
puedeTomarViaje = tomarViaje

liquidacion :: Chofer -> Int
liquidacion chofer = sum (map costo (viajes chofer))

filtrarTomanViaje :: Viaje -> [Chofer] -> [Chofer]
filtrarTomanViaje viaje = filter (\chofer -> tomarViaje chofer viaje)
{- aplicacion parcial de "choferes" -}

minimoSegun f = foldl1 (menorSegun f)
menorSegun f a b
  | f a < f b = a
  | otherwise = b  

choferElegido viaje choferes = minimoSegun (length . viajes) (filtrarTomanViaje viaje choferes)

relizarUnViaje :: Viaje -> [Chofer] -> Chofer
relizarUnViaje viaje choferes = (choferElegido viaje choferes) {viajes= viajes (choferElegido viaje choferes) ++ [viaje]}

repetirViaje :: Viaje -> [Viaje]
repetirViaje viaje = viaje : repetirViaje viaje

nitoInfy :: Chofer
nitoInfy = UnChofer "Nito Infy" 70000 (repetirViaje (UnViaje 11032017 lucas 50)) (masDeNLetras 3)

{- 
7b no se puede calcular 
7c si se puede calcular 
-}
{- 
gongNeng :: Ord c => c -> (c -> Bool) -> (a -> c) -> [a] -> c
gongNeng arg1 arg2 arg3 = 
     max arg1 . head . filter arg2 . map arg3
 -}