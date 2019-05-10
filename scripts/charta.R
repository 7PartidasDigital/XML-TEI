#######################################   CHARTA   ########################################
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

charta <- function(x){
corregido <- str_replace_all(prueba, "nrr", "nr")
corregido <- str_replace_all(corregido, "\\bconu[ji]", "convi")
corregido <- str_replace_all(corregido, "([bcdfghlmnpqrstv])y([bcdfghlmnpqrstv])", "\\1i\\2")
corregido <- str_replace_all(corregido, "mm", "m")
corregido <- str_replace_all(corregido, "n([pb])", "m\\1")
corregido <- str_replace_all(corregido, "nn", "ñ")
corregido <- str_replace_all(corregido, "ñj", "ñi")
corregido <- str_replace_all(corregido, "ñ[^aeiou]", "n")
corregido <- str_replace_all(corregido, "ñobl", "nobl")
corregido <- str_replace_all(corregido, "ss", "s")
corregido <- str_replace_all(corregido, "ff", "f")
corregido <- str_replace_all(corregido, "\\&", "e")
corregido <- str_replace_all(corregido, "xpi", "cri")
corregido <- str_replace_all(corregido, "chri", "cri")
corregido <- str_replace_all(corregido, "\\b[ij][h]*e([sr])u", "je\\1u")
corregido <- str_replace_all(corregido, "ç([ei])", "c\\1")
corregido <- str_replace_all(corregido, "seer", "ser")
corregido <- str_replace_all(corregido, "vn", "un")
corregido <- str_replace_all(corregido, "ff", "f")
corregido <- str_replace_all(corregido, " i ", " e ")
corregido <- str_replace_all(corregido, " vs", " us")
corregido <- str_replace_all(corregido, "\\bsalu([aeio])", "salv\\1")
corregido <- str_replace_all(corregido, "cuy([dt])", "cui\\1")
corregido <- str_replace_all(corregido, "ay([bcdfghjklmnpqrst])", "ai\\1")
corregido <- str_replace_all(corregido, "\\bn([ijo])n\\b", "n\\1")
corregido <- str_replace_all(corregido, "([aeiou])u([aeiou])", "\\1v\\2")
corregido <- str_replace_all(corregido, "([aeiou])lu([aeiou])", "\\1v\\2")
corregido <- str_replace_all(corregido, "([^d][eo])s([cç][ei])", "\\1\\2")
corregido <- str_replace_all(corregido, "([^lu]e)y([^aieou\b])", "\\1i\\2") # Falla con grey, y rey
corregido <- str_replace_all(corregido, "rei\\b", "rey")
corregido <- str_replace_all(corregido, "([aeou])i([aeou])", "\\1j\\2") # No lo tengo claro aún
corregido <- str_replace_all(corregido, "([qg])uj", "\\1ui")
corregido <- str_replace_all(corregido, "\\by([^aeiou])", "i\\1")
corregido <- str_replace_all(corregido, "oy([dtrgms])", "oi\\1")
corregido <- str_replace_all(corregido, "sy", "si")
corregido <- str_replace_all(corregido, "cient\\b", "cien")
corregido <- str_replace_all(corregido, "dent\\b", "dende") # cabe la posibilidad de que sea diente, pero...
corregido <- str_replace_all(corregido, "ent\\b", "ente")
corregido <- str_replace_all(corregido, "honr", "onr")
corregido <- str_replace_all(corregido, "\\bnome", "nombre")
corregido <- str_replace_all(corregido, "\\bome", "ombre")
corregido <- str_replace_all(corregido, "\\bhome\\b", "ombre")
corregido <- str_replace_all(corregido, "\\bhomes\\b", "ombres")
corregido <- str_replace_all(corregido, "([ie])ru[ji]", "\\1rvi")
corregido <- str_replace_all(corregido, "\\bujese", "uviese")
corregido <- str_replace_all(corregido, "\\bgran[dt]\\b", "gran")
corregido <- str_replace_all(corregido, "\\bivez", "juez")
corregido <- str_replace_all(corregido, "\\biuyz", "juiz")
corregido <- str_replace_all(corregido, "\\biu[dz]", "juz")
corregido <- str_replace_all(corregido, "gun[dt]\\b", "gun")
corregido <- str_replace_all(corregido, "\\blei\\b", "ley")
corregido <- str_replace_all(corregido, "\\bpley", "plei")
corregido <- str_replace_all(corregido, "\\biamas", "jamas")
corregido <- str_replace_all(corregido, "\\biu", "ju")
corregido <- str_replace_all(corregido, "\\bdesuso\\b", "de suso")
corregido <- str_replace_all(corregido, "\\bdeyuso\\b", "de yuso")
}
