# Esa es la buena, por ahora
library(tidyverse)
a <- readLines("MN0-4.xml")
#Averigua en qué posiciones están los [fol. XXX]
folios <- grep("fol\\. XXX", a)

# creamos los vectors rectos / vueltos.
# Hay que saber el número inicial y final y cambiarlos a ambos
# las de los dos puntos
# Si el rangos de folios es mayor de 99, entonces hay
# que aumentar a 3
rectos <- paste("[fol. ", str_pad(325:330, 3, pad = "0"), "r]", sep = "")
vueltos <- paste("[fol. ", str_pad(325:330, 3, pad = "0"), "v]", sep = "")
foliacion <- sort(c(rectos,vueltos))
a[folios] <- foliacion
writeLines(a, "TEXT.MN0-4-testR.txt")
