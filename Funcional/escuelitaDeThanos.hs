import Text.Show.Functions
import Data.List

data Guantelete = UnGuantelete{
    material :: String,
    gemasQuePosee :: [Gema]
} deriving Show

data Personaje = UnPersonaje{
    edad :: Int,
    energia :: Int,
    habilidades :: [String],
    nombre :: String,
    planeta :: String
} deriving Show

data Universo = UnUniverso{
    personajes :: [Personaje],
    guantelete :: Guantelete
} deriving Show

guanteleteCompleto :: Guantelete -> Bool
guanteleteCompleto = (==6). length . gemasQuePosee

chasquearElUniverso :: Universo -> Universo
chasquearElUniverso universo
    |guanteleteCompleto (guantelete universo) && material (guantelete universo) == "uru" = universo {personajes = take (length (personajes universo) `div` 2) (personajes universo)}
    |otherwise = universo

ironman :: Personaje
ironman = UnPersonaje 100 100 ["hola","chau","OGL"] "ironMan" "a" 

esAptoParaPendex :: Universo -> Bool
esAptoParaPendex universo = any ((<45) . edad) (personajes universo)

integrantesConMasDeUnaHabilidad :: [Personaje] -> [Personaje]
integrantesConMasDeUnaHabilidad = filter ((>1).length.habilidades) 

energiaTotalUniverso :: Universo -> Int
energiaTotalUniverso = sum . map energia . integrantesConMasDeUnaHabilidad . personajes

modificarEnergia :: Int -> Personaje -> Personaje
modificarEnergia valor personaje = personaje{energia = max 0 (energia personaje + valor)} -- si se quiere debilitar se pone -10, si quiere aumentar se pone 10 (ejemplo)
modificarHabilidades :: String -> Personaje -> Personaje
modificarHabilidades habilidad personaje = personaje{habilidades= filter (/= habilidad) (habilidades personaje)}
modificarPlaneta :: String -> Personaje -> Personaje
modificarPlaneta planeta personaje = personaje{planeta = planeta}
modificarEdad personaje = personaje{edad = max (edad personaje `div` 2) 18} 

type Gema = Personaje -> Personaje

laMente :: Int -> Gema
laMente = modificarEnergia

elAlma :: String -> Gema
elAlma habilidad = modificarHabilidades habilidad . modificarEnergia (-10)

elEspacio :: String -> Gema
elEspacio planeta = modificarPlaneta planeta . modificarEnergia (-20) 

elPoder :: Gema
elPoder personaje 
    | length (habilidades personaje) <=2 = foldl (flip modificarHabilidades) (modificarEnergia (- energia personaje) personaje) (habilidades personaje)
    | otherwise = modificarEnergia (- energia personaje) personaje

elTiempo :: Gema
elTiempo = modificarEdad . modificarEnergia (-50)

laGemaLoca :: Gema -> Gema
laGemaLoca gema = gema . gema

--4
guanteletePunto4 :: Guantelete
guanteletePunto4 = UnGuantelete "Goma" [elAlma "usarMjolnir", laGemaLoca (elAlma "programación en Haskell")]

--5
utilizar :: Personaje -> [Gema] -> Personaje
utilizar = foldl (flip ($)) {-  Indicar cómo se produce el “efecto de lado” sobre la víctima. no entendío -}

--6
gemaMasPoderosa :: Personaje -> Guantelete -> Gema
gemaMasPoderosa personaje guantelte = gemaMasPoderosaDe personaje $ gemasQuePosee guantelte

gemaMasPoderosaDe :: Personaje -> [Gema] -> Gema
gemaMasPoderosaDe _ [gema] = gema
gemaMasPoderosaDe personaje (gema1:gema2:gemas) 
    | (energia.gema1) personaje < (energia.gema2) personaje = gemaMasPoderosaDe personaje (gema1:gemas)
    | otherwise = gemaMasPoderosaDe personaje (gema2:gemas)

{- infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = UnGuantelete "vesconite" (infinitasGemas tiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemasQuePosee) guantelete -}
{- 
Justifique si se puede ejecutar, relacionándolo con conceptos vistos en la cursada:
gemaMasPoderosa punisher guanteleteDeLocos
usoLasTresPrimerasGemas guanteleteDeLocos punisher 
-}
