import Text.Show.Functions
import Data.List

data Ciudad = UnaCiudad{
    nombre :: String,
    anioFundacion :: Float,
    atracciones :: [String],
    costoDeVida :: Float
} deriving Show

--UTILES
isVowel :: Char -> Bool
isVowel character = character `elem` "aeiouAEIOU"
incrementarCostoVida,decrementarCostoVida :: Float -> Ciudad -> Ciudad
incrementarCostoVida cantidad ciudad = ciudad{costoDeVida = costoDeVida ciudad + cantidad / 100 * costoDeVida ciudad} 
decrementarCostoVida cantidad = incrementarCostoVida (-cantidad)

--CIUDADES
baradero :: Ciudad
baradero = UnaCiudad "Baradero" 1615 ["Parque del Este","Museo Alejandro Barbich"] 150
nullish :: Ciudad
nullish = UnaCiudad "Nullish" 1800 [] 140
caletaOlivia :: Ciudad
caletaOlivia = UnaCiudad "Caleta Olivia" 1901 ["El Gorosito","Faro Costanera"] 120
maipu :: Ciudad
maipu = UnaCiudad "Maipú" 1878 ["Fortin Kakel"] 115
azul :: Ciudad
azul = UnaCiudad "Azul" 1832 ["Teatro Espanol", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"] 190

--1
valorCiudad :: Ciudad -> Float
valorCiudad ciudad
    |(< 1800) . anioFundacion $ ciudad  = (*5) . (1800 -) . anioFundacion $ ciudad
    |null . atracciones $ ciudad = (*2) . costoDeVida $ ciudad
    |otherwise = (*3) . costoDeVida $ ciudad

--2
algunaAtraccionCopada :: Ciudad -> Bool
algunaAtraccionCopada ciudad = not(null . atracciones $ ciudad) && any (isVowel . head) (atracciones ciudad) {- aplicacion parcial "nombre" -}

ciudadSobria :: Float -> Ciudad -> Bool
ciudadSobria x ciudad= not(null . atracciones $ ciudad) && (all ((> x) . fromIntegral .  length) . atracciones $ ciudad) {- composicion -}

ciudadConNombreRaro :: Ciudad -> Bool
ciudadConNombreRaro = (<5) . length . nombre {- composicion y aplicacion parcial de ciudad -}

--3
type Evento = Ciudad -> Ciudad

nuevaAtraccion :: String -> Ciudad -> Ciudad
nuevaAtraccion atraccion ciudad = ciudad {atracciones = atracciones ciudad ++ [atraccion]}

sumarNuevaAtraccion :: String -> Evento
sumarNuevaAtraccion atraccion =  incrementarCostoVida 0.2 . nuevaAtraccion atraccion {- aplicacionParcial ciudad-}

cerrarUltimaAtraccion :: Ciudad -> Ciudad
cerrarUltimaAtraccion ciudad = ciudad {atracciones = take (length (atracciones ciudad) - 1) (atracciones ciudad)}

crisis :: Evento
crisis = decrementarCostoVida 0.1 . cerrarUltimaAtraccion {- aplicacionParcial ciudad-}

agregarPrefijoNew :: Ciudad -> Ciudad
agregarPrefijoNew ciudad = ciudad{nombre = "New" ++ nombre ciudad} 

remodelacion :: Float -> Evento
remodelacion porcentaje = agregarPrefijoNew . incrementarCostoVida porcentaje {- aplicacionParcial ciudad-} 

reevaluacion :: Float -> Evento
reevaluacion n ciudad
    |ciudadSobria n ciudad = incrementarCostoVida 0.1 ciudad
    |otherwise = ciudad {costoDeVida = costoDeVida ciudad - 3}

--4
transformacionNoPara :: Float -> Float -> String -> Ciudad -> Ciudad
transformacionNoPara n porcentaje atraccion = reevaluacion n . crisis . remodelacion porcentaje . nuevaAtraccion atraccion

data Anio = UnAnio{
    numero :: Int,
    eventos :: [Evento]
}

anio2022,anio2015 :: Anio
anio2022 = UnAnio 2022 [crisis,remodelacion 5, reevaluacion 7]
anio2015 = UnAnio 2015 []

losAniosPasan :: Anio -> Ciudad -> Ciudad
losAniosPasan anio ciudad = foldl (flip($)) ciudad (eventos anio)  