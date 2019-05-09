


library(tidyverse)
library(tidytext)
url <- 'https://raw.githubusercontent.com/7PartidasDigital/XML-TEI/master/TextosPlanos/'
ioc <- read_tsv(paste(url, "7P_IOC-tabla.txt", sep = ""))
lop <- read_tsv(paste(url, "7_LOP-tabla.txt", sep = ""))
lbl <- read_tsv(paste(url, "7P_LBL-tabla.txt", sep = ""))

ioc_analizado <- lop %>%
  unnest_tokens(analisis, texto, token = "ngrams", n = 2)
ioc %>% count(analisis, sort = T)

lop_analizado <- lop %>%
  unnest_tokens(analisis, texto, token = "ngrams", n = 2)
loc %>% count(analisis, sort = T)

lbl_analizado <- lop %>%
  unnest_tokens(analisis, texto, token = "ngrams", n = 2)
lbl %>% count(analisis, sort = T)

