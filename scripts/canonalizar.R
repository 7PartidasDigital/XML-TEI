library(tidyverse)
prueba <- readLines("~/OneDrive - Universidad de Valladolid/Sp-MN0-1/flat/mn0-1-04.txt")
str_detect(corregido, "\\&")

charta <- function(x){
corregido <- str_replace_all(prueba, "nrr", "nr")
corregido <- str_replace_all(corregido, "mm", "m")
corregido <- str_replace_all(corregido, "n([pb])", "m\\1")
corregido <- str_replace_all(corregido, "nn", "ñ")
corregido <- str_replace_all(corregido, "ñj", "ñi")
corregido <- str_replace_all(corregido, "ñ[^aeiou]", "n")
corregido <- str_replace_all(corregido, "ss", "s")
corregido <- str_replace_all(corregido, "ff", "f")
corregido <- str_replace_all(corregido, "\\&", "e")
corregido <- str_replace_all(corregido, "xpi", "cri")
corregido <- str_replace_all(corregido, "ç([ei])", "c\\1")
corregido <- str_replace_all(corregido, "seer", "ser")
corregido <- str_replace_all(corregido, "vn", "un")
corregido <- str_replace_all(corregido, "ff", "f")
corregido <- str_replace_all(corregido, "\\bn([ijo])n\\b", "n\\1")
corregido <- str_replace_all(corregido, "([aeiou])u([aeiou])", "\\1v\\2")
corregido <- str_replace_all(corregido, "([aeiou])lu([aeiou])", "\\1v\\2")
corregido <- str_replace_all(corregido, "([^d][eo])s([cç][ei])", "\\1\\2")
corregido <- str_replace_all(corregido, "([^lu]e)y([^aieou\b])", "\\1i\\2") # Falla con grey, y rey
corregido <- str_replace_all(corregido, "rei\\b", "rey")
corregido <- str_replace_all(corregido, "([aeou])i([aeou])", "\\1j\\2") # No lo tengo claro aún
corregido <- str_replace_all(corregido, "quj", "qui")
corregido <- str_replace_all(corregido, "\\by([^aeiou])", "i\\1")
corregido <- str_replace_all(corregido, "oy([dtrgms])", "oi\\1")
corregido <- str_replace_all(corregido, "sy", "si")
}
limpio <- charta(prueba)
limpio[45]

