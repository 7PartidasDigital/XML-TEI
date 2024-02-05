# IMprime una mimagen encima de otra

library(magick)

i_1 <- image_read("FACERE.png")
i_2 <- image_read("FABULARE.png")
i_3 <- image_read("FILIUM.png")
i_4 <- image_read("hasta.png")
i <- image_append(c(i_1, i_2, i_3, i_4), stack = T)
image_write(i, "F_siena.png")
