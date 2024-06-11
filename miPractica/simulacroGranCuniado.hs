import Text.Show.Functions
import Data.List

type Criterio = [Participante] -> Participante

data Participante = UnParticipante{
    nombre :: String,
    edad :: Float,
    nivelAtractivo :: Float,
    nivelPersonalidad :: Float,
    nivelInteligencia :: Float,
    criterioDeVoto :: Criterio
}deriving (Show)

type Prueba = Participante -> (Bool, Float)
baileDeTiktok :: Prueba
baileDeTiktok participante = ((==) 20 (nivelPersonalidad participante), nivelPersonalidad participante + 2* nivelAtractivo participante)
botonRojo :: Prueba
botonRojo participante = ((==) 10 (nivelPersonalidad participante) && (==) 20 (nivelInteligencia participante), 100)
cuentasRapidas :: Prueba
cuentasRapidas participante = ((==) 40 (nivelInteligencia participante), nivelInteligencia participante + nivelPersonalidad participante - nivelAtractivo participante)

superaPrueba :: Prueba -> Participante -> Bool
superaPrueba prueba participante = fst (prueba participante) 

superanPrueba :: Prueba -> [Participante] -> [Participante]
superanPrueba prueba = filter (\x -> True == superaPrueba prueba x)

soloIndiceDeExitoParticipantes :: Prueba -> [Participante] -> [Float]
soloIndiceDeExitoParticipantes prueba = map (snd.prueba)

promedioIndiceExito :: Prueba -> [Participante] -> Float
promedioIndiceExito prueba = (/2).sum.soloIndiceDeExitoParticipantes prueba

soloIndiceDeExitoParticipante :: [Prueba] -> Participante -> [Float]
soloIndiceDeExitoParticipante pruebas participante = map (\x-> snd(x participante)) pruebas

esFavorito :: [Prueba] -> Participante -> Bool
esFavorito pruebas participante = all (>50) (soloIndiceDeExitoParticipante pruebas participante)

menosInteligente :: Criterio
menosInteligente = minimumBy (\p1 p2 -> compare (nivelInteligencia p1) (nivelInteligencia p2))
masAtractivo :: Criterio
masAtractivo = maximumBy (\p1 p2 -> compare (nivelAtractivo p1) (nivelAtractivo p2))
masViejo :: Criterio
masViejo = maximumBy (\p1 p2 -> compare (edad p1) (edad p2))

javierTulei :: Participante
javierTulei = UnParticipante "Javier Tulei" 52 30 70 35 menosInteligente
minimoKirchner :: Participante
minimoKirchner = UnParticipante "Mínimo Kirchner" 46 0 40 50 masAtractivo
horacioBerreta :: Participante
horacioBerreta = UnParticipante "Horacio Berreta" 57 10 60 50 masAtractivo 
myriamBregwoman :: Participante
myriamBregwoman = UnParticipante "Myriam Bregwoman" 51 40 40 60 masViejo

participantes :: [Participante]
participantes = [javierTulei,minimoKirchner,horacioBerreta,myriamBregwoman]

enPlaca :: [Participante]
enPlaca = map (\x -> x participantes) (map criterioDeVoto participantes)

{- estaEnPlaca :: Participante -> Bool
estaEnPlaca participante = elem participante enPlaca 

zafo = filter estaEnPlaca participantes -}