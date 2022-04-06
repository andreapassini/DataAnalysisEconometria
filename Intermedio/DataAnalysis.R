# Install and use packages
# Packages have pre-programmed functions that solve specific problems
# and expand the R vocabulary
install.packages("tidyverse")
library("tidyverse")
require("tidyverse")
# tidyverse includes packages like dplyr and ggplot2

?rm
?ls

rm(list = ls())

library(MASS)
library(dplyr)
library(ggplot2)
library(AER)

load("Data_takehome_2.RData")

head(dat)

# %>% AndThen
dat %>% 
  select(metro_code, year) %>% 
  group_by(metro_code)
  

# dat %>% 
#   filter( < 25)
#   ggplot(aes())+
#   geom_point(aes(colour = ,
#                  size = ),
#              alpha = 0.5)+
#   geom_smooth()+
#   facet_wrap(~year, nrow = 1)
#   labs(x = "",
#        y = "",
#        title = "")
#   theme_bw()


