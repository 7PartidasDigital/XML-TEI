###################################### CODIFICA TEI #######################################
#        Afina la codificación de los fichero Word transformados con TEIOOP5               #
#          transcritos de acuerdo con las normas para la edición de la RAH                #
#  Proyecto 7PartidasDigital "Edición crítica digital de las Siete Partidas de Alfonso X" #
#        Proyecto financiado por el MINECO, referencia FFI2016-75014-P AEI-FEDER, EU      #
#                Universidad de Valladolid -- IP José Manuel Fradejas Rueda               #
#                              https://7partidas.hypotheses.org/                          #
#                             https://github.com/7PartidasDigital                         #
#                         Este material se distribuye con una licencia                    #
#                                            MIT                                          #
#                                         v. 1.0.0                                        #


setwd("PON/LA/RUTA/ADECUADA/AQUÍ") # Normalmente
setwd("~/Desktop/trabajo")
# La siguiente instrucción, que cierra todo, es para lanzar automáticamente el proceso
system.time({
ficheros <- list.files()
div.tit <- gsub("RAH-", "", ficheros)
div.tit <- gsub("\\.xml", "", div.tit)
div.tit <- gsub("-", ".", div.tit)
div.tit <- gsub("\\.0", ".", div.tit)
div.tit <- paste(div.tit,".", sep="")

for (a in 1:length(ficheros)){
texto.entrada <- readLines(ficheros[a], encoding = "UTF-8") # Poner el nombre adecuado
texto.entrada <- gsub("^\\s+", "", texto.entrada) # Elimina espacios en blanco a comienzo de línea
texto.todo <- paste(texto.entrada, collapse = "\n") # Crea una única cadena
texto.todo <- gsub("mph>", 'x>', texto.todo, perl = T) # Convierte emph en ex para las abreviaturas
# Lo que sigue corrige errores tipográficos usuales
texto.todo <- gsub(" $", '', texto.todo, perl = T)
texto.todo <- gsub("<p>\n<e", '<p><e', texto.todo, perl = T)
texto.todo <- gsub("</ex>\n</p>", '</ex></p>', texto.todo, perl = T)
texto.todo <- gsub("</ex> \n</p>", '</ex></p>', texto.todo, perl = T)
texto.todo <- gsub("</ex>\\.", '\\.</ex>', texto.todo, perl = T)
texto.todo <- gsub("</ex> \\.", '\\.</ex>', texto.todo, perl = T)
texto.todo <- gsub("\\. </ex>", '\\.</ex>', texto.todo, perl = T)
texto.todo <- gsub("<ex> ", ' <ex>', texto.todo, perl = T)
texto.todo <- gsub(" \\. </p>", '\\.</p>', texto.todo, perl = T)
texto.todo <- gsub(" \\.</p>", '\\.</p>', texto.todo, perl = T)
texto.todo <- gsub("\\. </p>", '\\.</p>', texto.todo, perl = T)
texto.todo <- gsub("</ex> </p>", '</ex></p>', texto.todo, perl = T)
texto.todo <- gsub("<ex></ex>", '', texto.todo, perl = T)
texto.todo <- gsub(" </p>", '\\.</p>', texto.todo, perl = T)
texto.todo <- gsub("\\.\\.", '\\.', texto.todo, perl = T)
texto.todo <- gsub("<ex>LEY ([IVXCL]+)\\.</ex>", 'LEY \\1\\.', texto.todo, perl = T)



texto.todo <- gsub(" ([\\.,;:]) ", "\\1 ", texto.todo, perl = T)
# Marca los divs de TITULO
texto.todo <- gsub("<p>TITULO ([IVXLC]+)\\.</p>\n<p><ex>(.*)</ex></p>", '<div n="W.W.0" type="titulo">\n<head>TITULO \\1\\. \\2</head>', texto.todo, perl = T)
texto.todo <- gsub("<p>TITULO ([IVXLC]+)\\.</p>\n<p>(.*)</p>", '<div n="W.W.0" type="titulo">\n<head>TITULO \\1\\. \\2</head>', texto.todo, perl = T)
# Marca los div de LEY y corrige errores de transcripción
texto.todo <- gsub("<p>LEY ([IVXLC]+)\\.</p>\n<p><ex>(.*)</ex></p>", '</div>\n<div n="W.W.0" type="ley">\n<head>LEY \\1\\. \\2</head>', texto.todo, perl = T)
texto.todo <- gsub("<p>LE Y ([IVXLC]+)\\.</p>\n<p><ex>(.*)</ex></p>", '</div>\n<div n="W.W.0" type="ley">\n<head>LEY \\1\\. \\2</head>', texto.todo, perl = T)
texto.todo <- gsub("<p>L EY ([IVXLC]+)\\.</p>\n<p><ex>(.*)</ex></p>", '</div>\n<div n="W.W.0" type="ley">\n<head>LEY \\1\\. \\2</head>', texto.todo, perl = T)
texto.todo <- gsub("<p>LET ([IVXLC]+)\\.</p>\n<p><ex>(.*)</ex></p>", '</div>\n<div n="W.W.0" type="ley">\n<head>LEY \\1\\. \\2</head>', texto.todo, perl = T)


texto.todo <- gsub('</p>\n</body>\n</text>', '</p>\n</div>\n</div>\n</body>\n</text>', texto.todo, perl = T) # Añade el div de cierre de la última ley y del título


writeLines(texto.todo, "mediolimpio.txt") # Graba a disco como texto plano
# Numeración de div automatica
texto.revision <- readLines("mediolimpio.txt", encoding = "UTF-8") # Vuelve a leer el texto
# ATENCIÓN número del div de acuerdo con Partida, Título.
div.cuenta <- grep('<div n="W\\.W\\.0" type="ley">', texto.revision) # Localiza los div de ley
# Este bucle cambia el .0 de n con el número adecuado de ley
for (k in 1:length(div.cuenta)){
  texto.revision[div.cuenta[k]] <- sub('W\\.W\\.0', paste('W.W.',as.character(k), sep = ""), texto.revision[div.cuenta[k]])
}

texto.revision <- gsub('\\s{2,10}', " ", texto.revision, perl = T) # Elimina 2 o más espacios en blanco
texto.revision <- gsub('W\\.W\\.', div.tit[a], texto.revision) # Automatizándolo div.tit requeriría [a]
div1 <- which(texto.revision == "</div>") # Elimina el primer div del titulo
texto.revision[div1[1]] <- ""
# ATENCIÓN al nombre del fichero
writeLines(texto.revision, paste("LIMPIO",ficheros[a],sep = "-")) # Graba a disco xml

file.remove("mediolimpio.txt") # Borra fichero intermedio
}
})


