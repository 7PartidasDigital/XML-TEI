a <- readLines("TEXT.1528-1R.txt")
rectos <- grep("fol\\. XXXr", a)
vueltos <- grep("fol\\. XXXv", a)

for(i in 1:length(rectos)){
  a[rectos[i]] <- gsub("XXX", i, a[rectos[i]])
}
for(i in 1:length(vueltos)){
  a[vueltos[i]] <- gsub("XXX", i, a[vueltos[i]])
}
writeLines(a, "TEXT.1528-1R2.txt")
