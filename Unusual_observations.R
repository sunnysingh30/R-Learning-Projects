#################################################
  Unusual Observations
Outlier detection: either unusually large +ve or -ve residuals
- Positive residual indicates model is underestimating response value.
- Negative indicates overestimating
#################################################

library(car)
outlierTest(fit) # "Nevada" is identified as an outlier. 
                 # Test single largest residual for significance as an outlier.
                 # If it is significant, you must delete it and rerun the test to see if others are present.

# High leverage points
Observations that have high leverage are ouliers with regard to the other predictors.
High leverage observations are identified through 'hat' statistic.
For give dataset the avg hat value is:
  p/n where p: number of parameters estimated in the model, including intercept/'n' is sample size.

Roughtly, an observation with hat value > 2 or 3 times avg hat values should be examined

hat.plot <- function(fit){
  p <- length(coefficients(fit))
  n <- length(fitted(fit))
  plot(hatvalues(fit), main="Index plot of Hat vlues")
  abline(h=c(2,3)*p/n, col='red', lty=2)
  identify(1:n, hatvalues(fit), names(hatvalues(fit)))
}

hat.plot(fit)

# Influential observations:::::::::::::::::
Observations that have disprportionate impact on the values of the model parameters.
- Cooks'' distance or D statistic
- added variableplots

Cook D value > 4/(n-k-1),
n : sample size.
k : number of predictors.

cutoff <- 4/(nrow(states) - length(fit$coefficients)-2)
plot(fit, which=4, cook.levels = cutoff)
abline(h=cutoff, lty=2, col='red')

# Above plot doesn't provide information on how these influential observations affect the model.
Added variable plot can helpin this regard.
library(car)
avPlots(fit, ask=F, onepage=T, id.method='identify')


###########################
Combine information from outlier, leverage, and influence plots into one
highly informative plot using 'influencePlot()' function from car package:
  
library(car)
influencePlot(fit, id.method = 'identify', 
              main='Influence Plot',
              sub='Circle size is proportional to Cook distance')

# Observations depicted by large circles may have disproportionate influence on the parameters estimates of the model.




  
