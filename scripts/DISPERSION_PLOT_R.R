setwd("/Users/JMFR/Library/CloudStorage/OneDrive-UVa/_EN_MARCHA/7P_ANALISIS")

# Cada Partida comienza en el elemento 1, 583, 1023, 1829, 2025, 2661 y 3003
# esto se comprueba o bien en los objeto partidas o partidas_minusculas
# Una vez que se ha tokenizado y se ha guardado en partidas_palabras cada
# cada partida comienza en 1, 155538, 312846, 515778, 592428, 687190 y 761350,
# valores recogidos en hitos. Estos último deben ser los puntos en los que se
# marque en el eje horizontal: Primera, Segunda, Tercera, Cuarta, Quinta, Sexta
# y Séptima recogidos en etiquetas que así se pueda ver dónde está cada cambio de partida.

options("scipen" = 100, "digits" = 4)
partidas <- readLines("7P_tagged/tagged_IOC.txt")

# Hitos por Partidas. Hay que añadir el último para que quede mejor el gráfico
hitos_partidas <- c(1, 155538, 312846, 515778, 592481, 687189, 761349, 854772)
etiquetas_partidas <- c('Primera', 'Segunda', 'Tercera', 'Cuarta', 'Quinta', 'Sexta', 'Séptima', '')

# Hitos por cuaderno 4ª exclusivamente
#hitos <- c(1,17826,34327,51028,68247,76703)
#etiquetas <- c("A", "B", "C", "D", "E")

# HITOS PARA HACERLO POR CUADERNOS TOTAL
# Cada línea corresponde a un Título (salvo la tercera que están en dos)
hitos <- c(1, 15482, 33794, 50109, 67853, 84386, 101832, 118986, 135889, 144753,
           155538, 172372, 190530, 210441, 228574, 245395, 262638, 279982, 297772,
           312864, 313633, 330503, 345931, 362218, 3786757, 395236, 411105, 427387, 443762,
           460126, 478318, 494745, 507124,
           515778, 533603, 550104, 566805, 584024,
           592481, 606181, 623298, 640695, 658014, 674770,
           687189, 700025, 716042, 732265, 747448,
           761349, 776351, 791242, 807043, 823118, 834645,
           854772)
# La "" final es para que la gráfica quede más bonita
etiquetas <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "k",
               "m", "n", "o", "p", "q", "r", "s", "t", "u",
               "aa", "bb", "cc", "dd", "ee", "ff", "gg", "hh", "ii", "kk", "mm", "nn", "oo",
               "A", "B", "C", "D", "E",
               "F", "G", "H", "I", "K", "L", "M",
               "AA", "BB", "CC", "DD", "EE",
               "FF", "GG", "HH", "II", "KK", "LL", "")


# Se ejecuta esto para tener el texto en minúsculas, por palabras
# y con una posición siempre fija en cualquier análisis que se haga
# con el fichero tagged_IOC
partidas_minusculas <- tolower(partidas)
partidas_palabras <- strsplit(partidas_minusculas, "\\W")
partidas_palabras <- unlist(partidas_palabras)
no_blanks <- which(partidas_palabras!="")
partidas_palabras <- partidas_palabras[no_blanks]
tiempo.narrativo <- seq(1:length(partidas_palabras))

# Elementos para localizar límites.
#grep("__", partidas_palabras)

# Hacemos la pregunta. Pueden ser una o varias, para más de 2
# crea nuevas variables tercera, cuarta, etc.
primera <- grep("_guerra", partidas_palabras)
segunda <- grep("_ciencia", partidas_palabras)
tercera <- grep("_escolar", partidas_palabras)
cuarta <- grep("_hereje", partidas_palabras)

# Averigua en qué punto se encuentra la respuesta
# a la pregunta. Si se tiene más de dos, se repiten
# los para de órdenes cambiando el número _3, _4 y
# se pone entre los corchetes las variables creadas
# en el paso anterior: tercera, etc.
recuento_1 <- rep(NA, length(tiempo.narrativo))
recuento_1[primera] <- 1

recuento_2 <- rep(NA, length(tiempo.narrativo))
recuento_2[segunda] <- 1

recuento_3 <- rep(NA, length(tiempo.narrativo))
recuento_3[tercera] <- 1

recuento_4 <- rep(NA, length(tiempo.narrativo))
recuento_4[cuarta] <- 1

# Crea una nueva ventana de ploteado y establece que sean
# unos encima de otros 2*1. Si se requiere apilar más de dos
# se incrementa el primer número
par(mfrow = c(4, 1))
# imprime el gráfico de primera / recuento_1
plot(recuento_1,
     main = "GUERRA\n",
     xlab = "",
     type = "h",
     ylab = "",
     ylim = c(0,1),
     axes = FALSE,
     col = "blue")
#axis(1, hitos, etiquetas)
axis(3, hitos_partidas, etiquetas_partidas)
# imprime el gráfico de segunda / recuento_2
plot(recuento_2,
     main = "CIENCIA\n",
     xlab = "",
     type = "h",
     ylab = "",
     ylim = c(0,1),
     axes = FALSE,
     col = "red")
#axis(1, hitos, etiquetas)
axis(3, hitos_partidas, etiquetas_partidas)

# mtext("My Multiplot Title", side = 3, line = -1, outer = TRUE, cex = 3)
# mtext("2023, 7PartidasDigital", side = 1, line = -1, outer = T, col = 'grey')

# No jecutar si no necesitas tres
# imprime el gráfico de tercers / recuento_3
plot(recuento_3,
     main = "ESCOLAR\n",
     type = "h",
     ylab = "",
     ylim = c(0,1),
     axes = FALSE,
     col = "purple")
#axis(1, hitos, etiquetas)
axis(3, hitos_partidas, etiquetas_partidas)

# Si son necesarios más gráficos se repiten cualquiera de
# los dos bloques anteriores y se modifica el dígito de
# recuento_ y se reescribe el literal de main.
plot(recuento_4,
     main = "HEREJE\n",
     xlab = "",
     type = "h",
     ylab = "",
     ylim = c(0,1),
     axes = FALSE,
     col = "maroon")
#axis(1, hitos, etiquetas)
axis(3, hitos_partidas, etiquetas_partidas)
