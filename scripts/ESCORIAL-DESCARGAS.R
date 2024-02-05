setwd("~/Desktop")
library(stringr)
url_base = "https://imagenes.patrimonionacional.es/iiif/2/" #ESTO ES FIJO SIEMPRE
url_ms = "Z-I-14%2F" # Cambia con cada ms. o parte de ms.
url_final = ".jpg/full/full/0/default.jpg" #ESTO ES FIJO SIEMPRE
ms_id = "Z-I-14" # TOMO LA SIGNATURA PARA CREAR DIRECTORIO Y PREFIJO DE IMAGENES
dir.create(ms_id) # CREA EL DIRECTORIO
# Los números que hay a continuación son los números que tiene cada imagen
# en la web de Patrimonio. Solo hay que averiguar cuál es el rango y poner el
# primero y el último número.
for(i in 2:10){
  secuencia <- str_pad(i, 4, pad="0") # Crea los ceros a la izquierda
  download.file(url = paste(url_base, url_ms, secuencia, url_final, sep=""),
                destfile = paste(ms_id, "/", ms_id, "_", secuencia, ".jpg", sep = ""))
}
for(i in 236:274){
  secuencia <- str_pad(i, 4, pad="0") # Crea los ceros a la izquierda
  download.file(url = paste(url_base, url_ms, secuencia, url_final, sep=""),
                destfile = paste(ms_id, "/", ms_id, "_", secuencia, ".jpg", sep = ""))
}

# Las dos línea anteriores (que es una en realidad), busca la foto
# uniendo todos trocitos de la URL y la guarda en el disco duro en
# el directorio creado en la línea 6 con la identificación indicada
# en la línea 5 y pega todos los trocitos necesarios
# (directorio/signatura/número_foto.jpg) para crear el nombre
# correcto para cada imagen.
