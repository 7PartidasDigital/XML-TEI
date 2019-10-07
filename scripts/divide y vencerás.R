setwd("~/Desktop/trabajo")
library(tidyverse)
partidas <- read_tsv("~/Documents/GitHub/XML-TEI/TextosPlanos/7P_LOP-tabla.txt")
texto <- partidas %>%
  filter(partida == 7)
titulos <- unique(texto$titulo)

for (i in 1: length(titulos)){
  titulo <- texto %>%
  filter(titulo == titulos[i]) %>%
  select(rubrica, texto)
write_tsv(titulo, paste("7_", formatC(titulos[i], width = 2, flag = 0), ".txt", sep = ""))
}
