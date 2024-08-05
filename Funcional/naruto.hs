import Text.Show.Functions
import Data.List

data Ninja = UnNinja{
    nombreNinja :: String,
    herramientas :: [Herramienta],
    jujutsus :: String,
    rango :: Int
} deriving Show

data Herramienta = UnaHerramienta{
    nombreHerramienta :: String,
    cantidad :: Int
} deriving Show

{- herramientaModificar :: Herramienta -> Ninja -> Herramienta
herramientaModificar nuevaHerramienta ninja = head(filter (==nuevaHerramienta) (herramientas ninja))

obtenerHerramienta :: Int -> Herramienta -> Ninja -> Ninja 
obtenerHerramienta pedidoCantidad nuevaHerramienta ninja
    |length (herramientas ninja) + pedidoCantidad <= 100 = ninja{herramientas = herramientaModificar{}}
 -}
{- usarHerramienta herramienta ninja = -}