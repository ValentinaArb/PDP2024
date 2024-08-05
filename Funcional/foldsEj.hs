import Text.Show.Functions
import Data.List

{- todosLosNombres [Persona {nombre = "carlos"}, Persona {nombre = "juli"}] -}

data Persona = Persona{
    nombre :: String
}

todosLosNombres :: [Persona] -> String
todosLosNombres [] = ""
todosLosNombres (x:xs) = foldl (++) "," (map nombre [x]) ++ todosLosNombres xs