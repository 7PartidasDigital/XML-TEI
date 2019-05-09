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
LOP_entrada <- tolower(readLines("lopez.txt"))
IOC_entrada <- tolower(readLines("montalvo.txt"))



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
corregido <- str_replace_all(corregido, "chri", "cri")
corregido <- str_replace_all(corregido, "\\b[ij][h]*e([sr])u", "je\\1u")
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
corregido <- str_replace_all(corregido, "cient\\b", "cien")
corregido <- str_replace_all(corregido, "dent\\b", "dende") # cabe la posibilidad de que sea diente, pero...
corregido <- str_replace_all(corregido, "ent\\b", "ente")
corregido <- str_replace_all(corregido, "honr", "onr")
corregido <- str_replace_all(corregido, "\\bnome", "nombre")
corregido <- str_replace_all(corregido, "\\bome", "ombre")
corregido <- str_replace_all(corregido, "\\bivez", "juez")
corregido <- str_replace_all(corregido, "\\biuyz", "juiz")
corregido <- str_replace_all(corregido, "\\biu[dz]", "juz")
corregido <- str_replace_all(corregido, "gun[dt]\\b", "gun")
corregido <- str_replace_all(corregido, "\\blei\\b", "ley")
corregido <- str_replace_all(corregido, "\\bpley", "plei")
#corregido <- str_replace_all(corregido, "\\bh", "")
corregido <- str_replace_all(corregido, "\\biamas", "jamas")
#corregido <- str_extract_all(corregido, "\\bu([aeiou])", "v\\1")
corregido <- str_replace_all(corregido, "\\biu", "ju")
}

prueba <- IOC_entrada
limpio <- charta(prueba)


writeLines(limpio, "montalvo_reg.txt")
#EN IOC
#limpio <- str_replace_all(limpio, "\\bf([ai])z", "\\1z")
limpio <- str_replace_all(limpio, "\\bgaña", "gana")
limpio <- str_replace_all(limpio, "\\bu([aeiou])", "v\\1")
limpio <- str_replace_all(limpio, "\\bveste", "ueste")
limpio <- str_replace_all(limpio, "\\bverta", "uerta")



IOC <- tibble(texto = limpio)

prueba <- LOP_entrada
limpio <- charta(prueba)

LOP <- tibble(texto = limpio)

IOC <- IOC %>%
  filter(!str_detect(texto, "^\\d+.*"))
LOP <- LOP %>%
  filter(!str_detect(texto, "^\\d+.*"))
LOP$texto <- gsub(" folio \\.\\d+\\.$", "", LOP$texto) # BORRA FOL. NUM DE LOPEZ



#rm(prueba)

IOC_palabras <- IOC %>%
  tidytext::unnest_tokens(palabra, texto) %>%
  count(palabra, sort = T)
LOP_palabras <- LOP %>%
  tidytext::unnest_tokens(palabra, texto) %>%
  count(palabra, sort = T)

resto <- anti_join(IOC_palabras, LOP_palabras, by="palabra")
