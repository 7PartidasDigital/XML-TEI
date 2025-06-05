# Este script numera secuencialmente rectos y versos
# y renombra los ficheros
# Lo primero es extraerlos del pdf página a página.
# Se convierte en jpg a 150 dpi, puede ser mayor o menor.
# Se apartan los que sean pre y pos a la foliciación,
# depende de cada códice.
library(pdftools)
pdf_split("12Trabajs_Congress.pdf")

# CONVIERTE PDF A JPG 300 DPI

pdf <- list.files()
jpg <- gsub("pdf", "jpg", pdf)
for( i in 1:length(pdf)){
  pdf_convert(pdf[i], format = "jpg", dpi = 300, filenames = jpg[i])
}
file.remove(pdf)

# Este script fusiona dos jpg en una solo
# Lo utilizo para tener una visión vuelto-recto
# de un testimonio que me ha llegado carilla
# a carilla

library(magick)
library(tidyverse)
# OJO A CUALES SON RECTOS Y VERSOS
vueltos <- list.files(pattern = '[13579].jpg')
#rectos <- rectos[2:length(rectos)]
rectos <- list.files(pattern = '[24680].jpg')
#vueltos <- vueltos[1:length(vueltos)-1]
for(i in 1:length(rectos)){
  izda <- image_read(vueltos[i])
  dcha <- image_read(rectos[i])
  final <- image_append(c(izda,dcha))
  image_write(final, path = paste("12HERCULES_", str_pad(i, 2, pad="0"), ".jpg", sep = ""), format = "jpg")
}


# ESTO REDUCE A LA MITAD EL TAMAÑO DE LA FOTO
library(EBImage)
ficheros <- list.files()
for(i in 1:length(ficheros)){
  folio <- readImage(ficheros[i])
  folio <- resize(folio, dim(folio)[1]/2)
  writeImage(folio, ficheros[i], quality = 75)
}





# NUMERA LOS FOLIOS R/V
library(tidyverse)
hojas <- list.files()
rectos <- paste("MN6-BNE-12793_", str_pad(1:38, 3, pad = "0"), "r.jpg", sep = "") 
vueltos <- paste("MN6-BNE-12793_", str_pad(1:38, 3, pad = "0"), "v.jpg", sep = "")
nuevos <- sort(c(rectos,vueltos))
file.rename(pdf, nuevos)



pdf <- gsub(" (\\d{2})\\.", " 0\\1\\.", pdf)
nuevos <- pdf
