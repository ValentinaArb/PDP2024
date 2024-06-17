import Text.Show.Functions
import Data.List

data Participante = UnParticipante {
    nombre :: String,
    edad :: Int,
    nivelAtractivo :: Int,
    nivelPersonalidad :: Int,
    nivelInteligencia :: Int,
    criterioDeVoto :: [Participante]-> Participante
} deriving (Show)

data Prueba = UnaPrueba {
    calcularRequerimiento :: Participante -> Bool,
    calcularIndiceDeExito :: Participante ->  Int
}deriving (Show)

type Requerimiento = Participante -> Bool
type IndiceDeExito = Participante -> Int

javierTulei,minimoKirchner,horacioBerreta,myriamBregwoman :: Participante
javierTulei = UnParticipante "Javier Tulei" 52 30 70 35 menosInteligente
minimoKirchner = UnParticipante "Minimo Kirchner" 46 0 40 50 masAtractivo
horacioBerreta = UnParticipante "Horacio Berreta" 57 10 60 50 masAtractivo
myriamBregwoman = UnParticipante "Myriam Bregwoman" 51 40 40 60 masViejo

requerimientoBaileDeTiktok,requerimientoBotonRojo,requerimientoCuentasRapidas :: Requerimiento
indiceDeExitoBaileDeTiktok,indiceDeExitoBotonRojo,indiceDeExitoCuentasRapidas :: IndiceDeExito

requerimientoBaileDeTiktok participante = nivelPersonalidad participante == 20
indiceDeExitoBaileDeTiktok participante = nivelPersonalidad participante + 2* nivelAtractivo participante

requerimientoBotonRojo participante = nivelPersonalidad participante == 10 && nivelInteligencia participante == 20
indiceDeExitoBotonRojo _ = 100

requerimientoCuentasRapidas participante = nivelInteligencia participante == 40
indiceDeExitoCuentasRapidas participante = nivelInteligencia participante + nivelPersonalidad participante - nivelAtractivo participante

baileDeTikTok,botonRojo,cuentasRapidas :: Prueba
baileDeTikTok = UnaPrueba requerimientoBaileDeTiktok indiceDeExitoBaileDeTiktok
botonRojo = UnaPrueba requerimientoBotonRojo indiceDeExitoBotonRojo
cuentasRapidas = UnaPrueba requerimientoCuentasRapidas indiceDeExitoCuentasRapidas

todosLosParticipantes :: [Participante]
todosLosParticipantes = [javierTulei,minimoKirchner,horacioBerreta,myriamBregwoman]

pruebas :: [Prueba]
pruebas = [baileDeTikTok,botonRojo,cuentasRapidas]

superanPruebas :: Prueba -> [Participante] -> [Participante]
superanPruebas prueba = filter (calcularRequerimiento prueba)

promedioIndiceDeExito :: Prueba -> [Participante] -> Int
promedioIndiceDeExito prueba = (`div` 2).sum.map (calcularIndiceDeExito prueba)

esFavorito :: [Prueba] -> Participante -> Bool
esFavorito pruebas participante = all ((> 50) . indiceIntentoPrueba participante) pruebas

indiceIntentoPrueba :: Participante -> Prueba -> Int
indiceIntentoPrueba participante prueba
    |calcularRequerimiento prueba participante = calcularIndiceDeExito prueba participante
    |otherwise = 0

segun criterio f = foldl1 (evaluarSegun criterio f)
evaluarSegun criterio f a b
  | criterio (f a) (f b) = a
  | otherwise = b

menosInteligente,masAtractivo,masViejo :: [Participante] -> Participante
menosInteligente = segun (<) nivelInteligencia
masAtractivo = segun (>) nivelAtractivo
masViejo = segun (>) edad

enPlaca :: [Participante] -> [Participante]
enPlaca participantes = map (\x-> criterioDeVoto x participantes) participantes

instance Eq Participante where
    (==) participante otroParticipante = nombre participante == nombre otroParticipante

cantidadVotos :: [Participante] -> Participante -> Int
cantidadVotos placa participanteEvaluar = length . filter (\participante -> criterioDeVoto participante placa == participanteEvaluar) $ placa

estaEnElHorno,hayAlgoPersonal,zafo :: [Participante] -> Participante -> Bool
estaEnElHorno placa = (>3).cantidadVotos placa
hayAlgoPersonal placa = (==1).cantidadVotos placa
zafo placa = (==0).cantidadVotos placa