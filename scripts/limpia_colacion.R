library(tidyverse)
ficheros <- list.files()
uno <- readLines("colacion_0100.txt")
uno <- gsub("^\\| *", "", uno)
uno <- gsub(" +\\|$", "", uno)
uno <- gsub(" +\\| +", "\t", uno)
uno <- gsub("^\\+-----.*$", "", uno)
uno <- uno[uno !=""]
