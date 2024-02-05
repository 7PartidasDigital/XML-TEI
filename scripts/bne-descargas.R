# Se necesitan dos librerías que no son estándar
install.packages(c("stringr", "pdftools"))
library(stringr)
library(pdftools)

# Hay que descargar a un directorio que esté vacío
# y tenerlo como directorio de trabajo

### Parte bajar de la BNE
ms_pid <- "0000008374" # Es el identificador de la BDH
ms_sigla <- "MN0-7" # He puesto la signatura, pero puede ser lo que quieras
# Los números a ambos lados de los dos puntos son los límite de "páginas"
for(i in 831:930){
  download.file(url = paste('http://bdh-rd.bne.es/pdf.raw?query=id:"', ms_pid, '"&page=', i, sep=""),
                destfile = paste(ms_sigla, "_", stringr::str_pad(i, 3, pad="0"), ".pdf", sep = ""))
}

# La siguiente rutina convierte los pdf a jpeg de 300 dpi
entrada <- list.files()
for(j in 1:length(entrada)){
  pdf_convert(entrada[j],
              format = "jpeg",
              dpi = 300)
}
file.remove(entrada)


#FOLIAR IMÁGENES
viejos <- list.files()
rectos <- paste("MN0-7_", stringr::str_pad(415:464, 3, pad="0"), "r.pdf", sep = "")
vueltos <- paste("MN0-7_", stringr::str_pad(415:464, 3, pad="0"), "v.pdf", sep = "")
folios <- sort(c(rectos, vueltos))

file.rename(viejos, folios)
