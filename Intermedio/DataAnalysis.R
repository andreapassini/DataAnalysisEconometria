# Install and use packages
# Packages have pre-programmed functions that solve specific problems
# and expand the R vocabulary
install.packages("tidyverse")
library("tidyverse")
require("tidyverse")
# tidyverse includes packages like dplyr and ggplot2

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
  filter(metro_code == "AT212")
