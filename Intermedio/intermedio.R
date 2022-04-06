
rm(list = ls())

library(MASS)
library(dplyr)
library(ggplot2)
library(AER)

load("Data_takehome_2.RData")

dat
summary(dat)

#plot(dat$ghg_log, dat$green_tech)

help(lm)

dat <- na.omit(dat)

dat <- dat %>%
  mutate(greentech_log = log(green_tech),
        popul_log = log(popul),
        vamanuf_log = log(va_manuf),
        rile_log = log(rile),
        qoi_log = log(qoi))

qoi_log %>% 
  na.omit()

dat <- na.omit(dat)

# log of green_tech generates -inf
# log of qoi generates NaN cause neg


lm.fit <- lm(qoi ~ greentech_log, data = dat)
summary(lm.fit)

ggplot(dat, aes(x = qoi, y = greentech_log)) +
  geom_point(size = dat$rile / 10, colour = "red") +
  stat_smooth(method = "lm", se = TRUE, size = 1) +
  labs(x = "x (log)", 
       y = "y (log)",
       title = "linear regression line")

#
# 3D
#

library(rgl)

dat <- na.omit(dat)

y <- dat$rile
x <- dat$qoi
z <- sqrt(dat$green_tech)

fit <- lm(z ~ y + x)

grid.lines = 26
x.pred <- seq(min(x), max(x), length.out = grid.lines)   # Sequence of x values; check by typing in console x.pred
y.pred <- seq(min(y), max(y), length.out = grid.lines)   # Idem for y values
xy <- expand.grid(x = x.pred, y = y.pred)                # Create a grid with x and y values (for each y value, we attach the different x values - these will be the 'observations' that we use below)
z.pred <- matrix(predict(fit, newdata = xy),             # Predict the z values based on the values in the grid, and save the outcome in a matrix
                 nrow = grid.lines, ncol = grid.lines)

?persp3d

# Run persp3 + point3d if you wish to move the object in 3D
persp3d(x.pred, y.pred, z.pred, 
        ylim = range(y, finite = TRUE),
        zlim = range(z, finite = TRUE),
        xlim = range(x, finite = TRUE),
        col = "green", expand = 0.8, alpha = 0.5, ticktype = "detailed",
        xlab = "qoi", ylab = "rile", zlab = "green tech")

points3d(x, y, z, col = "red", size = 5, add = T)
lines3d(x, y, z, col = "blue", size = 2, add = T)


rm(pred_int)

#help("predict")
predict(lm.fit, data.frame(popul_log = 3.5), interval = "prediction")

help(plot.lm)
plot(lm.fit, which = 1)  
plot(lm.fit, which = 2)

popul_log = beta0 + beta1*vamanuf_log + beta2*vamanuf_log + u
lm.multiple <- lm(popul_log ~ vamanuf_log + vamanuf_log, data = dat)
summary(lm.multiple)

library(rgl)

x <- dat$year
y <- dat$popul_log
z <- dat$vamanuf_log

fit <- lm(z ~ x + y)

grid.lines = 26
x.pred <- seq(min(x), max(x), length.out = grid.lines)
y.pred <- seq(min(y), max(y), length.out = grid.lines) 
xy <- expand.grid(x = x.pred, y = y.pred) 
.pred <- matrix(predict(fit, newdata = xy),             
                nrow = grid.lines, ncol = grid.lines)

persp3d(x.pred, y.pred, z.pred, 
        zlim = c(10, 13),
        col = "year", expand = 0.8, alpha = 0.5, ticktype = "riled",
        xlab = "va_manuf", ylab = "popular", zlab = "green_tech")

points3d(x, y, z, col = "red", size = 5, add = T)

lpm_1 <- lm(urban ~ green_tech, data = dat)
summary(lpm_1)

# and calculate robust standard errors since we do detect heteroscedasticity
bptest(lpm_1)
coeftest(lpm_1, vcov = vcovHC, type = "HC1")

predict(lpm_1, data.frame(ghg_log = (c(0.1, 1, 2))), interval = "prediction")