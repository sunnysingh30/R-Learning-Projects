#############################################
    Multiple Regression:
  state.x77 dataset in base package for this example. 
explore relation between states'' murder rate and other characteristics 
of the state like population, illiteracy rate, income, etc.
#############################################

states <- data.frame(state.x77[, c('Murder', 
                                   'Population',
                                   'Illiteracy',
                                   'Income',
                                   'Frost')])

cor(states)
library(car)
scatterplotMatrix(states, spread=F, lty.smooth=2)

# fit model
fit <- lm(Murder~., data=states)
summary(fit)
# predicted variable accounts for 57% variance iin morder rates accross states.
# In next case we will consider a case in which predictor variable interact.


######################################
Multiple linear regression with interction 
######################################
data(mtcars)
names(mtcars)
fit <- lm(mpg~ hp + wt + hp:wt, data=mtcars)
summary(fit)

# Visualising the effect of interaction in predictors on response variable.
library(effects)
plot(effect("hp:wt", fit, xlevels=list(wt=c(2.2,3.2,4.2))),
     multiline=T) # As the wt increases, the expected change in mpg
                  # from unit change in hp dcreases
