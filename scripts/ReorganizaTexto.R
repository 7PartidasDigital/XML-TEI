#################################### REORGANIZA TEXTO #####################################
#         Redistribuye las palabras aleatoriamente para prueba de estilomtería            #

#  Proyecto 7PartidasDigital "Edición crítica digital de las Siete Partidas de Alfonso X" #
#        Proyecto financiado por el MINECO, referencia FFI2016-75014-P AEI-FEDER, EU      #
#                Universidad de Valladolid -- IP José Manuel Fradejas Rueda               #
#                              https://7partidas.hypotheses.org/                          #
#                             https://github.com/7PartidasDigital                         #
#                         Este material se distribuye con una licencia                    #
#                                            MIT                                          #
#                                         v. 1.0.0                                        #
# Ojo al directorio de trabajo y nombres de fichero de entrada y salida
nombres.ficheros <- list.files(pattern = "*.txt")
for (i in 1:length(nombres.ficheros)){
  texto.entrada <- readLines(nombres.ficheros[i], encoding = "UTF-8")
  texto.palabras <- strsplit(texto.entrada, " ")
  texto.palabras <- unlist(texto.palabras)
  texto.nuevo <- paste(sample(texto.palabras), collapse = " ")
  writeLines(texto.nuevo, paste("../ramdom/alea-", nombres.ficheros[i], sep = ""))
}
