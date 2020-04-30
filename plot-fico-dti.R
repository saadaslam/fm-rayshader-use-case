library(tidyverse)
library(rayshader)
library(data.table)

headers <- fread("headers.txt", sep = "|", header = F)
colnames <- pluck(transpose(headers), 1)

aqsn <- fread("Acquisition_2006Q2.txt", sep = "|", header = FALSE)

colnames(aqsn) <- colnames


levels <- aqsn %>% 
  ggplot(aes(x = fico_bo, y = d_ratiob)) +
  stat_density2d(aes(fill = stat(nlevel)), geom = "polygon") +
  scale_fill_viridis_c(option = "C") # +
  # theme_minimal() # +
  # labs(x = "FICO", y = "Debt-to-Income Ratio", title = "2006 Q2 Acquisitions")

levels

plot_gg(
  levels, multicore = TRUE
)

render_movie(filename = "ggplot")

rayshader::save_3dprint("3d-print-instructions")

rgl::rgl.close()
