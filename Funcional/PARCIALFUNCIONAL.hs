
import Text.Show.Functions
import Data.List

type Habilidad = Persona -> Persona
type ModificarCampo = Float -> Persona -> Persona

data Persona = UnaPersona{
    nombre :: String,
    edad :: Float,
    felicidad :: Float,
    estres :: Float, 
    guita :: Float,
    habilidades :: [Habilidad]
} deriving Show

--1
anabel :: Persona
anabel = UnaPersona "Anabel" 21 60 15 19 []

bruno :: Persona
bruno = UnaPersona "Bruno" 15 90 5 0 [cocinar,cocinar,cocinar,cocinar,cocinar]

clara :: Persona
clara = UnaPersona "Clara" 31 10 90 25 []

--FUNCIONES UTILES
personas :: [Persona]
personas = [anabel,bruno,clara]

aumentarFelicidad :: ModificarCampo
aumentarFelicidad cantidad persona = persona {felicidad = felicidad persona + cantidad}

disminuirFelicidad :: ModificarCampo
disminuirFelicidad cantidad = aumentarFelicidad (-cantidad) {- aplicacion parcial persona -}

modificarEstres :: ModificarCampo
modificarEstres = aumentarEstres

aumentarEstres :: ModificarCampo
aumentarEstres cantidad persona = persona {estres= estres persona + cantidad}

disminuirEstres :: ModificarCampo
disminuirEstres cantidad = aumentarEstres (-cantidad) {- aplicacion parcial persona -}

aumentarGuita :: ModificarCampo
aumentarGuita cantidad persona = persona {guita= guita persona + cantidad}

disminuirGuita :: ModificarCampo
disminuirGuita cantidad = aumentarGuita (-cantidad) {- aplicacion parcial persona -} 

--2
esJovenAdulto :: Persona -> Bool
esJovenAdulto persona = edad persona >18 && 30 > edad persona

jovenesAdultos :: [Persona] -> [Persona]
jovenesAdultos = filter esJovenAdulto  
{- aplicacion parcial de personas y orden superior en filter ya que toma como parametro la función "esJovenAdulto"-}

--3
cocinar :: Habilidad
cocinar = disminuirEstres 4 . aumentarFelicidad 5 
{- aplicacion parcial de persona y composicion ya que la salida de aumentarFelicidad 5 (presona) es la entrada del disminuirEstres 4 -}

consecuenciasMascota :: Persona -> Persona
consecuenciasMascota = disminuirGuita 5 . aumentarFelicidad 20  
{- aplicacion parcial de persona y composicion ya que la salida de aumentarFelicidad 20 (persona) es la entrada del disminuirGuita 5 -}

tenerMascota :: Habilidad
tenerMascota persona
    |guita persona >= 60  = disminuirEstres 10 . consecuenciasMascota $ persona 
    |otherwise = aumentarEstres 5 . consecuenciasMascota $ persona 
    {- Composicion ya que la salida de consecuenciasMascota (persona) es la entrada del aumentarEstres 5 -}

trabajarEn :: String -> Habilidad
trabajarEn trabajo persona
    |trabajo == "Software" = aumentarEstres 10 . aumentarGuita 20 $ persona
    |trabajo == "Docencia" = aumentarEstres 30 persona
    |otherwise = aumentarEstres 5 . aumentarGuita 5 $ persona 
    {- Composicion ya que la salida de aumentarGuita 5 (persona) es la entrada del aumentarEstres 5 -}

consecuenciasCompartirCasa :: Persona -> Persona -> Persona
consecuenciasCompartirCasa personaCompartir persona  = 
    aumentarFelicidad 5 . modificarEstres ((estres personaCompartir - estres persona) / 2) $ persona
    {- Composicion ya que la salida de modificarEstres (persona) es la entrada del aumentarFelicidad 5 -}

compartirCasa :: Persona -> Habilidad 
compartirCasa personaCompartir personaPrincipal 
    |guita personaCompartir > guita personaPrincipal = aumentarGuita 10 . consecuenciasCompartirCasa personaCompartir $ personaPrincipal
    |otherwise = consecuenciasCompartirCasa personaCompartir personaPrincipal
    {- Composicion ya que la salida de consecuenciasCompartirCasa personaCompartir(persona) es la entrada del aumentarGuita 10 -}

--4
limitePersona :: Persona -> Int
limitePersona persona 
    |(< 18) . edad $ persona = 3
    |esJovenAdulto persona = 6
    |otherwise = 4

eliminarHabilidades :: Int -> Persona -> Persona
eliminarHabilidades cantidad persona = persona {habilidades = take cantidad (habilidades persona)}

aprenderNuevaHabilidad :: Habilidad -> Persona -> Persona
aprenderNuevaHabilidad nuevaHabilidad persona = 
    persona {habilidades = [nuevaHabilidad] ++ (habilidades . eliminarHabilidades (limitePersona persona -1) $ persona)}

--5
aumenta :: (Persona -> Float) -> Habilidad -> Persona -> Bool
aumenta campo habilidad persona =  campo persona < campo (habilidad persona)

valeLaPenaAprenderHabilidad :: Habilidad -> Persona -> Bool
valeLaPenaAprenderHabilidad habilidad persona = aumenta felicidad habilidad persona || aumenta guita habilidad persona

--6
cursoIntensivo :: [Habilidad] -> Persona -> Persona
cursoIntensivo habilidades persona = foldl (flip aprenderNuevaHabilidad) persona habilidades
{- Es de orden superior porque foldl utiliza como parametro la función aprenderNuevaHabilidad -}

--7
cumplirAnios :: Persona -> Persona
cumplirAnios persona = persona {edad = edad persona +1}

felizCumple :: Persona -> Persona
felizCumple persona = eliminarHabilidades (limitePersona persona) . cumplirAnios $ persona