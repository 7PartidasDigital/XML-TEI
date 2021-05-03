################################# Trankribus TEI a 7PD TEI ################################
#              Numera títulos, leyes y folios una vez que han sido limpiados los          #
#                  los ficheros transcritos automárticamente por Transkribus              #
#                 El fichero de Transkribus ha sido modificado a base de regex            #
#                     para eliminar <facsimile>, <zone> y otros elementos                 #
#                         de escaso o nulo valor para el proyecto.                        #
#                 También se han marcado con regex las divisiones textuales,              #
#                      Esto ha requirido una revisión «manual» del texto.                 #

#  Proyecto 7PartidasDigital "Edición crítica digital de las Siete Partidas de Alfonso X" #
#        Proyecto financiado por el MINECO, referencia FFI2016-75014-P AEI-FEDER, EU      #
#                Universidad de Valladolid -- IP José Manuel Fradejas Rueda               #
#                              https://7partidas.hypotheses.org/                          #
#                             https://github.com/7PartidasDigital                         #
#                         Este material se distribuye con una licencia                    #
#                                            MIT                                          #
#                                         v. 1.0.1                                        #

#                                       AVISO / WARNING

#                               EN DESARROLLO / WORKING ON IT

# Establece un directorio de trabajo donde esté el fichero xml
lee <- readLines("7-ICI-1.xml")
lee <- c(lee, '<div type="titulo">') # Ojo es una tomadura
# Averigua en que posiciones comienza cada título
titulos <- grep('<div type="titulo">', lee)
# Crea una copia en la que 
nuevo <- lee[1:titulos[1]-1]
nuevo <- gsub("^<lb", "\t\t<lb", nuevo, perl = T)
nuevo <- gsub("^<p>", "\t<p>", nuevo, perl = T)
nuevo <- gsub("^<hea", "\t<hea", nuevo, perl = T)

# Numera e introduce xml:id de los títulos
for (i in 1:length(titulos)){
  lee[titulos[i]] <- gsub('<div type="titulo">',
                 paste('<div n="1.',
                       i,
                       '.0" type="titulo" xml:id="SPIDI1',
                       stringr::str_pad(i, 2, pad = 0),
                       '000">',
                       sep = ""),
                 lee[titulos[i]],
                 perl = T)
}
# Numera e introduce xml:id de las leyes por título
# graba una copia en disco duro por cada título
for(i in 1:length(titulos)){
for(j in 1:length(titulos)){
  if(j < length(titulos)){
    inicio <- titulos[j]
    fin <- titulos[j+1]-1
    titulo <- lee[inicio:fin]
    leyes <- grep('<div type="ley">', titulo)
    for (k in 1:length(leyes)){
      titulo[leyes[k]] <- gsub('<div type="ley">',
                              paste('<div n="1.',
                                    j,
                                    '.',
                                    k,
                                    '" type="ley" xml:id="SPIDI1',
                                    stringr::str_pad(j, 2, pad = 0),
                                    stringr::str_pad(k, 3, pad = 0),
                                    '">',
                                    sep = ""),
                              titulo[leyes[k]],
                              perl = T)
      titulo <- gsub("^<lb", "\t\t<lb", titulo, perl = T)
      titulo <- gsub("^<p>", "\t<p>", titulo, perl = T)
      titulo <- gsub("^<hea", "\t<hea", titulo, perl = T)
      write(titulo,
            paste("titulo_", stringr::str_pad(j, 2, pad = 0), ".txt", sep = ""))
    }
  }
}
}


write(nuevo, "titulo_00.txt")
# Carga los ficheros intermedios 
ficheros <- list.files(pattern = "*.txt")
# Regenera el fichero completo
definitivo <- NULL
for (i in 1:length(ficheros)){
  entrada <- readLines(ficheros[i])
  definitivo <- c(definitivo, entrada)
}
# Una vez reconstruidos el fichero xml se borran los intermedios
file.remove(ficheros)
# Numera los folios
# Localiza dónde se encuentra los <pb/>
pb <- grep("<pb/>", definitivo)
# Puro control, no sirve de casi nada.
definitivo[pb]
# Hay que tener en cuenta el rangos de folios que se numera
recto <- c(paste('<pb n="', 1:86, "r", '"/>', sep = ""))
vuelto <- c(paste('<pb n="', 1:86, "v", '"/>', sep = ""))
folios <- c(recto,vuelto)
folios <- stringr::str_sort(folios, numeric = T)
# Blucle que renumera los folios
for (i in 1:length(pb)){
  definitivo[pb[i]] <- gsub("<pb/>", folios[i], definitivo[pb[i]])
}

# Graba el fichero revisado y totalmente formateado
write(definitivo, "7-1-ini.xml")
