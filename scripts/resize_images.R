# Este script sirve para leer jpg y cambiar el tamaño
# Hay que instalar Biocmanage y con el EBImage
library(EBImage)
entrada <- list.files()
for(i in 1: 4){
  x <- readImage(entrada[i])
  x <- resize(x, dim(x)[1]/2) # Reduce a la mitad la foto
  writeImage(x, entrada[i], quality = 85)
}

