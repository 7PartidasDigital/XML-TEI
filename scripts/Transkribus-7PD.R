################################# Trankribus TEI a 7PD TEI ################################
#                    El fichero de Transkribus se modifica a base de regex                #
#               para eliminar <facsimile>, <zone>, <graphic> y otros elementos            #
#                               de nulo valor para el proyecto.                           #
#                      De eso se encarga la primera parte de este script.                 #
#                Desde oxygen y con regex se marcan las divisiones textuales.             #
#                      Esto ha requirido una revisión «manual» del texto.                 #
#                          La segunda parte del script se encarga de                      #
#             numerar títulos, leyes y folios una vez que han sido limpiados los          #
#                   los ficheros transcritos automáticamente por Transkribus.             #

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

# Primera limpieza

# Esta función limpia el contenido que no interesa
limpia <- function(entrada){
# Borra los espacios a comienzo de línea
lee <- gsub("^\\s+", "", entrada, perl = T)
# Borra las líneas de facsimile, surface, graphic, y zone
lee <- gsub("</?facsimile.*", "", lee, perl = T)
lee <- gsub("</?surface.*", "", lee, perl = T)
lee <- gsub("</?graphic.*", "", lee, perl = T)
lee <- gsub("</?zone.*", "", lee, perl = T)
#Borra los atributos de <pb/>
lee <- gsub("<pb.*/>", "\n<pb/>", lee, perl = T)
# Marca columnas
lee <- gsub("<p facs.*1'", '\n<cb n="1"/', lee, perl = T)
lee <- gsub("<p facs.*2'", '\n<cb n="2"/', lee, perl = T)
#lee <- gsub('<ab facs=.*heading">', '\n<fw type="encabezado">', lee, perl = T)
#lee <- gsub('<ab facs.*_1">', '\n<cb n="1"/>', lee, perl = T)
#lee <- gsub('<ab facs.*_1">', '\n<cb n="1"/', lee, perl = T)
#lee <- gsub('<ab facs.*_2"', '\n<cb n="2"/', lee, perl = T)
# Borra finales de párrafo
lee <- gsub("</p.*", "", lee, perl = T)
#lee <- gsub("</ab>", "", lee, perl = T)
# Borra los atributos de <lb/>
lee <- gsub("<lb facs='#facs.*' n='N\\d+'/>", "<lb/>", lee, perl=T)
# Borra líneas de <p facs que marcan los 
# Borra las líneas que solo tengan tabuladores
lee <- gsub("^\t+$", "", lee, perl = T)
# Borra los elementos vacíos
lee <- lee[lee !=""]
}

# Lee el fichero de entrada
entrada <- readLines("7partidas1491_QuintaPartida.xml")

# Ejecutamos la función para que guarde en limpio lo que hay en entrada
entrada <- limpia(entrada)

# Añade los números de folio
pb <- grep("<pb/>", entrada)
# Puro control, no sirve para nada.
#entrada[pb]

# Hay que tener en cuenta el rangos de folios que se numera,
# por lo que los números de las dos órdenes siguientes se han
# de modificar en consonancia el primer dígito para que coincida
# con el número del primer folio. El margen superior ha de ser
# igual o mayor que le número de folios que tenga el códice.
recto <- c(paste('<pb n="', 44:1000, "r", '"/>', sep = ""))
vuelto <- c(paste('<pb n="', 44:1000, "v", '"/>', sep = ""))
# Une los dos recto y vuelto
folios <- c(recto,vuelto)
# Los ordena por el número correspondiente, de manera
# que la alternacia recto vuelto sea perfecta.
folios <- stringr::str_sort(folios, numeric = T)
# Del enorme folios, solo se quedan con los números que corresponden
# al número de folios que tiene el manuscrito según los ha detectado pb
folios <- folios[1:length(pb)]

# Bucle que renumera los folios
for (i in 1:length(pb)){
  entrada[pb[i]] <- gsub("<pb/>", folios[i], entrada[pb[i]])
}

# Escribe una vez eliminados todo lo anterior
write(entrada, "INTERMEDIO-5a.xml")

# Por medio de reglas de expresión, que no parecen funcionar en oxygen

# BUSCAR: <pb n="(\w+)"/>\n<p facs='#facs.*'>\n<lb/>(.*)\n<lb/>(.*)\n<cb
# REEMPLAZAR: <pb n="\1"/>\n<fw type="encabezado">\2 — \3</fw>\n<cb

#BUSCAR: <pb n="(\w+)"/>\n<p facs='#facs.*'>\n<lb/>(.*?)\n<lb/>(.*?)\n<lb/>(.*?)\n<cb
#REEMPLAZAR: <pb n="\1"/>\n<fw type="encabezado">\2 € \3 — \4</fw>\n<cb


# SEGUNDA PARTE
# Establece un directorio de trabajo donde esté el fichero xml
lee <- readLines("INTERMEDIO-3.xml")
lee <- gsub("^\\s+", "", lee, perl = T) # Borra espacios en blanco al principio de líneas
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
                 paste('<div n="3.',
                       i,
                       '.0" type="titulo" xml:id="SPIDI3',
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
                              paste('<div n="3.',
                                    j,
                                    '.',
                                    k,
                                    '" type="ley" xml:id="SPIDI3',
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
rm(list = ls())
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

# Graba el fichero revisado y totalmente formateado
write(definitivo, "7-3-ini.xml")






# Renumeración de folios por si hay errores
entrada <- readLines("INTERMEDIO.xml")
pb <- grep("<pb/>", entrada)
# Puro control, no sirve para nada.
#entrada[pb]

# Hay que tener en cuenta el rangos de folios que se numera,
# por lo que los números de las dos órdenes siguientes se han
# de modificar en consonancia el primer dígito para que coincida
# con el número del primer folio. El margen superior ha de ser
# igual o mayor que le número de folios que tenga el códice.
recto <- c(paste('<pb n="', 1:1000, "r", '"/>', sep = ""))
vuelto <- c(paste('<pb n="', 1:1000, "v", '"/>', sep = ""))
# Une los dos recto y vuelto
folios <- c(recto,vuelto)
# Los ordena por el número correspondiente, de manera
# que la alternacia recto vuelto sea perfecta.
folios <- stringr::str_sort(folios, numeric = T)
# Del enorme folios, solo se quedan con los números que corresponden
# al número de folios que tiene el manuscrito según los ha detectado pb
folios <- folios[1:length(pb)]

# Bucle que renumera los folios
for (i in 1:length(pb)){
  entrada[pb[i]] <- gsub("<pb/>", folios[i], entrada[pb[i]])
}

writeLines(entrada, "INTERMEDIO-4.xml")


