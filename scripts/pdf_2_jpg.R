# Este script numera secuencialmente rectos y versos
# y renombra los ficheros
# Lo primero es extraerlos del pdf página a página.
# Se convierte en jpg a 150 dpi, puede ser mayor o menor.
# Se apartan los que sean pre y pos a la foliciación,
# depende de cada códice.


# CONVIERTE PDF A JPG 300 DPI
# setwd("~/Desktop/MN0-4") # EL QUE SEA
library(pdftools)
pdf <- list.files()
jpg <- gsub("pdf", "jpg", pdf)
for( i in 1:length(pdf)){
  pdf_convert(pdf[i], format = "jpg", dpi = 300, filenames = jpg[i])
}
file.remove(pdf)

# NUMERA LOS FOLIOS R/V
library(tidyverse)
hojas <- list.files()
rectos <- paste("MN6-BNE-12793_", str_pad(1:38, 3, pad = "0"), "r.jpg", sep = "") 
vueltos <- paste("MN6-BNE-12793_", str_pad(1:38, 3, pad = "0"), "v.jpg", sep = "")
nuevos <- sort(c(rectos,vueltos))
file.rename(pdf, nuevos)



pdf <- gsub(" (\\d{2})\\.", " 0\\1\\.", pdf)
nuevos <- pdf
