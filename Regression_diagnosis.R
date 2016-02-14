#################################################
Regression diagonistics:

#################################################
states
fit <- lm(Murder ~ ., data=states) 
confint(fit) 
# confint indicates that you can be 95% confident that interval 
# [2.38, 5.9] contains true change in murder rate for 1 percent change in
# illiteracy rate.

# Additionally, frost contains 0, concludes that a change in temp is unrelated to murder rate.
#################################
A typical approach::::::::::::::
#################################
par(mfrow=c(2,2))
plot(fit) # to understand these graphs consider assumptions. of OLS regression
 - Normality: If dependent variable is normaly distributed for fixed set of predictors values,
  then the residual values should be normally distributed with a mean of 0. Q-Q plot
 - Independence:if dependent variable values are independent.
 - Linearity: dependet ~ independet then theres hould be no systematic relationship between residuals and predicted/fitted values.
 - Homoscedasticity: constant variance.

#################################
Enhance approach::::::::::::::
  library(car)
#################################
# Normality:::::::
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
qqPlot(fit, labels=row.names(states), id.method="identify",
       simulate=TRUE, main="Q-Q Plot")
# id.method="identify" makes the plot interactive
# simulate=TRUE, a 95 percent confidence envelope is produced using a parametric bootstrap

states["Nevada",]
fitted(fit)['Nevada']
residuals(fit)['Nevada']
rstudent(fit)['Nevada']

# Independence Errors:::::::::::::
Assess if dependent variable values are independent(autocorrelation)
library(car)
durbinWatsonTest(fit)
# p=0.24 suggests no autocorrelation. nonsignificant.
# lag = 1 indicates each observation is being compared with one next to it in dataset.
# urbinWatsonTest uses bootstrapping to derive p-values.
# unless you add "simulate=False" you will get slightly different results each time you run.


# Linearity ::::::::::::::::::
You can look for non linearity in the relatioship between the 
dependent variable and the independent variables by using 
"component plus residual plots"/"partial residula plots"

library(car)
crPlots(fit)


# Homoscedasticity:::::::::::
library(car)
ncvTest(fit) # function for non-constant variance error test
spreadLevelPlot(fit) # creates scatterplot of absolute standardized residuals vs fitted values.



# Global validation of linear model assumption
install.packages("gvlma")
library(gvlma) # performs global validation of linear model assumptions along with other.
gvmod <- gvlma(fit)

summary(gvmod) # data meet all statistical assumptions that go with OLS regression model(p=2.8)



# Multicollinearity ::::::::::::::
Detected using variance inflation factor. 
Indicates degree to which confidence interval for that 
varibles'' regression parameter is expanded relative to a model with uncorrelated predictors. 

General rule, sqrt(vif)> 2 indicates multicollinearity.

library(car)
vif(fit)
sqrt(vif(fit))>2









