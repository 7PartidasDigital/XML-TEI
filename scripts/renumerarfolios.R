a <- readLines("TEXT.MN0-test.txt")
rectos <- grep("fol\\. XXXr", a)
vueltos <- grep("fol\\. XXXv", a)

for(i in 1:length(rectos)){
  a[rectos[i]] <- gsub("XXX", i, a[rectos[i]])
}
for(i in 1:length(vueltos)){
  a[vueltos[i]] <- gsub("XXX", i, a[vueltos[i]])
}
writeLines(a, "TEXT.1528-1R2.txt")


#################

# Esa es la buena, por ahora

a <- readLines("TEXT.MN0-test.txt")
#Averigua en qué posiciones están los [fol. XXX]
folios <- grep("fol\\. XXX", a)

# creamos los vectors rectos / vueltos.
# Hay que saber el número inicial y final y cambiarlos a ambos
# las de los dos puntos
rectos <- paste(299:304, "r", sep = "")
vueltos <- paste(299:304, "v", sep = "")

# Averigua en qué posiciones deben estar los rectos
folios_rectos <- which(folios %% 2 == 1)
# Convierte el último en impar
folios_rectos[length(folios_rectos)] <- folios_rectos[length(folios_rectos)] - 1
folios_r <- folios[folios_rectos]
#Averigua en qué posiciones deben estar los vueltos
folios_vueltos <- which(folios %% 2 == 0)
# Convierte el último en par
folios_vueltos[length(folios_vueltos)] <- folios_vueltos[length(folios_vueltos)] + 1
folios_v <- folios[folios_vueltos]

# Introduce la foliación
for(i in 1:length(folios_r)){
  a[folios_r[i]] <- gsub("XXX", rectos[i], a[folios_r[i]])
}
for(i in 1:length(folios_v)){
  a[folios_v[i]] <- gsub("XXX", vueltos[i], a[folios_v[i]])
}
# Graba el fichero resultante
writeLines(a, "TEXT.MN0-testR.txt")
