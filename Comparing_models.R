#########################################################
  Comparing Models
- nested models using ANOVA()
- Comparing models with AIC() 'Akaike Information Criterion' # Models with smaller AIC indicate adequate fit.
#########################################################

fit1 <- lm(Murder ~ Population + Illiteracy + Income + Frost,
          data=states)

fit2 <- lm(Murder ~ Population + Illiteracy, data=states)

anova(fit1, fit2)


###### Comparing models with the AIC 
fit1 <- lm(Murder ~ Population + Illiteracy + Income + Frost,
           data=states)
fit2 <- lm(Murder ~ Population + Illiteracy, data=states)

AIC(fit1, fit2)


##### Variable Selection :::::::::::::::::::
# Stepwise Regression
# All Subsets Regression 
- Stepwise Regression: Forward stepwise/backward Stepwise:
  Although it may find good model , theres no guarantee that it will find the best model. 

library(MASS)
fit <- lm(Murder ~ Population +Illiteracy + Income + Frost,
          data=states)
stepAIC(fit, direction='backward')


############ Subsets Regression
- All Subsets regression: To overcome limitation of all subset regression
  You can choose R-sq, adj-R-sq and CP statistic as your criterion for reportng best models.
library(leaps)  
regsubsets()

leaps <- regsubsets(Murder ~ Population + Illiteracy + Income +Frost,
                    data=states, nbest = 4)
plot(leaps, scale = 'adjr2') # Plot adjusted regression. this plot suggests that Intercept, population, Illiteracy has highest adj R2 with best model.

# CP Statistic Plot: widely suggested that a good model is one in which the 
# CP statistic is close to the number of model parameters (including intercept)
library(car)
subsets(leaps, statistic = 'cp', main='CP plot for all Subsets Regression')
abline(1,1,lty=2, col='red')
# Better models will fall close to a line with intercept == slope == 1
