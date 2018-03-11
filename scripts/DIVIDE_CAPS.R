################################# DIVIDE EN SUBFICHEROS ###################################
#                              Divide ficheros en texto plano                             #
#     transcritos de acuerdo con las normas para impresos del siglo XVI del proyecto      #
#  Proyecto 7PartidasDigital "Edición crítica digital de las Siete Partidas de Alfonso X" #
#        Proyecto financiado por el MINECO, referencia FFI2016-75014-P AEI-FEDER, EU      #
#                Universidad de Valladolid -- IP José Manuel Fradejas Rueda               #
#                              https://7partidas.hypotheses.org/                          #
#                             https://github.com/7PartidasDigital                         #
#                         Este material se distribuye con una licencia                    #
#                                            MIT                                          #
#                                         v. 0.0.1                                        #
# Atención a los nombres de los ficheros de entrada y salida
setwd("PON/DIRECTORIO/TRABAJO") # Selecciona el directorio
rm(list = ls()) # Limpia el entorno
texto <- readLines("mediolimpio.txt", encoding = "UTF-8") # Lee un fichero
posicion_capitulo <- grep("^Titulo", texto) # Localiza donde comienza cada capítulo
texto <- c(texto,"FIN") # añade una marca para marcar fin del texto, pero no la grabará
ultima_posicion <- length(texto) # averigua la nueva última posición
posicion_capitulo <- c(posicion_capitulo, ultima_posicion) # añade la última posición al fichero
# Extrae y graba todos los capítulos salvo el último
for(x in 1:length(posicion_capitulo)){
  if(x != length(posicion_capitulo)){
inicio <- posicion_capitulo[x]
fin <- posicion_capitulo[x+1]-1
  capitulo <- texto[inicio:fin]
   write(capitulo, paste(file="1P", "-", formatC(x, width = 2, flag = 0), ".txt", sep = ""))
  }
}
# Aquí podría incluir una rutina que hiciera los cálculos de cada libro / capítulo
# pero no se ejecutaría la anterior


