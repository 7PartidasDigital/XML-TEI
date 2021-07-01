library(tidyverse)
entrada <- list.files(pattern = "colacion.*")
tabla <- NULL
for(i in 1:length(entrada)){
  lee <- read_tsv(entrada[i])
  tabla <- bind_rows(tabla, lee)
}


f_inicial <- tabla %>%
  filter(str_detect(LOP, "^[fF]"))
h_inicial <- tabla %>%
  filter(str_detect(LOP, "^[hH]"))

elimina <- c("fuesse", "fuere", "frutos", "fueras", "fue", "fuessen",
             "fruto", "finca", "finque", "firme", "fe", "fiel",
             "finare", "fincar", "fincare", "francamente", "fuer",
             "fuerça", "fueren", "ferna", "finado", "finando",
             "finasse", "fincan", "fincaria", "fincasse", "fincassen",
             "franco", "fructo", "fuera", "fueron")

resultado <- f_inicial %>%
  filter(!LOP %in% elimina)
