#######################################  LOCALIZA  ########################################
#                    Localiza formas en los ficheros de texto y tablas                    #

#  Proyecto 7PartidasDigital "Edición crítica digital de las Siete Partidas de Alfonso X" #
#        Proyecto financiado por el MINECO, referencia FFI2016-75014-P AEI-FEDER, EU      #
#                Universidad de Valladolid -- IP José Manuel Fradejas Rueda               #
#                              https://7partidas.hypotheses.org/                          #
#                             https://github.com/7PartidasDigital                         #
#                         Este material se distribuye con una licencia                    #
#                                            MIT                                          #
#                                         v. 1.0.0                                        #


library(tidyverse)

entrada <- readxl::read_xlsx("~/OneDrive - Universidad de Valladolid/OSTA-frecuencias.xlsx", col_names = c("palabra", "n"))

# LEE LOS FICHEROS DE TEXTO 7P Y LOS TOKENINZA
entrada <- tibble(texto = read_lines("~/OneDrive - Universidad de Valladolid/SP-IOC_FLAT/corpus/SP_IOC-1.txt"))
entrada <- entrada %>%
  filter(!str_detect(texto, "^\\d+.*"))
entrada$texto <- gsub(" folio \\.\\d+\\.$", "", entrada$texto) # BORRA FOO. NUM DE LOPEZ
entrada$texto <- gsub("\\&", "e", entrada$texto) # SUSTITUYE LA NOTA TIRONIANA POR E
subentrada <- entrada
entrada <- subentrada %>%
  tidytext::unnest_tokens(palabra, texto) %>%
  count(palabra, sort = T)



# Borra la puntuación NO SI LO HE DIVIDO YO
entrada <- entrada %>%
  filter(!str_detect(palabra, "[[:punct:]]"))

sum(entrada$n)
summary(entrada$n)

# Localiza la secuencia deseada por medio de RegEx
BUSQUEDA <- entrada %>%
  filter(str_detect(palabra, "abrahan\\b"))

sum(BUSQUEDA$n)
