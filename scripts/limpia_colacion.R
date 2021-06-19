# Convierte en tablas tsv los ficheros de salida
# de Collatex eliminando las plecas y guiones que
# crean la tabla de salida para leerlo en Excel
# para que marque las diferencias.

library(tidyverse)
ficheros <- list.files(pattern = ".txt")
for(i in 1:length(ficheros)){
  uno <- readLines(ficheros[i])
  uno <- gsub("^\\| *", "", uno)
  uno <- gsub(" +\\|$", "", uno)
  uno <- gsub(" +\\| +", "\t", uno)
  uno <- gsub("^\\+-----.*$", "", uno)
  uno <- uno[uno !=""]
  writeLines(uno, ficheros[i])
}

# El siguiente snippet lee las tabla y las convierte
# en un Excel en el que cada titulo es una hoja.

ficheros <- list.files(pattern = ".txt")
hojas <- gsub("colacion_(.*)\\.txt", "\\1", ficheros)
datos <- lapply(ficheros, read_tsv)
names(datos) <- hojas
writexl::write_xlsx(datos, "PRUEBA2.xlsx")
