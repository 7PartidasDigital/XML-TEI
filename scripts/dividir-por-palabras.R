################################## DIVIDE POR PALABRAS #####################################
#            Fragmenta en porciones de una extensión determinada los textos               #
#     transcritos de acuerdo con las normas para impresos del siglo XVI del proyecto      #
#  Proyecto 7PartidasDigital "Edición crítica digital de las Siete Partidas de Alfonso X" #
#        Proyecto financiado por el MINECO, referencia FFI2016-75014-P AEI-FEDER, EU      #
#                Universidad de Valladolid -- IP José Manuel Fradejas Rueda               #
#                              https://7partidas.hypotheses.org/                          #
#                             https://github.com/7PartidasDigital                         #
#                         Este material se distribuye con una licencia                    #
#                                            MIT                                          #
#                                         v. 0.0.1                                        #
# Atención a los nombre de los ficheros de entrada y salida
setwd("ESTABLECE/DIRECTORIO/TRABAJO")
texto.entrada <- readLines("../TRATADO.txt", encoding = "UTF-8")
texto.todo <- paste(texto.entrada, collapse = " ")
palabras <- strsplit(texto.todo, " ")
texto.palabras <- palabras[[1]]
chunks <- split(texto.palabras, ceiling(seq_along(texto.palabras)/1000))
for (i in 1:length(chunks)){
  fragmento <- chunks[i]
  fragmento.unido <- paste(unlist(fragmento), collapse = " ")
  writeLines(fragmento.unido, paste("tra_",i,".txt"), sep="")
}
