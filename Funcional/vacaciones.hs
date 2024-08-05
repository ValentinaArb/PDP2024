import Text.Show.Functions
import Data.List

data Turista = UnTurista{
    nivelDeCansancio :: Int,
    nivelDeStress :: Int,
    viajaSolo :: Bool,
    idiomasQueHabla :: [String]
} deriving Show

type Excursion = Turista -> Turista

ana :: Turista
ana = UnTurista 0 21 False ["espaniol"]

beto :: Turista
beto = UnTurista 15 15 True ["aleman"]

cathi :: Turista
cathi = UnTurista 15 15 True ["aleman", "catalan"]

cambiarStress :: (Int -> Int -> Int) -> Int -> Turista -> Turista
cambiarStress producto cantidad turista= turista{nivelDeStress= producto (nivelDeStress turista) cantidad}
cambiarCansancio :: (Int -> Int -> Int) -> Int -> Turista -> Turista
cambiarCansancio producto cantidad turista = turista{nivelDeCansancio= producto (nivelDeCansancio turista) cantidad}

irALaPlaya :: Excursion
irALaPlaya turista
    |viajaSolo turista = cambiarCansancio (-) 5 turista
    |otherwise = cambiarStress (-) 1 turista

apreciarElementoPaisaje :: String -> Excursion
apreciarElementoPaisaje elemento = cambiarStress (-) (length elemento)

salirAHablarIdioma :: String -> Excursion
salirAHablarIdioma idioma turista = turista{idiomasQueHabla = idiomasQueHabla turista ++ [idioma], viajaSolo = False}

nivelDeIntensidad :: Int -> Int
nivelDeIntensidad = (`div` 4)

caminar :: Int -> Turista -> Turista
caminar minutos  = cambiarCansancio (+) (nivelDeIntensidad  minutos) . cambiarStress (-) (nivelDeIntensidad  minutos) 

paseoEnBarco :: String -> Excursion
paseoEnBarco marea turista 
    |marea == "fuerte" = cambiarStress (+) 6 . cambiarCansancio (+) 10 $ turista
    |marea == "moderada" = turista
    |marea == "tranquila" = salirAHablarIdioma "aleman" . apreciarElementoPaisaje "mar" . caminar 10 $ turista

hacerUnaExcursion :: Excursion -> Turista -> Turista
hacerUnaExcursion excursion turista = cambiarStress (-) (div (10* nivelDeStress turista) 100) . excursion $ turista

deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2

deltaExcursionSegun :: (Turista -> Int) -> Excursion -> Turista -> Int
deltaExcursionSegun indice excursion turista = deltaSegun indice (hacerUnaExcursion excursion turista) turista

esExcursionEducativa :: Excursion -> Turista -> Bool
esExcursionEducativa excursion turista = deltaExcursionSegun (length.idiomasQueHabla) excursion turista > 0

cambioCansancio :: Excursion -> Turista -> Int
cambioCansancio =  deltaExcursionSegun nivelDeCansancio

cambioEstres :: Excursion -> Turista -> Int
cambioEstres =  deltaExcursionSegun nivelDeStress

esExcursionDesestresante :: Turista -> Excursion -> Bool
esExcursionDesestresante turista excursion = cambioEstres excursion turista <= -3 

type Tour = [Excursion]

completo :: Tour
completo = [salirAHablarIdioma "melmacquiano" , irALaPlaya , caminar 40, apreciarElementoPaisaje "cascada", caminar 20] 
    
ladoB :: Excursion -> Tour
ladoB excursion = [paseoEnBarco "tranquila", excursion, caminar 120, paseoEnBarco "tranquila"]

excursionIslaVecina :: String -> Excursion
excursionIslaVecina marea
    |marea == "fuerte" = apreciarElementoPaisaje "lago"
    |otherwise = irALaPlaya 

islaVecina :: String -> [Excursion]
islaVecina marea = [paseoEnBarco marea, excursionIslaVecina marea,paseoEnBarco marea]   

hacerTour :: Turista -> Tour -> Turista
hacerTour turista tour= foldl (flip($)) (cambiarStress (+) (length tour) turista) tour

excursionConvincente :: Turista -> [Excursion] -> Bool
excursionConvincente turista tour = length (filter (esExcursionDesestresante turista) tour) > 1 && not (viajaSolo . hacerTour turista $ tour)

espiritualidad :: Turista -> Excursion -> Int
espiritualidad turista excursion = max 0 (cambioCansancio excursion turista) + max 0 (cambioEstres excursion turista )

efectividadTourPersona :: Turista -> [Excursion] -> Int
efectividadTourPersona turista = sum. map (espiritualidad turista)

efectividadTour :: [Excursion] -> [Turista] -> Int
efectividadTour tour =  sum . map (\turista -> efectividadTourPersona turista tour)

playasInfinitas :: Tour
playasInfinitas = cycle [irALaPlaya]