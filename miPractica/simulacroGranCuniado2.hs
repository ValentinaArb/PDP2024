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

data Evento = UnEvento {
    requerimiento :: Bool,
    indiceDeExito :: Int
}deriving (Show)

type Requerimiento = Participante -> Bool
type IndiceDeExito = Participante -> Int
type Prueba = Participante -> Evento

requerimientoBaileDeTiktok,requerimientoBotonRojo,requerimientoCuentasRapidas :: Requerimiento
indiceDeExitoBaileDeTiktok,indiceDeExitoBotonRojo,indiceDeExitoCuentasRapidas :: IndiceDeExito

requerimientoBaileDeTiktok participante = nivelPersonalidad participante == 20
indiceDeExitoBaileDeTiktok participante = nivelPersonalidad participante + 2* nivelAtractivo participante

requerimientoBotonRojo participante = nivelPersonalidad participante == 10 && nivelInteligencia participante == 20
indiceDeExitoBotonRojo _ = 100

requerimientoCuentasRapidas participante = nivelInteligencia participante == 40
indiceDeExitoCuentasRapidas participante = nivelInteligencia participante + nivelPersonalidad participante - nivelAtractivo participante

baileDeTikTok,botonRojo,cuentasRapidas :: Prueba
baileDeTikTok participante = UnEvento (requerimientoBaileDeTiktok participante) (indiceDeExitoBaileDeTiktok participante)
botonRojo participante = UnEvento (requerimientoBotonRojo participante) (indiceDeExitoBotonRojo participante)
cuentasRapidas participante = UnEvento (requerimientoCuentasRapidas participante) (indiceDeExitoCuentasRapidas participante)

pruebas :: [Prueba]
pruebas = [baileDeTikTok,botonRojo,cuentasRapidas]

superaPrueba participante prueba = prueba participante 

javierTulei,minimoKirchner,horacioBerreta,myriamBregwoman :: Participante
javierTulei = UnParticipante "Javier Tulei" 52 30 70 35 menosInteligente
minimoKirchner = UnParticipante "Minimo Kirchner" 46 0 40 50 masAtractivo
horacioBerreta = UnParticipante "Horacio Berreta" 57 10 60 50 masAtractivo
myriamBregwoman = UnParticipante "Myriam Bregwoman" 51 40 40 60 masViejo

masViejo,masAtractivo,menosInteligente :: [Participante] -> Participante
masViejo = undefined
masAtractivo = undefined
menosInteligente = undefined