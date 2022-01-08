################################# DE TEI A HSMS ################################
#                    Modifica los textos etiquetado en TEI como HSMS a base de regex       #


#  Proyecto 7PartidasDigital "Edición crítica digital de las Siete Partidas de Alfonso X" #
#          Proyecto financiado por el MINECO - AEI, referencia PID2020-112621GB-I00       #
#        Proyecto financiado por el MINECO, referencia FFI2016-75014-P AEI-FEDER, EU      #
#                Universidad de Valladolid -- IP José Manuel Fradejas Rueda               #
#                              https://7partidas.hypotheses.org/                          #
#                             https://github.com/7PartidasDigital                         #
#                         Este material se distribuye con una licencia                    #
#                                            MIT                                          #
#                                         v. 1.0.1                                        #

#                                       AVISO / WARNING

#                               EN DESARROLLO / WORKING ON IT

texto <- readLines("SP-VA6.xml") # CÁMBIESE EL FICHERO
#Elimina los blancos a la izquierda
texto <- gsub("^\\s+", "", texto)
# Localiza en qué posición está <body>
body <- grep("<body>", texto)
# Borra todo el teiHeader hasta <body>
texto <- texto[body+1:length(texto)]
# Borra las tres últimas líneas del fichero
texto <- gsub("(</body>)|(</text>)|(</TEI>)", "", texto)
# Borra todos los <fw> (encabezados, pie, signaturas y reclamos) ya que son de nulo interés
texto <- gsub("<fw.*</fw>", "", texto)
#Convierte las marcas de folio
texto <- gsub("<pb n=\"(.*)\"/>", "}\n[fol. \\1]", texto)
# Convierte las marcas de columna
# Aquí hay que tener claro si es a 1 o 2 columnas ya que la etiqueta
# indica el número máximo de columnas
texto <- gsub("<cb n=\".*\"/>", "\n{CB2.", texto) # OJO AL NÚMERO
# Borra <div>
texto <- gsub("</?div.*?>", "", texto)
# Borra NA extraños
texto <- texto[!is.na(texto)]
# Borra elementos en blanco
texto <- texto[texto !=""]
# Une todo en una única líneas
texto <- paste(texto, collapse = " ")
# Cambia <lb> por saltos  de línea
texto <- gsub("<lb.*?/>", "\n", texto)
#CB aislado
texto <- gsub("([\\w>-]) ?\n\\{CB", "\\1}\n{CB", texto)
texto <- gsub("(\\w) ?\n\\{CB", "\\1}\n{CB", texto)
# Borra <del>
texto <- gsub("<del resp=\"copista.*?\">", "(^", texto) # apertura
texto <- gsub("</del>", ")", texto) # cierre
texto <- gsub("<del.*?>", "(", texto) # apertura
texto <- gsub("</del>", ")", texto) # cierre
# Cambia <supplied>
texto <- gsub("<supplied.*?>", "[", texto) # apertura
texto <- gsub("</supplied>", "]", texto) # cierre
# Cambia <add>
texto <- gsub("<add.*?>", "[^", texto) # apertura
texto <- gsub("</add>", "]", texto) # cierre
# Borra <p>
texto <- gsub("</?p>", "", texto)
# Borra <persName>
texto <- gsub("</?persName>", "", texto)
# Borra <placeName>
texto <- gsub("</?placeName>", "", texto)
# Borra <title>
texto <- gsub("</?title>", "", texto)
# <unclear>/<unclear>
texto <- gsub("<unclear>.*?</unclear>", "[??]", texto)
# <unclear/>
texto <- gsub("<unclear/>", "[??]", texto)
# hi de inicial
texto <- gsub("<hi rend=\"init(\\d+)\">", "{IN\\1.}", texto)
# Cualquier otro <hi> se borra sin más
texto <- gsub("</?hi.*?>", "", texto)
# Borra <sic>
texto <- gsub("</?sic>", "", texto)
# Borra amp;
texto <- gsub("&amp;", "&", texto)
# Abreviaturas
texto <- gsub("<ex>", "<", texto)
texto <- gsub("</ex>", ">", texto)
# Solo los que tengan texto
# <gap/>
texto <- gsub("<gap reason=\"[Nn]on[Ss]equitur\"/>", "\n[...]", texto)
texto <- gsub("<gap.*?/>", "[...]", texto)
# Numerales ordinales
texto <- gsub("º", "o`", texto)
texto <- gsub("ª", "a`", texto)
# Borrar <list> e <item> por si hay tablas de contenido
texto <- gsub("(</?item>)|(</?list>)", "", texto)
# Etiqueta rúbricas
# Las que tienen xml:id < 2
texto <- gsub('<seg xml:id="\\w+\\.[23456789]" type="rubrica">(.*?)</seg>',
              '{RUB. \\1}',
              texto)
# Primer segmento de las multilínea
texto <- gsub('<head><seg xml:id="\\w+\\.1" type="rubrica">(.*?)</seg></head>',
              '{RUB. \\1 +}',
              texto)
# Rúbricas sin segmentos
texto <- gsub('<head>(.*?)</head>',
              '{RUB. \\1}',
              texto)
# Añade el + a las rúbricas cortadas al final de línea
texto <- gsub('\\{RUB\\. (.*?)- ?} ?\n',
              '{RUB. \\1- +}\n',
              texto)
# Reúne las palabras cortadas al final de línea en las rúbricas
texto <- gsub('- \\+ ?} ?\n(.*)\\{RUB\\. ([\\w<>]+)',
     '-\\2 +}\n\\1{RUB. ', texto, perl = T)
# Pasajes en otra lengua
texto <- gsub("^}\n\\[", "[", texto)
texto <- gsub("<foreign xml:lang=\"la\">(.*?)</foreign>", "{LAT. \\1}", texto)
texto <- gsub("<foreign xml:lang=\"ar\">(.*?)</foreign>", "{ARB. \\1}", texto)
texto <- gsub("\n}\n\\[fol.", "}\n[fol.", texto)
# Cierra columna final.
texto <- gsub("$", "}", texto)
# Espacio en blanco en rúbricas vacías
texto <- gsub('\\{RUB\\. \\}','{RUB.}', texto)
# Espacio en blanco antes de llave de cierre
texto <- gsub(' +}','}', texto)
# Espacios en blanco de más
texto <- gsub(' {2,10}',' ', texto)
# Arregla palabras partidas a través de columnas
texto <- gsub('- ?} ?\n\\{CB2\\. ?\n([\\w<>]+)\\b', '\\1}\n{CB2.\n', texto, perl = T)
texto <- gsub('- ?\\+?} ?\n\\{CB2\\. ?\n([\\w<>]+)\\b', '-\\1}\n{CB2.\n', texto, perl = T)
texto <- gsub(" \n", "\n", texto)

# Añade RMK del encabezamiento, MODIFÍQUESE ADECUADAMENTE
texto <- c("{RMK: VA6}", "{RMK: Alfonso X, el Sabio}", "{RMK: Siete Partidas}", "{RMK: Valladolid | Real Chancillería | Pergaminos}", "{RMK: José Manuel Fradejas Rueda}", texto)


# Graba el fichero con el formato de nombre de HSMS.app
# Solo hay que cambiar las siglas del fichero
writeLines(texto, "TEXT.SP-VA6.txt")

