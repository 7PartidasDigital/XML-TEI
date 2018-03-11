################################# CODIFICA TEI MANUSCRITOS ################################
#               Afina la codificación los fichero Word transformados con TEIOOP5          #
#                 transcritos de acuerdo con las normas para los manuscritos              #
#  Proyecto 7PartidasDigital "Edición crítica digital de las Siete Partidas de Alfonso X" #
#        Proyecto financiado por el MINECO, referencia FFI2016-75014-P AEI-FEDER, EU      #
#                Universidad de Valladolid -- IP José Manuel Fradejas Rueda               #
#                              https://7partidas.hypotheses.org/                          #
#                             https://github.com/7PartidasDigital                         #
#                         Este material se distribuye con una licencia                    #
#                                            MIT                                          #
#                                         v. 1.0.0                                        #

#                                       AVISO / WARNING

#                               EN DESARROLLO / WORKING ON IT

setwd("PON/LA/RUTA/ADECUADA/AQUÍ") # Normalmente
setwd("~/Desktop/trabajo")
# La siguiente instrucción, que encierra todo, es para lanzar automáticamente el proceso
system.time({
  
  ficheros <- list.files() #
  div.tit <- gsub('\\w{3}-', '', ficheros) #ELIMINA EL PREFIJO IDENTIFICATIVO
  div.tit <- gsub("\\.xml", "", div.tit)
  div.tit <- gsub("-", ".", div.tit)
  div.tit <- gsub("\\.0", ".", div.tit)
  div.tit <- paste(div.tit,".", sep="")

  for (a in 1:length(ficheros)){
texto.entrada <- readLines(ficheros[a], encoding = "UTF-8") # Lee el fichero
texto.entrada <- gsub("^\\s+", "", texto.entrada) # Elimina espacios en blanco a comienzo de línea

texto.todo <- paste(texto.entrada, collapse = "") # Crea una única cadena
texto.todo <- gsub('<anchor .*?/>', '', texto.todo, perl = T) #Elimina una etiqueta no desada
texto.todo <- gsub('<p>', '\n<p>', texto.todo, perl = T) # Restituye la estructura y evita cambios de línea extraños

texto.todo <- gsub("©ol\\.", 'col\\.', texto.todo, perl = T) # Por si aparece © en vez de c
texto.todo <- gsub("(\\d+)\\.([r|v])", '\\1\\2', texto.todo, perl = T) # Comprueba que no haya punto tras el número y antes de r o v
texto.todo <- gsub("\\[(c|C|F|f)ol\\.(\\d+)", '\\[\\1ol\\. \\2', texto.todo, perl = T) # Comprueba que hay espacio antes del número de folio o columna
texto.todo <- gsub('(\\d{1,3})\\s+([r|v])', '\\1\\2', texto.todo, perl= T) # Se asegura de que no hay espacio en blanco entre el número de folio y el lado
texto.todo <- gsub("[{|\\[]CW \\.", '{CW\\. ', texto.todo, perl = T) # Se asegura de que las marcas de reclamo comienzan con {
texto.todo <- gsub("[{|\\[]IN", '{IN', texto.todo, perl = T) # Se asegura de que las marcas de inicial comienzan con {
texto.todo <- gsub('\\[</', '\\]</', texto.todo, perl = T) # Se asegura de que no haya corchete de apartura en donde cierre
texto.todo <- gsub('3</p>', '#</p>', texto.todo, perl = T) # Se asegura de que no se ha puesto un 3 por un #
texto.todo <- gsub(' #<hi>', ' <hi>#', texto.todo, perl= T) # Se asegura de que # está dentro del <hi>
texto.todo <- gsub(' -<hi>', ' <hi>-', texto.todo, perl= T) # Se asegura de que - está dentro del <hi>
texto.todo <- gsub('\\.\\.\\.', '…', texto.todo, perl = T) # Convierte tres puntos seguidos en … 
texto.todo <- gsub('\\.{1,2}', '\\.', texto.todo, perl = T) # Se asegura de que no haya dos puntos seguidos
texto.todo <- gsub('\\{IN ', '{IN', texto.todo, perl = T) # Se asegura de que no hay un espacio en blanco tras IN
texto.todo <- gsub("{IN([^\\d+])", '{IN0', texto.todo, perl = T) # Se asegura de que las iniciales tienen un número. En caso negativo añade 0
texto.todo <- gsub('{IN([^\\d+])]', '{IN\\1}', texto.todo, perl = T) # Asegura que {IN acaba en llave }
texto.todo <- gsub('{IN([^\\d+])} ', '{IN\\1}', texto.todo, perl = T) # Asegura que no hay un espacio entre la llave y la letra
texto.todo <- gsub('\\[ ', '\\[', texto.todo, perl = T) # Se asegura de que no hay espacio en blanco tras [
texto.todo <- gsub(' \\]', '\\[', texto.todo, perl = T) # Se asegura de que no hay espacio en blanco antes de ]
texto.todo <- gsub("<p>\\[[f|F]ol\\. (\\d+)([r|v])\\]</p>\n<p>(.+)</p>\n<p>\\[[C|c]ol\\. 1\\]</p>", '<pb n="\\1\\2"/>\n<fw type="encabezado">\\3</fw>\n<cb n="1"/>', texto.todo, perl=T) # Marca los encabezados
texto.todo <- gsub("<p>\\[[f|F]ol\\. (\\d+)([r|v])\\]</p><p>\\[[C|c]ol\\. 1\\]</p>", '<pb n="\\1\\2"/>\n<cb n="1"/>', texto.todo, perl=T) # Si no hay encabezados
texto.todo <- gsub("<p>{CW\\. (.*)}</p>", '<fw type="reclamo">\\1</fw>', texto.todo, perl = T)  # Marca las signatura
texto.todo <- gsub("<p>\\[[f|f]ol\\. (\\w+)\\]</p>", '<pb n="\\1"/>', texto.todo, perl = T) # Marca las folios
texto.todo <- gsub("<p>\\[[c|C]ol\\. (\\w+)\\]</p>", '<cb n="\\1"/>', texto.todo, perl = T) # Marca las columnas
texto.todo <- gsub('</p>\\.\n', '.</p>\n', texto.todo, perl = T) # Se asegura de que el punto no queda al final de línea, tras etiqueta
texto.todo <- gsub('</hi>\\.', '.</hi>', texto.todo, perl = T) # Se asegura de que el punto no queda tras etiqueta
texto.todo <- gsub('mph>', 'x>', texto.todo, perl = T) # Convierte emph en ex para las abreviaturas
texto.todo <- gsub(' <hi>ley</hi></p>',' <hi>ley </hi></p>', texto.todo, perl = T) # Añade un espacio en blanco para leyes en línea
texto.todo <- gsub(' <hi>([L|l])ey (.*)</hi></p>', '</p>\n</div>\n<div n="W.W.0" type="ley">\n<head>\\1ey \\2</head>', texto.todo, perl = T) # Cuando ley comienza en línea con
texto.todo <- gsub('</hi><hi>(.*?)</hi><hi>', '<ex>\\1</ex>', texto.todo, perl = T) # Abreviaturas en rúbricas (1)
texto.todo <- gsub(' <hi>(.*)</hi></p>', ' <seg>\\1</seg>', texto.todo, perl = T) # Trozos de head en segmento
texto.todo <- gsub('#</hi></p>\n<p><hi>', '\n<lb break="no"/>', texto.todo, perl = T) # Rúbricas con más de una línea
texto.todo <- gsub('-</hi></p>\n<p><hi>', '\n<lb break="no" rend="guion"/>', texto.todo, perl = T) # Rúbricas con más de una línea
texto.todo <- gsub('</hi></p>\n<p><hi>', '\n<lb/>', texto.todo, perl = T) # Rúbricas con más de una línea
texto.todo <- gsub('</hi></p>\n<p>{IN(\\w+)}(\\w)', '</head>\n<p><lb/><hi rend="init\\1">\\2</hi>', texto.todo, perl = T) # Fin head e inicial
texto.todo <- gsub('</hi><hi>(.*?)</head>', '<ex>\\1</ex></head>', texto.todo, perl = T) # Abreviaturas en rúbrica (2)
# Esto solo puede ocurrir al comienzo de una ley a causa de la rúbrica encabalgada
texto.todo <- gsub("<p>#", '<lb break="no"/>', texto.todo, perl = T)

# Codifica finales de línea con -, # o normal "limpias"
texto.todo <- gsub("\n<p>#", '\n<lb break="no"/>', texto.todo, perl = T) # Por las rubricas troceadas
texto.todo <- gsub("#</p>\n<p>", '\n<lb break="no"/>', texto.todo, perl = T)
texto.todo <- gsub("-</p>\n<p>", '-\n<lb break="no" rend="guion"/>', texto.todo, perl = T)
texto.todo <- gsub("</p>\n<p>", '\n<lb/>', texto.todo, perl = T)

# Codifica final de línea con -, # o normal en col. 2
texto.todo <- gsub('-</p>\n<cb n="2"/>\n<p>', '-\n<cb n="2"/>\n<lb break="no" rend="guion"/>', texto.todo, perl = T)
texto.todo <- gsub('#</p>\n<cb n="2"/>\n<p>', '\n<cb n="2"/>\n<lb break="no"/>', texto.todo, perl = T)
texto.todo <- gsub('</p>\n<cb n="2"/>\n<p>', '\n<cb n="2"/>\n<lb/>', texto.todo, perl = T)

# Codifica fin de líneas ante fol y col con -, # o normal sin encabezado
texto.todo <- gsub('-</p>\n<pb n="(\\w+)"/>\n<cb n="(\\d)"/>\n<p>', '-\n<pb n="\\1"/>\n<cb n="\\2"/>\n<lb break="no" rend="guion"/>', texto.todo, perl = T) # Final de línea cortada - ante fol y col
texto.todo <- gsub('#</p>\n<pb n="(\\w+)"/>\n<cb n="(\\d)"/>\n<p>', '\n<pb n="\\1"/>\n<cb n="\\2"/>\n<lb break="no"/>', texto.todo, perl = T) # Final de línea cortada # ante fol y col
texto.todo <- gsub('</p>\n<pb n="(\\w+)"/>\n<cb n="(\\d)"/>\n<p>', '\n<pb n="\\1"/>\n<cb n="\\2"/>\n<lb/>', texto.todo, perl = T) # Final de línea ante fol y col

# Codifica fin de líneas con foliación, encabezado y columna
texto.todo <- gsub('-</p>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<cb n="(\\d)"/>\n<p>', '-\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<cb n="\\3"/>\n<lb break="no" rend="guion"/>', texto.todo, perl = T) # Marca fin de línea cortado con guion
texto.todo <- gsub('#</p>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<cb n="(\\d)"/>\n<p>', '-\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<cb n="\\3"/>\n<lb break="no"/>', texto.todo, perl = T) # Marca fin de línea cortado sin guion
texto.todo <- gsub('</p>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<cb n="(\\d)"/>\n<p>', '\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<cb n="\\3"/>\n<lb/>', texto.todo, perl = T) # Marca fin de línea



# Codifica fin de líneas si hay reclamo al final de folio con -, # o normal
texto.todo <- gsub('-</p>\n<fw type="reclamo">(.*)</fw>\n<pb n="(\\w+)"/>\n<cb n="(\\d)"/>\n<p>', '-\n<fw type="reclamo">\\1</fw>\n<pb n="\\2"/>\n<cb n="\\3"/>\n<lb break="no" rend="guion"/>', texto.todo, perl = T)
texto.todo <- gsub('#</p>\n<fw type="reclamo">(.*)</fw>\n<pb n="(\\w+)"/>\n<cb n="(\\d)"/>\n<p>', '\n<fw type="reclamo">\\1</fw>\n<pb n="\\2"/>\n<cb n="\\3"/>\n<lb break="no"/>', texto.todo, perl = T)
texto.todo <- gsub('</p>\n<fw type="reclamo">(.*)</fw>\n<pb n="(\\w+)"/>\n<cb n="(\\d)"/>\n<p>', '\n<fw type="reclamo">\\1</fw>\n<pb n="\\2"/>\n<cb n="\\3"/>\n<lb/>', texto.todo, perl = T)

# Codifica líneas espúreas tras </seg>
texto.todo <- gsub('</seg>\n<p>', '</seg>\n<lb/>', texto.todo, perl = T) # <p> sueltos tras rúbrica segmentada </seg>
texto.todo <- gsub('</seg>\n<cb n="(\\d)"/>\n<p>', '</seg>\n<cb n="\\1"/>\n<lb/>', texto.todo, perl = T)
texto.todo <- gsub('</fw>\n<cb n="(\\d)"/>\n<p>', '</fw>\n<cb n="\\1"/>\n<lb/>', texto.todo, perl = T)

# Falta cuando se complica con encabezado y reclamo

# Problemas varios con Rúbricas
texto.todo <- gsub('\n<lb/><hi>([l|L])ey ', '</p>\n</div>\n<div n="W.W.0" type="ley">\n<head>\\1ey ', texto.todo, perl = T)
texto.todo <- gsub('<head>([l|L])ey </head>\n<p><hi>', '<head>\\1ey\n<lb/>', texto.todo, perl = T)
texto.todo <- gsub('<p>{IN(\\w+)}(\\w)', '<p><lb/><hi rend="init\\1">\\2</hi>', texto.todo, perl = T) # Iniciales absolutas "raras"
texto.todo <- gsub('#</head>\n<p><hi>', '\n<lb break="no"/>', texto.todo, perl = T)
texto.todo <- gsub('-</head>\n<p><hi>', '\n<lb break="no" rend="guion"/>', texto.todo, perl = T)
texto.todo <- gsub('</head>\n<p><hi>', '\n<lb/>', texto.todo, perl = T)
texto.todo <- gsub('</hi><hi>(.*)$', '<ex>\\1</ex>', texto.todo, perl = T) # Abreviaturas en rúbrica

#texto.todo <- gsub('<lb/>{IN(\\w+)}(\\w)', '<p><lb/><hi rend="init\\1">\\2</hi>', texto.todo, perl = T) # Iniciales absolutas "raras"

# Codifica inicio de título
texto.todo <- gsub('<body>\n<p><hi>…', '<body>\n<div n="W.W.0" type="titulo">\n<head>', texto.todo, perl = T) # Inicio div titulo
texto.todo <- gsub('<body>\n<p><hi>', '<body>\n<div n="W.W.0" type="titulo">\n<head><lb/>', texto.todo, perl = T) # Inicio div titulo absoluto

#Codifica final fichero
texto.todo <- gsub('</p></body></text></TEI>', '</p>\n</div>\n</div>\n</body>\n</text>\n</TEI>', texto.todo, perl = T)

# Borrados y añadidos varios
texto.todo <- gsub('·', '<supplied> </supplied>', texto.todo, perl = T) # Añade espacio entre palabras unidas
texto.todo <- gsub('\\+', '<del> </del>', texto.todo, perl = T) # Borra espacio en blanco entre segmentos
texto.todo <- gsub('\\[\\^(.*)\\^\\]', '<add resp="ACLARAR" place="ACLARAR">\\1</add>', texto.todo, perl = T) # Añadido escribas
texto.todo <- gsub('\\(\\^(.*)\\^\\)', '<del resp="ACLARAR" rend="ACLARAR">\\1</del>', texto.todo, perl = T) # borrado escribas
texto.todo <- gsub('…', '<space/>', texto.todo, perl = T) # Hueco dejado por el escriba
texto.todo <- gsub('\\*{3}', '<gap/>', texto.todo, perl = T) # Ilegible, por pérdida, rotura, etc.

# Limpiezas varias
texto.todo <- gsub(' </p>', '</p>', texto.todo, perl = T) # Evita que haya espacios antes de </p>
texto.todo <- gsub(' </head>', '</head>', texto.todo, perl = T) # Evita que haya espacios antes de </head>

# Para TOC de partida. Puede ser diferente de testimonio en testimonio
# HA DE REVISARSE PARA CADA UNO.
texto.todo <- gsub('\n<lb/>{IN(\\d)H}(\\w)', '</item>\n<item><lb/><hi rend="init\\1H">\\2</hi>', texto.todo, perl = T)
texto.todo <- gsub('\n<lb/>% Titulo', '</item>\n<item><lb/>% Titulo', texto.todo, perl = T)

writeLines(texto.todo, "mediolimpio.xml") # Graba a disco como texto plano


# Numeración de div automatica
texto.revision <- readLines("mediolimpio.xml", encoding = "UTF-8") # Vuelve a leer el texto
# ATENCIÓN número del div de acuerdo con Partida, Título.
div.cuenta <- grep('<div n="W.W.0" type="ley">', texto.revision) # Localiza los div de ley
# Este bucle cambia el .0 de n con el número adecuado de ley
for (k in 1:length(div.cuenta)){
  texto.revision[div.cuenta[k]] <- sub('W.W.0', paste('W.W.',as.character(k), sep = ""), texto.revision[div.cuenta[k]])
}
texto.revision <- gsub('%', "% ", texto.revision, perl = T) # Se asegura que tras % hay espacio
texto.revision <- gsub('\\s{2,10}', " ", texto.revision, perl = T) # Elimina 2 o más espacios en blanco
texto.revision <- gsub('^<lb', "\t\t<lb", texto.revision, perl = T) # Sangra <lb
texto.revision <- gsub('^<p>', "\t<p>", texto.revision, perl = T) # Sangra <p>
texto.revision <- gsub('^<head>', "\t<head>", texto.revision, perl = T) # Sangra <head>
#texto.revision <- gsub('>(Partida|Titulo)\\. ', '>\\1 .', texto.revision, perl = T)
texto.revision <- gsub('W.W.', div.tit[a], texto.revision) # Automatizándolo div requeriría [i]
div1 <- which(texto.revision == "</div>") # Elimina el primer div del titulo
texto.revision[div1[1]] <- ""
# ATENCIÓN al nombre del fichero
writeLines(texto.revision, paste("LIMPIO",ficheros[a],sep = "-")) # Graba a disco xml
file.remove("mediolimpio.xml") # Borra fichero intermedio
}
})


