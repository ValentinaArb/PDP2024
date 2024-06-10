import Text.Show.Functions
import Data.List

data Pais = UnPais{
    nombre :: String,
    ingresoPerCapita :: Float,
    poblacionActivaSectorPublico :: Float,
    poblacionActivaSectorPrivado :: Float,
    recursosNaturales :: [String],
    deuda :: Float --millones de dolares
}deriving (Show)


--ejemplos
argentina :: Pais
argentina = UnPais "Argentina" 4000000 8000000 6000000 ["tierra","carbon","piedra"] 50

namibia :: Pais
namibia = UnPais "Namibia" 4140 400000 650000 ["mineria", "ecoturismo","Petroleo"] 50

canada :: Pais
canada = UnPais "Canada" 4140 400000 650000 ["mineria","Petroleo"] 50

--estrategias
prestar :: Float -> Pais -> Pais
prestar n pais = pais {deuda = (deuda pais)+ n*1.5}

modificarIngresoPerCapita :: Float -> Pais -> Float
modificarIngresoPerCapita porcentaje pais = (ingresoPerCapita pais)+(ingresoPerCapita pais)*(porcentaje/100)

modificarPoblacionActivaSectorPublico :: Float -> Pais -> Float
modificarPoblacionActivaSectorPublico x pais = (poblacionActivaSectorPublico pais)+ x

reducirPuestosTrabajoSectorPublico :: Float -> Pais -> Pais
reducirPuestosTrabajoSectorPublico x pais
    | x>100 = pais {poblacionActivaSectorPublico = modificarPoblacionActivaSectorPublico x pais, ingresoPerCapita = modificarIngresoPerCapita (-20) pais}
    | otherwise = pais {poblacionActivaSectorPublico = modificarPoblacionActivaSectorPublico x pais, ingresoPerCapita = modificarIngresoPerCapita (-15) pais}

sacarElemento :: String -> [String] -> [String] 
sacarElemento recurso = filter (/=recurso)

darAfin :: String -> Pais -> Pais 
darAfin recurso pais = pais {deuda = (deuda pais)-(2), recursosNaturales = sacarElemento recurso (recursosNaturales pais)}

poblacionActiva :: Pais -> Float
poblacionActiva pais= poblacionActivaSectorPrivado pais + poblacionActivaSectorPublico pais

pbi :: Pais -> Float
pbi pais= ingresoPerCapita pais * poblacionActiva pais

blindaje :: Pais -> Pais
blindaje pais = pais {deuda = (deuda pais) + pbi pais/2, poblacionActivaSectorPublico = modificarPoblacionActivaSectorPublico (-500) pais}

--recetas
prestarYDarAfin :: String -> Float -> Pais -> Pais
prestarYDarAfin recurso prestamo = darAfin recurso . prestar prestamo
-- prestarYDarAfin "mineria" 200 namibia

--4
recursosPaises:: [Pais] -> [[String]]
recursosPaises = map recursosNaturales

paisesQueZafan :: [Pais] -> [Pais]
paisesQueZafan paises = filter (\x-> elem("Petroleo") (recursosNaturales x) ==True) paises
nombrePaisQueZafa :: [Pais] -> [String]
nombrePaisQueZafa pais = map nombre (paisesQueZafan pais)

totalDeuda :: [Pais] -> Float
totalDeuda paises = sum(map deuda paises)

{- 
FALTA 5 
Debe resolver este punto con recursividad: dado un país y una lista de recetas, saber si la lista de recetas está ordenada de “peor” a “mejor”, en base al siguiente criterio: si aplicamos una a una cada receta, el PBI del país va de menor a mayor. -}
{- mejorPBI :: [Pais]->[]
mejorPBI pais (x:xs) = map pbi (x pais) -}

--6
recursosNaturalesInfinitos :: [String]
recursosNaturalesInfinitos = "Energia" : recursosNaturalesInfinitos
{- 
    Solo funcionará si los recursos Naturales infinitos son de petroleo, si es una pais que no tiene petroleo, seguira intentando encontrarlo hasta el infinito. 
    Esta funcion funciona ya que no necesita de la lsita de recursos Naturales, por lo que no correrá nunca.    
-}