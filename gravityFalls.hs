import Text.Show.Functions
import Data.List

type Item = (Persona -> Bool) 

data Criatura = UnaCriatura{
    peligrosidad :: Int,
    cumplir :: Item
} deriving (Show)

data Persona = UnaPersona{
    nombre :: String,
    edad :: Int,
    items :: [String],
    experiencia :: Int
} deriving (Show)

valentina :: Persona
valentina = UnaPersona "valentina" 19 ["sopladorDeHojas"] 10

tieneItem :: String -> Persona -> Bool
tieneItem item persona = elem item (items persona)
nada :: Persona -> Bool
nada _ = False
evaluar :: (t1 -> t2) -> (t3 -> t1) -> t3 -> t2
evaluar condicion comparar persona = condicion (comparar persona)

siempreDetras :: Criatura
siempreDetras = UnaCriatura {peligrosidad=0, cumplir = nada}
gnomo :: Criatura
gnomo = UnaCriatura {peligrosidad=2, cumplir = tieneItem "sopladorDeHojas"}
fantasma :: Int -> Item -> Criatura
fantasma n cumplir = UnaCriatura {peligrosidad=20*n, cumplir = cumplir}

puedeDeshacerseDeElla :: Criatura -> Persona -> Bool 
puedeDeshacerseDeElla criatura persona = (cumplir criatura) persona

escapa :: Persona -> Persona
escapa persona = persona {experiencia = experiencia persona +1} 

enfrentamiento :: Criatura -> Persona ->Persona
enfrentamiento criatura persona 
    |puedeDeshacerseDeElla criatura persona = persona {experiencia = experiencia persona + peligrosidad criatura}
    |otherwise = escapa persona

enfrentarGrupo :: Persona -> [Criatura] -> Persona
enfrentarGrupo persona criaturas = foldl (flip enfrentamiento) persona criaturas

personaEjemplo :: Persona
personaEjemplo = UnaPersona "personaEjemplo" 12 ["disfrazDeOveja"] 15

grupoCriaturas :: [Criatura]
grupoCriaturas = [siempreDetras, fantasma 3 (evaluar (<13) edad), fantasma 1 (evaluar (>10) experiencia)] ++ take 10 (cycle [gnomo])

{- enfrentarGrupo personaEjemplo grupoCriaturas
UnaPersona {nombre = "personaEjemplo", edad = 12, items = ["disfrazDeOveja"], experiencia = 106} -}

{- FALTA PARTE 2 -}