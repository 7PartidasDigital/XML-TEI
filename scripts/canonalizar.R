####################################### CANONALIZA ########################################
#          Normaliza gráficamente los ficheros de texto plano para mejorar los            #
#                       análisis estilométricos de los testimonios                        #
#  Proyecto 7PartidasDigital "Edición crítica digital de las Siete Partidas de Alfonso X" #
#        Proyecto financiado por el MINECO, referencia FFI2016-75014-P AEI-FEDER, EU      #
#                Universidad de Valladolid -- IP José Manuel Fradejas Rueda               #
#                              https://7partidas.hypotheses.org/                          #
#                             https://github.com/7PartidasDigital                         #
#                         Este material se distribuye con una licencia                    #
#                                            MIT                                          #
#                                         v. 1.0.0                                        #


library(tidyverse)
prueba <- readLines("~/OneDrive - Universidad de Valladolid/Sp-MN0-1/flat/mn0-1-04.txt")
str_detect(corregido, "\\&")

charta <- function(x){
corregido <- str_replace_all(prueba, "nrr", "nr")
corregido <- str_replace_all(corregido, "mm", "m")
corregido <- str_replace_all(corregido, "n([pb])", "m\\1")
corregido <- str_replace_all(corregido, "nn", "ñ")
corregido <- str_replace_all(corregido, "ñj", "ñi")
corregido <- str_replace_all(corregido, "ñ[^aeiou]", "n")
corregido <- str_replace_all(corregido, "ss", "s")
corregido <- str_replace_all(corregido, "ff", "f")
corregido <- str_replace_all(corregido, "\\&", "e")
corregido <- str_replace_all(corregido, "xpi", "cri")
corregido <- str_replace_all(corregido, "^[ij][h]*e[sr]u", "jesu")
corregido <- str_replace_all(corregido, "ç([ei])", "c\\1")
corregido <- str_replace_all(corregido, "seer", "ser")
corregido <- str_replace_all(corregido, "vn", "un")
corregido <- str_replace_all(corregido, "ff", "f")
corregido <- str_replace_all(corregido, "\\bn([ijo])n\\b", "n\\1")
corregido <- str_replace_all(corregido, "([aeiou])u([aeiou])", "\\1v\\2")
corregido <- str_replace_all(corregido, "([aeiou])lu([aeiou])", "\\1v\\2")
corregido <- str_replace_all(corregido, "([^d][eo])s([cç][ei])", "\\1\\2")
corregido <- str_replace_all(corregido, "([^lu]e)y([^aieou\b])", "\\1i\\2") # Falla con grey, y rey
corregido <- str_replace_all(corregido, "rei\\b", "rey")
corregido <- str_replace_all(corregido, "([aeou])i([aeou])", "\\1j\\2") # No lo tengo claro aún
corregido <- str_replace_all(corregido, "quj", "qui")
corregido <- str_replace_all(corregido, "\\by([^aeiou])", "i\\1")
corregido <- str_replace_all(corregido, "oy([dtrgms])", "oi\\1")
corregido <- str_replace_all(corregido, "sy", "si")
corregido <- str_replace_all(corregido, "cient", "cien")
corregido <- str_replace_all(corregido, "dent", "dende") # cabe la posibilidad de que sea diente, pero...
corregido <- str_replace_all(corregido, "ent", "ente")
}
limpio <- charta(prueba)
limpio[45]

