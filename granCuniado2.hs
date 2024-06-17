import Text.Show.Functions
import Data.List

data Participante = UnParticipante{
    nombre :: String,
    edad :: Int,
    nivelAtractivo :: Int,
    nivelPersonalidad :: Int,
    nivelInteligencia :: Int,
    criterioVoto :: Criterio
} deriving Show

data Prueba = UnaPrueba{
    criterio :: Participante -> Bool,
    indiceExito :: Participante -> Int
} deriving Show

--1
calculoIndiceExito :: (Participante -> Bool) -> (Participante -> Int) -> Participante -> Int
calculoIndiceExito criterio indiceExito participante
    |criterio participante = indiceExito participante
    |otherwise = 0

indiceDeExito :: Prueba -> Participante -> Int
indiceDeExito prueba = calculoIndiceExito (criterio prueba) (indiceExito prueba)

criterioTiktok :: Participante -> Bool
criterioTiktok participante = nivelPersonalidad participante == 20
efectoTiktok :: Participante -> Int
efectoTiktok participante = nivelPersonalidad participante + nivelAtractivo participante *2

criterioBotonRojo :: Participante -> Bool
criterioBotonRojo participante = nivelPersonalidad participante == 10 && nivelInteligencia participante == 20
efectoBotonRojo :: Participante -> Int
efectoBotonRojo participante = 100

criterioCuentasRapidas :: Participante -> Bool
criterioCuentasRapidas participante = nivelInteligencia participante == 40 
efectoCuentasRapidas :: Participante -> Int
efectoCuentasRapidas participante =  nivelInteligencia participante + nivelPersonalidad participante - nivelAtractivo participante 

baileDeTiktok :: Prueba
baileDeTiktok = UnaPrueba criterioTiktok efectoTiktok 

botonRojo :: Prueba
botonRojo = UnaPrueba criterioBotonRojo efectoBotonRojo 

cuentasRapidas :: Prueba
cuentasRapidas = UnaPrueba criterioCuentasRapidas efectoCuentasRapidas 

{- Dado un grupo de participantes y una prueba, quiénes la superan. -}
superanPrueba ::  Prueba ->  [Participante] -> [Participante]
superanPrueba prueba  = filter (criterio prueba) {- aplicacion parcial de participantes -}

{- Dado un grupo de participantes y una prueba, el promedio del índice de éxito. -}
promedioIndiceExito :: Prueba -> [Participante] -> Int
promedioIndiceExito prueba = sum . map (indiceDeExito prueba) {- composicion y aplicacion particla de participantes -}

{- Dado un participante y un conjunto de pruebas, saber si ese participante es favorito, esto se cumple cuando supera todas las pruebas con un índice mayor a 50. -}
esParticipanteFavorito :: Participante -> [Prueba] -> Bool
esParticipanteFavorito participante =  all (\prueba -> indiceDeExito prueba participante >50) {- composicion y aplicacion particla de pruebas -}

segun funcion f = foldl1 (resultadoSegun funcion f)
resultadoSegun funcion f a b
  | funcion (f a) (f b) = a
  | otherwise = b

type Criterio = [Participante] -> Participante

menosInteligente :: Criterio
menosInteligente = segun (<) nivelInteligencia {- aplicacion parcial de participantes -}

masAtractivo :: Criterio
masAtractivo = segun (>) nivelAtractivo {- aplicacion parcial de participantes -}

masViejo :: Criterio
masViejo = segun (>) edad {- aplicacion parcial de participantes -}

javierTulei :: Participante
javierTulei = UnParticipante
    { nombre = "Javier Tulei"
    , edad = 52
    , nivelAtractivo = 30
    , nivelPersonalidad = 70
    , nivelInteligencia = 35
    , criterioVoto = menosInteligente
    }

minimoKirchner :: Participante
minimoKirchner = UnParticipante
    { nombre = "Mínimo Kirchner"
    , edad = 46
    , nivelAtractivo = 0
    , nivelPersonalidad = 40
    , nivelInteligencia = 50
    , criterioVoto = masAtractivo
    }

horacioBerreta :: Participante
horacioBerreta = UnParticipante
    { nombre = "Horacio Berreta"
    , edad = 57
    , nivelAtractivo = 10
    , nivelPersonalidad = 60
    , nivelInteligencia = 50
    , criterioVoto = masAtractivo
    }

myriamBregwoman :: Participante
myriamBregwoman = UnParticipante
    { nombre = "Myriam Bregwoman"
    , edad = 51
    , nivelAtractivo = 40
    , nivelPersonalidad = 40
    , nivelInteligencia = 60
    , criterioVoto = masViejo
    }

participantes = [myriamBregwoman,horacioBerreta,minimoKirchner,javierTulei]

nombreDelVotado :: [Participante] -> Participante -> String
nombreDelVotado participantes participante = nombre (criterioVoto participante participantes)

enPlaca :: [Participante] -> [String]
enPlaca participantes= map (nombreDelVotado participantes) participantes {- aplicacion parcial de participantes -}

cantidadVotosRecibidos :: Participante -> [String] -> Int
cantidadVotosRecibidos participante = length . filter (== nombre participante) {- composicion y aplicacion parcial de enPlaca -}

estaEnHorno :: Participante -> [String] -> Bool
estaEnHorno participante =  (>=3) . cantidadVotosRecibidos participante

hayAlgoPersonal :: Participante -> [String] -> Bool
hayAlgoPersonal participante placa = (== length placa) . cantidadVotosRecibidos participante $ placa {- composicion -}

zafo :: Participante -> [String] -> Bool
zafo participante = (==0) . cantidadVotosRecibidos participante {- composicion y aplicacion parcial de enPlaca -}