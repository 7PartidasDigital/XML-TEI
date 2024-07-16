# Redimensiona imágnes fotográficas
# y las convierte en jpg si eran de otro tipo
entrada <- list.files()
salida <- gsub("png", "jpg", entrada)
tamanno <- "2100x3000+1950+340"

## 2100 es el ancho de la imagen
## 3000 es la altura de la imagen
## 1950 indica el punto horizontal en que comienza el recorte
## 340 indica el punto vertical en que comienza el corte

for(i in 1:length(entrada)){
  a <- image_read(entrada[i])
  b <- image_crop(a, geometry = tamanno)
  image_write(b, salida[i])
}

