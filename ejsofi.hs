{- data Color = Gris | Violeta | Celeste | Rosa deriving(Show)
data Categoria = Comunes | Fuerte | HighEnd | Pichi deriving(Show)

data Poder = UnPoder{
    cantidadCuracion :: Int,
    cantidadDanio :: Int,
    rangoAtaque :: Int,
    probabilidadDanioCritico:: Int
}

data Nomu = UnNomu {
    tieneAlas :: Bool,
    tieneMultiplesBrazos :: Bool,
    cantidadDeOjos :: Int,
    colorPiel :: Color,
    cantidadVida :: Int,
    cantidadFuerza :: Int,
    categoria :: Categoria,
    poder :: Poder
}deriving Show

puedeVer :: Nomu -> Bool
puedeVer nomu = cantidadDeOjos nomu > 0

categoriaNomu :: Nomu -> Categoria
categoriaNomu categoria
    |cantidadFuerza<3000 && cantidadFuerza> 1000 = Comunes
    |cantidadFuerza>3000 && cantidadFuerza<10000 = Fuertes
    |cantidadFuerza>10000 = HighEnd
    |otherwise = Pichi
 -}