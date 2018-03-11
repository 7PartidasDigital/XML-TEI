###################################### LIMPIA TEI #########################################
#          Elimina la codificación TEI y convierte los ficheros en texto plano            #
#     transcritos de acuerdo con las normas para impresos del siglo XVI del proyecto      #
#  Proyecto 7PartidasDigital "Edición crítica digital de las Siete Partidas de Alfonso X" #
#        Proyecto financiado por el MINECO, referencia FFI2016-75014-P AEI-FEDER, EU      #
#                Universidad de Valladolid -- IP José Manuel Fradejas Rueda               #
#                              https://7partidas.hypotheses.org/                          #
#                             https://github.com/7PartidasDigital                         #
#                         Este material se distribuye con una licencia                    #
#                                            MIT                                          #
#                                         v. 1.0.0                                        #
setwd("PON/DIRECTORIO/TRABAJO")
texto.entrada <- readLines("PRIMERA.xml", encoding = "UTF-8") # Ojo al fichero
texto.entrada <- gsub("^\\s+", "", texto.entrada) # Elimina espacios en blanco a comienzo de línea
texto.todo <- paste(texto.entrada, collapse = " ") # Crea una única cadena
texto.todo <- gsub(" <p>", "\n", texto.todo) # Busca inicios de párrafo y los trueca en nueva línea.
texto.todo <- gsub(" <head>", "\n", texto.todo) # Busca títulos y los trueca en nueva línea.
texto.todo <- gsub(" <div", "\n<div", texto.todo) # Busca divs y los trueca en nueva línea.
texto.todo <- gsub(" <fw.*?</fw>", "", texto.todo) # Elimina información de encabezados, signaturas, foliaciones
texto.todo <- gsub(" <[p|c]b.*?/>", "", texto.todo) # Elimina marcas de folio y columna
texto.todo <- gsub("- <lb break=\"no\" rend=\"guion\"/>", "", texto.todo) #Junta líneas cortadas con guion
texto.todo <- gsub(" <lb break=\"no\"/>", "", texto.todo) #Junta líneas cortadas sin guion
texto.todo <- gsub(" <lb/>", " ", texto.todo) #Junta líneas 
texto.todo <- gsub("<[^<>]+>", "", texto.todo) # Elimina todo el resto del etiquetado OJO en mss. ampliar
texto.todo <- gsub("&amp;", "e", texto.todo) # Cambia tironiana por conjunción
texto.todo <- gsub("% ", "", texto.todo) # Elemina calderones
writeLines(texto.todo, "mediolimpio.txt") # Graba a disco
