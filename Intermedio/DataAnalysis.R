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

# With this type of information, a data analyst – in this case YOU! – can finally start looking for
# patterns regarding what determines high-growth. 
#
# High-growth (HG) is thus a binary variable taking
# a value of 1 if the firm has a sales growth rate of more than 20% per year, 0 otherwise.
#
# More precisely, your task is to:
#   • Provide descriptive statistics and figures of key innovation-related variables – i.e., R&D, product
# vs. product innovations, patents [2 points]
#
#   • Estimate a binary response model to explain the determinants of high growth [2 points]
#
#   • Be creative and find interesting patterns in the data [2 points]
#
# This type of analysis is very important for managers and policy-maker, for example if they wish to
# identify promising companies for M&A and/or target financial support.

load("Data_takehome_2.RData")

head(dat)

# %>% AndThen
plot(dat$metro_code, dat$ghg_log)

dat %>% 
  select(metro_code, ghg_log, green_tech) %>% 
  filter(ghg_log >= 15) %>% 
  mutate(ghgGreen_tech = ghg_log - green_tech) %>% 
  group_by(metro_code) %>% 
  summarise(AverageGhgGreen_tech = mean(ghgGreen_tech))
  
  