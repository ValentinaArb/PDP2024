import Text.Show.Functions
import Data.List

data Libro = Libro {
    titulo :: String,
    autor:: String,
    capitulos:: [Int],
    paginas:: [Int]
 } 

elVisitante :: Libro
elVisitante = Libro {
    titulo = "elVisitante",
    autor = "Stephen King",
    capitulos = [],
    paginas = [592]
}
shingekiNoKyojin :: Libro
shingekiNoKyojin = Libro {
    titulo = "shingekiNoKyojin",
    autor = "Hajime Isayama",
    capitulos = [1,3,127],
    paginas = [40,40,40]
}
fundacion :: Libro
fundacion = Libro {
    titulo = "fundacion",
    autor = "Isaac Asimov",
    capitulos = [],
    paginas = [230]
}
sandman :: Libro
sandman = Libro {
    titulo = "sandman",
    autor = "Neil Gaiman",
    capitulos = [5,10,12],
    paginas = [35,35,35]
}
eragon :: Libro
eragon = Libro {
    titulo = "eragon",
    autor = "Christopher Paolini",
    capitulos = [],
    paginas = [544]
}
eldest :: Libro
eldest = Libro {
    titulo = "eldest",
    autor = "Christopher Paolini",
    capitulos = [],
    paginas = [704]
}
brisignr :: Libro
brisignr = Libro {
    titulo = "brisignr",
    autor = "Christopher Paolini",
    capitulos = [],
    paginas = [700]
}
legado :: Libro
legado = Libro {
    titulo = "legado",
    autor = "Christopher Paolini",
    capitulos = [],
    paginas = [811]
}

biblioteca :: [Libro]
biblioteca = [elVisitante,shingekiNoKyojin,fundacion,sandman,eragon,eldest,brisignr,legado]

sagaEragon :: [Libro]
sagaEragon = [eragon,eldest,brisignr,legado]

totalPaginasLibro :: Libro -> Int
totalPaginasLibro libro = sum(paginas libro)

totalPaginasBiblioteca :: [Libro] -> Int
totalPaginasBiblioteca = sum.map(\x->totalPaginasLibro(x))

cantidadDeLibros :: [Libro] -> Int
cantidadDeLibros = length

promedioPaginas :: [Libro] -> Int
promedioPaginas biblioteca = totalPaginasBiblioteca biblioteca `div` cantidadDeLibros biblioteca

titulosBiblioteca :: [Libro] -> [String]
titulosBiblioteca = map (\x->titulo(x))

lecturaObligatoria :: Libro -> Bool
lecturaObligatoria libro = (autor(libro)=="Stephen King" || titulo libro == "Fundacion" || elem libro sagaEragon)

{- nombreDeLaBibliotecaConVocales :: [Libro]->[String]
nombreDeLaBibliotecaConVocales biblioteca = (++) (titulosBiblioteca biblioteca) -}

generoLibro :: Libro -> String 
generoLibro libro
    |autor libro == "Stephen King" = "Terror"
    |autor libro == "Hajime Isayama" = "Manga"
    |any (<40) (paginas libro) = "Comics"
    |otherwise = "No tiene"
