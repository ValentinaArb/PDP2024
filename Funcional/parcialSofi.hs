import Text.Show.Functions
import Data.List

--Autores y obras

data Autor = UnAutor{
    obras :: [Obra],
    nombreAutor :: String
} deriving Show

data Obra = UnaObra{
    nombreObra :: String,
    anioPublicacion :: Int
} deriving Show

obraA,obraB,obraC,obraD,obraE :: Obra
obraA = UnaObra "Había una vez un pato." 1997
obraB = UnaObra "¡Habia una vez un pato!" 1996
obraC = UnaObra "Mirtha, Susana y Moria." 2010
obraD = UnaObra "La semántica funcional del amoblamiento vertebral es riboficiente" 2020
obraE = UnaObra "La semántica funcional de Mirtha, Susana y Moria." 2022

carlos,pedro :: Autor
carlos = UnAutor [obraA,obraD] "carlos"
pedro = UnAutor [obraB,obraC,obraE] "pedro"

sacarAcento :: Char -> Char
sacarAcento c
    |c == 'á' = 'a'
    |c == 'é' = 'e'
    |c == 'í' = 'i'
    |c == 'ó' = 'o'
    |c == 'ú' = 'u'
    |c == 'Á' = 'A'
    |c == 'É' = 'E'
    |c == 'Í' = 'I'
    |c == 'Ó' = 'O'
    |c == 'Ú' = 'U'
    |otherwise = c

perteneceAlAbecedario :: Char -> Bool
perteneceAlAbecedario c = c `elem` "abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ"

eliminarCaracteres :: Char -> Char
eliminarCaracteres c
    |perteneceAlAbecedario c = c
    |otherwise = ' '

versionCruda :: Obra -> [Char]
versionCruda obra = map (eliminarCaracteres . sacarAcento) (nombreObra obra)

anioPlagio :: Obra -> Obra -> Bool
anioPlagio obra obraPlagio = anioPublicacion obraPlagio +1 == anioPublicacion obra 

copiaLiteral :: Obra -> Obra -> Bool
copiaLiteral obra obraPlagio = (==) (versionCruda obra) (versionCruda obraPlagio)

empiezaIgual :: Int -> Obra -> Obra -> Bool 
empiezaIgual n obra obraPlagio = take n [nombreObra obra] == take n [nombreObra obraPlagio] && length (nombreObra obra) < length (nombreObra obraPlagio)

{- terminaIgual n obra obraPlagio =  -}