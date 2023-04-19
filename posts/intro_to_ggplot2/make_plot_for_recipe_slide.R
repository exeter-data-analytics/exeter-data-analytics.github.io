# make plot for slide about ggplot2

# load in required packages
library(tidyverse)
library(palmerpenguins)
library(MetBrewer)
library(patchwork)
library(showtext)

# check what fonts are available
showtext_auto()
sysfonts::font_families()

# add font
font_add_google("Caveat")

# check fonts again
sysfonts::font_families()

# load in data
data("penguins")
d <- penguins

# have a look at the data
glimpse(d)

ggplot(d, aes(species, bill_length_mm, col = species, fill = species)) + # add first empty plot layer
  geom_boxplot(outlier.shape = NA) + # add boxplot, do not plot the outliers
  stat_summary(geom = "crossbar", fatten = 2, color = "white", width = 0.4, 
               fun.data = function(x){return(c(y = stats::median(x), ymin = stats::median(x), ymax = stats::median(x)))}) + # add median line to the boxplots
  geom_jitter(width = 0.2, shape = 21, fill = 'white', size = 3) + # add jittered raw points
  theme_bw(base_size = 16, base_family = 'Caveat') + # change theme to the one I like (others are available)
  labs(x = 'Species',
       y = 'Bill length (mm)') + # change labels
  ylim(c(30,65)) + # change y limits
  guides(col = 'none',
         fill = 'none') +
  theme(axis.text = element_text(size = 60),
        axis.title = element_text(size = 60)) 

ggsave('posts/intro_to_ggplot2/plot.png', last_plot(), height = 3, width = 4)
