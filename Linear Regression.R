################################################
  Simple Linear regression
################################################
data("women")
fit <- lm(weight~height, data=women)
summary(fit)

women$weight
fitted(fit) # Lists predicted values in fitted model.

residuals(fit)
plot(women$height, women$weight)

################################################
Polynomial regression
################################################
#imporoving previous model after observing the plot.

fit2 <- lm(weight~height+I(height^2), data=women)
summary(fit2)
plot(women$height, women$weight)

lines(women$height, fitted(fit2))

# Scatterplot
library(car)
scatterplot(weight ~ height,
            data=women, spread=FALSE,
            lty.smooth=2, pch=19)





