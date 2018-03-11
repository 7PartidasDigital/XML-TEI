###################################### CODIFICA TEI #######################################
#          Afina la codificación los fichero Word transformados con TEIOOP5               #
#     transcritos de acuerdo con las normas para impresos del siglo XVI del proyecto      #
#  Proyecto 7PartidasDigital "Edición crítica digital de las Siete Partidas de Alfonso X" #
#        Proyecto financiado por el MINECO, referencia FFI2016-75014-P AEI-FEDER, EU      #
#                Universidad de Valladolid -- IP José Manuel Fradejas Rueda               #
#                              https://7partidas.hypotheses.org/                          #
#                             https://github.com/7PartidasDigital                         #
#                         Este material se distribuye con una licencia                    #
#                                            MIT                                          #
#                                         v. 1.0.4                                        #


setwd("PON/LA/RUTA/ADECUADA/AQUÍ")
# La siguiente instrucción, que cierra todo, es para lanzar automáticamente el proceso
system.time({
ficheros <- list.files()
div.tit <- gsub("SP-LO55-", "", ficheros)
div.tit <- gsub("\\.xml", "", div.tit)
div.tit <- gsub("-", ".", div.tit)
div.tit <- gsub("\\.0", ".", div.tit)
div.tit <- paste(div.tit,".", sep="")
for (a in 1:length(ficheros)){
texto.entrada <- readLines(ficheros[a], encoding = "UTF-8") # Poner el nombre adecuado
texto.entrada <- gsub("^\\s+", "", texto.entrada) # Elimina espacios en blanco a comienzo de línea
texto.todo <- paste(texto.entrada, collapse = "\n") # Crea una única cadena
texto.todo <- gsub("©ol\\.", 'col\\.', texto.todo, perl = T) # Por si aparece © en vez de c
texto.todo <- gsub("(\\d+)\\.([r|v])", '\\1\\2', texto.todo, perl = T) # Comprueba que no hay punto tras el número y antes de r o v
texto.todo <- gsub("\\[(c|C|F|f)ol\\.(\\d+)", '\\[\\1ol\\. \\2', texto.todo, perl = T) # Comprueba que hay espacio antes del número de folio o columna
texto.todo <- gsub('(\\d{1,3})\\s+([r|v])', '\\1\\2', texto.todo, perl= T) # Se asegura de que no hay espacio en blanco entre el número de folio y el lado
texto.todo <- gsub("[{|\\[]CW \\.", '{CW\\. ', texto.todo, perl = T) # Se asegura de que las marcas de reclamo comienzan con {
texto.todo <- gsub("[{|\\[]IN", '{IN', texto.todo, perl = T) # Se asegura de que las marcas de inicial comienzan con {
texto.todo <- gsub('\\[</', '\\]</', texto.todo, perl = T) # Se asegura que no haya corchete de apartero en donde cierre
texto.todo <- gsub('3\n', '#\n', texto.todo, perl = T) # Se asegura que no se ha puesto un 3 por un #
texto.todo <- gsub('\\.{1,5}', '\\.', texto.todo, perl = T) # Se asegura de que no haya dos puntos seguidos
texto.todo <- gsub('% Titulo. ', '% Titulo .', texto.todo, perl = T) # Se asegura que el punto está pegado al número romano del título
texto.todo <- gsub('% Ley. ', '% Ley .', texto.todo, perl = T) # Se asegura que el punto está pegado al número romano de la ley
texto.todo <- gsub('\\{IN ', '{IN', texto.todo, perl = T) # Se asegura de que no hay un espacio en blanco tras IN
texto.todo <- gsub("[{|\\[]IN([^\\d][[:upper:]]+)", '{IN0\\1', texto.todo, perl = T) # Se asegura de que las iniciales tienen un número. En caso negativo añade 0
texto.todo <- gsub('\\[ ', '\\[', texto.todo, perl = T) # Se asegura de que no hay espacio en blanco tras [
texto.todo <- gsub(' \\]', '\\[', texto.todo, perl = T) # Se asegura de que no hay espacio en blanco antes de ]
texto.todo <- gsub("<p>\\[[f|F]ol\\. (\\d+)([r|v])\\]</p>\n<p>(.+)</p>\n<p>\\[[C|c]ol\\. 1\\]</p>", '<pb n="\\1\\2"/>\n<fw type="encabezado">\\3</fw>\n<cb n="1"/>', texto.todo, perl=T) # Marca los encabezados
texto.todo <- gsub(" (\\d+)</fw>", '</fw>\n<fw type="foliacion">\\1</fw>', texto.todo, perl=T)  # Marca las folicaciones
texto.todo <- gsub("<p>{CW\\. (.+)}</p>", '<fw type="signatura">\\1</fw>', texto.todo, perl = T)  # Marca las signatura
texto.todo <- gsub("<p>\\[[c|C]ol\\. (\\w+)\\]</p>", '<cb n="\\1"/>', texto.todo, perl = T) # Marca las columnas
texto.todo <- gsub('</p>\\.\n', '.</p>\n', texto.todo, perl = T) # Se asegura que el punto no queda al final de línea, tras etiqueta
texto.todo <- gsub('</hi>\\.\n', '.</hi>\n', texto.todo, perl = T) # Se asegura que el punto no queda al final de línea, tras etiqueta
texto.todo <- gsub("mph>", 'x>', texto.todo, perl = T) # Convierte emph en ex para las abreviaturas
texto.todo <- gsub("</hi>\n</p>\n<p>{IN(\\d+)(\\w)", '</head>\n<p><lb/><hi rend="init\\1">\\2</hi>', texto.todo, perl = T) # Cierra <head>, abre <p> y marca iniciales
texto.todo <- gsub('</p>\n<p>\n<hi>%', '</p>\n</div>\n<div n="W.W.0" type="ley">\n<head><lb/>%', texto.todo, perl = T) # Delimita <div>
texto.todo <- gsub("</hi>\n<hi>(\\w+)</hi>\n<hi>", '<ex>\\1</ex>', texto.todo, perl = T) # Solventa problemas de abreviaturas en <head>
texto.todo <- gsub("</hi>\n</p>\n<p>\n<hi>", '</p>\n<p>', texto.todo, perl = T) # Solventa problemas de abreviaturas en <head>
texto.todo <- gsub("\n</p>", '</p>', texto.todo, perl = T) # Agrupa </p> aislados en una línea
texto.todo <- gsub("-</p>\n<p>", '-\n<lb break="no" rend="guion"/>', texto.todo, perl = T) # Marca fin de línea cortado con guion
texto.todo <- gsub("#</p>\n<p>", '-\n<lb break="no"/>', texto.todo, perl = T)  # Marca fin de línea cortado sin guion
texto.todo <- gsub("</p>\n<p>", '\n<lb/>', texto.todo, perl = T) # Marca fin de línea
texto.todo <- gsub('-</p>\n<cb n="2"/>\n<p>', '-\n<cb n="2"/>\n<lb break="no" rend="guion"/>', texto.todo, perl = T) # Marca fin de línea cortado con guion
texto.todo <- gsub('#</p>\n<cb n="2"/>\n<p>', '-\n<cb n="2"/>\n<lb break="no"/>', texto.todo, perl = T) # Marca fin de línea cortado sin guion
texto.todo <- gsub('</p>\n<cb n="2"/>\n<p>', '\n<cb n="2"/>\n<lb/>', texto.todo, perl = T) # Marca fin de línea
texto.todo <- gsub('-</p>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<fw type="foliacion">(\\d+)</fw>\n<cb n="1"/>\n<p>', '-\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<fw type="foliacion">\\3</fw>\n<cb n="1"/>\n<lb break="no" rend="guion"/>', texto.todo, perl = T) # Marca fin de línea cortado con guion
texto.todo <- gsub('#</p>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<fw type="foliacion">(\\d+)</fw>\n<cb n="1"/>\n<p>', '-\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<fw type="foliacion">\\3</fw>\n<cb n="1"/>\n<lb break="no"/>', texto.todo, perl = T) # Marca fin de línea cortado sin guion
texto.todo <- gsub('</p>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<fw type="foliacion">(\\d+)</fw>\n<cb n="1"/>\n<p>', '\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<fw type="foliacion">\\3</fw>\n<cb n="1"/>\n<lb/>', texto.todo, perl = T) # Marca fin de línea
texto.todo <- gsub('-</p>\n<fw type="signatura">(.*)</fw>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<cb n="1"/>\n<p>', '-\n<fw type="signatura">\\1</fw>\n<pb n="\\2"/>\n<fw type="encabezado">\\3</fw>\n<cb n="1"/>\n<lb break="no" rend="guion"/>', texto.todo, perl = T) # Marca fin de línea cortado con guion
texto.todo <- gsub('#</p>\n<fw type="signatura">(.*)</fw>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<cb n="1"/>\n<p>', '-\n<fw type="signatura">\\1</fw>\n<pb n="\\2"/>\n<fw type="encabezado">\\3</fw>\n<cb n="1"/>\n<lb break="no"/>', texto.todo, perl = T) # Marca fin de línea cortado sin guion
texto.todo <- gsub('</p>\n<fw type="signatura">(.*)</fw>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<cb n="1"/>\n<p>', '\n<fw type="signatura">\\1</fw>\n<pb n="\\2"/>\n<fw type="encabezado">\\3</fw>\n<cb n="1"/>\n<lb/>', texto.todo, perl = T) # Marca fin de línea
texto.todo <- gsub('-</p>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<cb n="1"/>\n<p>', '-\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<cb n="1"/>\n<lb break="no" rend="guion"/>', texto.todo, perl = T) # Marca fin de línea cortado con guion
texto.todo <- gsub('#</p>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<cb n="1"/>\n<p>', '-\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<cb n="1"/>\n<lb break="no"/>', texto.todo, perl = T) # Marca fin de línea cortado sin guion
texto.todo <- gsub('</p>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<cb n="1"/>\n<p>', '\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<cb n="1"/>\n<lb/>', texto.todo, perl = T) # Marca fin de línea
texto.todo <- gsub('\\.</hi>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*)</fw>\n<fw type="foliacion">(\\d+)</fw>\n<cb n="1"/>\n<lb/>\\{IN(\\d+)(\\w)', '\\.</head>\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<fw type="foliacion">\\3</fw>\n<cb n="1"/>\n<p><lb/><hi rend="init\\4">\\5</hi>', texto.todo, perl = T) # Marca fin de línea
texto.todo <- gsub('-</hi>\n<cb n="2"/>\n<lb/>\n<hi>', '-\n<cb n="2"/>\n<lb break="no" rend="guion"/>', texto.todo, perl = T) # Solucionan <head> partido
texto.todo <- gsub('#</hi>\n<cb n="2"/>\n<lb/>\n<hi>', '-\n<cb n="2"/>\n<lb break="no"/>', texto.todo, perl = T) # Soluciona <head> partido
texto.todo <- gsub('</hi>\n<cb n="2"/>\n<lb/>\\{IN(\\d+)(\\w)', '</head>\n<cb n="2"/>\n<p><lb/><hi rend="init\\1">\\2</hi>', texto.todo, perl = T) # Soluciona <head> partido
texto.todo <- gsub(' </p>', '</p>', texto.todo, perl = T) # Evita que haya espacios antes de </p>
texto.todo <- gsub(' </head>', '</head>', texto.todo, perl = T) # Evita que haya espacios antes de </head>
texto.todo <- gsub('</hi>\\.</p>','.</head>', texto.todo, perl = T) # Evita una combinación rara </hi>.</p> que ha de ser .</head>
texto.todo <- gsub('</hi>\\.','.</head>', texto.todo, perl = T) # Evita una combinación rara </hi>. que ha de ser .</head>
texto.todo <- gsub('</p>\n</body>\n</text>', '</p>\n</div>\n</div>\n</body>\n</text>', texto.todo, perl = T) # Añade el div de cierre de la última ley y del título
texto.todo <- gsub('<lb/>\n<hi>%', '<!-- OJO -->\n</p>\n</div>\n<div n="W.W.0" type="ley">\n<head><lb/>%', texto.todo, perl = T) # Añade el div de cierre de la última ley y del título
texto.todo <- gsub('</hi></p>', '</hi>', texto.todo, perl = T)
texto.todo <- gsub('<text>\n<body>\n<p>\n<hi>%', '<text>\n<body>\n<p>\n<div n="W.W.0" type="titulo">\n<head><lb/>%', texto.todo, perl = T) # Etiqueta el div de titulo
texto.todo <- gsub('<p>\n<hi>% Titulo', '<div n="W.W.0" type="titulo">\n<head><lb/>% Titulo', texto.todo, perl = T)
texto.todo <- gsub('<p>\n<hi>Titulo', '<div n="W.W.0" type="titulo">\n<head><lb/>% Titulo', texto.todo, perl = T)
texto.todo <- gsub('</hi>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*?)</fw>\n<cb n="1"/>\n<lb/>\\{IN(\\d+)(\\w)', '</head>\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<cb n="1"/>\n<lb/><hi rend="init\\3">\\4</hi>', texto.todo, perl = T)
texto.todo <- gsub('</hi>\n<fw type="signatura">(.*?)</fw>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*?)</fw>\n<cb n="1"/>\n<lb/>\\{IN(\\d+)(\\w)', '</head>\n<fw type="signatura">\\1</fw>\n<pb n="\\2"/>\n<fw type="encabezado">\\3</fw>\n<cb n="1"/>\n<lb/><hi rend="init\\4">\\5</hi>', texto.todo, perl = T)
texto.todo <- gsub('</hi>\n<pb n="(\\w+)"/>\n<fw type="encabezado">(.*?)</fw>\n<fw type="foliacion">(\\d+)</fw>\n<cb n="1"/>\n<lb/>\\{IN(\\d+)(\\w)', '</head>\n<pb n="\\1"/>\n<fw type="encabezado">\\2</fw>\n<fw type="foliacion">\\4</fw>\n<cb n="1"/>\n<lb/><hi rend="init\\4">\\5</hi>', texto.todo, perl = T)
texto.todo <- gsub('<lb/>\\{IN(\\d+)(\\w)', '<p><lb/><hi rend="init\\1">\\2</hi>', texto.todo, perl = T)
# Esto provocará un error en XML, pero servirá para atraer la atención
texto.todo <- gsub('<body>\n<p>', '<body>\n', texto.todo, perl = T) # Elimina un <p> que queda aislado al inicio
texto.todo <- gsub('</hi>\n<hi>', '</hi><hi>', texto.todo, perl = T)
writeLines(texto.todo, "mediolimpio.txt") # Graba a disco como texto plano
# Numeración de div automatica
texto.revision <- readLines("mediolimpio.txt", encoding = "UTF-8") # Vuelve a leer el texto
div.cuenta <- grep('<div n="W\\.W\\.0" type="ley">', texto.revision) # Localiza los div de ley
# Este bucle cambia el .0 de n con el número adecuado de ley
for (k in 1:length(div.cuenta)){
  texto.revision[div.cuenta[k]] <- sub('W\\.W\\.0', paste('W.W.',as.character(k), sep = ""), texto.revision[div.cuenta[k]])
}
texto.revision <- gsub('%', "% ", texto.revision, perl = T) # Se asegura que tras % hay espacio
texto.revision <- gsub('\\s{2,10}', " ", texto.revision, perl = T) # Elimina 2 o más espacios en blanco
texto.revision <- gsub('^<lb', "\t\t<lb", texto.revision, perl = T) # Sangra <lb
texto.revision <- gsub('^<p>', "\t<p>", texto.revision, perl = T) # Sangra <p>
texto.revision <- gsub('^<head>', "\t<head>", texto.revision, perl = T) # Sangra <head>
texto.revision <- gsub('>(Partida|Titulo)\\. ', '>\\1 .', texto.revision, perl = T)
texto.revision <- gsub('W\\.W\\.', div.tit[a], texto.revision) # Automatizándolo div.tit requeriría [a]
div1 <- which(texto.revision == "</div>") # Elimina el primer div del titulo
texto.revision[div1[1]] <- ""
# ATENCIÓN al nombre del fichero
writeLines(texto.revision, paste("LIMPIO",ficheros[a],sep = "-")) # Graba a disco xml
# control de errores
error0 <- grep('\\{', texto.revision, perl = T)
error1 <- grep('\\[', texto.revision, perl = T)
error2 <- grep('!', texto.revision, perl = T)
error <- c(error0,error1,error2)
if (length(error >0)){
  cat(paste("Hay que revisar manualmente el fichero LIMPIO",ficheros[a],"\n\n--------------------------------\n"))
}
file.remove("mediolimpio.txt") # Borra fichero intermedio
}
})
