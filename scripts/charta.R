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
entrada <- tolower(entrada)
corregido <- stringr::str_replace_all(entrada, "nrr", "nr")
corregido <- stringr::str_replace_all(corregido, "^\\d+\\.{0,1}.*", "")
corregido <- stringr::str_replace_all(corregido, "\\bconu[ji]", "convi")
corregido <- stringr::str_replace_all(corregido, "([bcdfghlmnpqrstv])y([bcdfghlmnpqrstv])", "\\1i\\2")
corregido <- stringr::str_replace_all(corregido, "mm", "m")
corregido <- stringr::str_replace_all(corregido, "n([pb])", "m\\1")
corregido <- stringr::str_replace_all(corregido, "nn", "ñ")
corregido <- stringr::str_replace_all(corregido, "ñj", "ñi")
corregido <- stringr::str_replace_all(corregido, "ñ[^aeiou]", "n")
corregido <- stringr::str_replace_all(corregido, "ñobl", "nobl")
corregido <- stringr::str_replace_all(corregido, "ss", "s")
corregido <- stringr::str_replace_all(corregido, "ff", "f")
corregido <- stringr::str_replace_all(corregido, "\\&", "e")
corregido <- stringr::str_replace_all(corregido, "xpi", "cri")
corregido <- stringr::str_replace_all(corregido, "chri", "cri")
corregido <- stringr::str_replace_all(corregido, "\\b[ij][h]*e([sr])u", "je\\1u")
corregido <- stringr::str_replace_all(corregido, "ç([ei])", "c\\1")
corregido <- stringr::str_replace_all(corregido, "seer", "ser")
corregido <- stringr::str_replace_all(corregido, "vn", "un")
corregido <- stringr::str_replace_all(corregido, "ff", "f")
corregido <- stringr::str_replace_all(corregido, " i ", " e ")
corregido <- stringr::str_replace_all(corregido, " vs", " us")
corregido <- stringr::str_replace_all(corregido, "\\bsalu([aeio])", "salv\\1")
corregido <- stringr::str_replace_all(corregido, "cuy([dt])", "cui\\1")
corregido <- stringr::str_replace_all(corregido, "ay([bcdfghjklmnpqrst])", "ai\\1")
corregido <- stringr::str_replace_all(corregido, "\\bn([ijo])n\\b", "n\\1")
corregido <- stringr::str_replace_all(corregido, "([aeiou])u([aeiou])", "\\1v\\2")
corregido <- stringr::str_replace_all(corregido, "([aeiou])lu([aeiou])", "\\1v\\2")
corregido <- stringr::str_replace_all(corregido, "([^d][eo])s([cç][ei])", "\\1\\2")
corregido <- stringr::str_replace_all(corregido, "([^lu]e)y([^aieou\\b])", "\\1i\\2") # Falla con grey, y rey
corregido <- stringr::str_replace_all(corregido, "\\bi\\b", "y") # Falla con grey, y rey
corregido <- stringr::str_replace_all(corregido, "rei\\b", "rey")
corregido <- stringr::str_replace_all(corregido, "([aeou])i([aeou])", "\\1j\\2") # No lo tengo claro aún
corregido <- stringr::str_replace_all(corregido, "([qg])uj", "\\1ui")
corregido <- stringr::str_replace_all(corregido, "\\by([^aeiou])", "i\\1")
corregido <- stringr::str_replace_all(corregido, "oy([dtrgms])", "oi\\1")
corregido <- stringr::str_replace_all(corregido, "sy", "si")
corregido <- stringr::str_replace_all(corregido, "cient\\b", "cien")
corregido <- stringr::str_replace_all(corregido, "dent\\b", "dende") # cabe la posibilidad de que sea diente, pero...
corregido <- stringr::str_replace_all(corregido, "ent\\b", "ente")
corregido <- stringr::str_replace_all(corregido, "honr", "onr")
corregido <- stringr::str_replace_all(corregido, "\\bnome", "nombre")
corregido <- stringr::str_replace_all(corregido, "\\bome", "ombre")
corregido <- stringr::str_replace_all(corregido, "\\bhome\\b", "ombre")
corregido <- stringr::str_replace_all(corregido, "\\bhomes\\b", "ombres")
corregido <- stringr::str_replace_all(corregido, "([ie])ru[ji]", "\\1rvi")
corregido <- stringr::str_replace_all(corregido, "\\bujese", "uviese")
corregido <- stringr::str_replace_all(corregido, "\\bgran[dt]\\b", "gran")
corregido <- stringr::str_replace_all(corregido, "\\bivez", "juez")
corregido <- stringr::str_replace_all(corregido, "\\biuyz", "juiz")
corregido <- stringr::str_replace_all(corregido, "\\biu[dz]", "juz")
corregido <- stringr::str_replace_all(corregido, "gun[dt]\\b", "gun")
corregido <- stringr::str_replace_all(corregido, "\\blei\\b", "ley")
corregido <- stringr::str_replace_all(corregido, "\\bpley", "plei")
corregido <- stringr::str_replace_all(corregido, "\\biamas", "jamas")
corregido <- stringr::str_replace_all(corregido, "\\biu", "ju")
corregido <- stringr::str_replace_all(corregido, "\\bdesuso\\b", "de suso")
corregido <- stringr::str_replace_all(corregido, "\\bdeyuso\\b", "de yuso")
corregido <- stringr::str_replace_all(corregido, "\\.[ijvxlc]+\\.", "")
corregido <- corregido[corregido !=""]
}
