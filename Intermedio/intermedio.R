
rm(list = ls())

library(MASS)
library(dplyr)
library(ggplot2)
library(AER)

load("C:/Users/Nicola/Desktop/intermedio econometria/Data_takehome_2.RData")

dat
summary(dat)

#plot(dat$ghg_log, dat$green_tech)

help(lm)


#data(dat)
#help(dat)

dat <- dat %>%
  mutate(#greentech_log = log(green_tech),
        popul_log = log(popul),
        vamanuf_log = log(va_manuf),
 #        rile_log = log(rile), #fixare, valori negativi
        qoi_log = log(qoi))

lm.fit <- lm(vamanuf_log ~ popul_log, data = dat)

summary(lm.fit)

ggplot(dat, aes(x = vamanuf_log, y = popul_log)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE, size = 1) +
  labs(x = "x (log)", 
       y = "y (log)",
       title = "linear regression line")

help("predict")
predict(lm.fit, data.frame(vamanuf_log = 15), interval = "prediction")
