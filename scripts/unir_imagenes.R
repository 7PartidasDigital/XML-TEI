# Este script fusiona dos jpg en una solo
# Lo utilizo para tener una visión vuelto-recto
# de un testimonio que me ha llegado carilla
# a carilla

library(magick)
library(tidyverse)
rectos <- list.files(pattern = '[13579].jpg')
#rectos <- rectos[2:length(rectos)]
vueltos <- list.files(pattern = '[24680].jpg')
#vueltos <- vueltos[1:length(vueltos)-1]
for(i in 1:length(rectos)){
  izda <- image_read(vueltos[i])
  dcha <- image_read(rectos[i])
  final <- image_append(c(izda,dcha))
  image_write(final, path = paste("Z14_", str_pad(i, 3, pad="0"), ".jpg", sep = ""), format = "jpg")
}


# ESTO REDUCE A LA MITAD EL TAMAÑO DE LA FOTO
library(EBImage)
ficheros <- list.files()
for(i in 1:length(ficheros)){
  folio <- readImage(ficheros[i])
  folio <- resize(folio, dim(folio)[1]/2)
  writeImage(folio, ficheros[i], quality = 75)
}
