###########################################################################
    Support Vector Regression with 'R'
In this section we have considered the case of Linear model and later applied 
SVR
###########################################################################
dt <- data.frame(x=1:20, y=c(3,4,8,4,6,9,8,12,15,26,35,40,45, 54, 49, 59,60,62,63,68))
plot(dt, pch=16)

mod <- lm(y~x, data=dt)
abline(mod)

# How good is our regression
pred <- predict(mod, newdata=dt)

# display predictions
points(dt$x, pred, col='blue', pch=4)

# Measure the error
rmse <- function(error){
  sqrt(mean(error^2))
}

predrmse <- rmse(mod$residuals)
predrmse # RMSE of linear model is 5.703778

#################################################
  Support vector machine
library(e1071)
#################################################
mod_svm <- svm(y~x, data=dt)
pred_svm <- predict(mod_svm, dt)
plot(dt)
points(dt$x, pred_svm, col='red', pch=4) # This time the predicted values are closer to observed values.

mod_svm$residuals # svm residuals
# we compute svm error (not not the same as data$Y - predictedY)

svm_err <- dt$y - pred_svm
svm_err_rmse <- rmse(svm_err) # The error is reduced from 5.7 to 3.15. Let see if can reduce even further by tuning SVM


#################################
  Tuning Support Vector machine.
- set epsilon, by default it is 0.1.
- There is also cost parameter, which can be used to avoid overfitting.

The process of choosing above parameter is called hypermeter optimization.
Standard way of doing above is by 'Grid search'. It train alot of models for 
different couples of epsilon and cost and choose best one.
#################################

# Perform grid search:
tune_res <- tune(svm, y~x, data=dt, 
                 ranges = list(epsilon=seq(0,1,0.1), 
                               cost=2^(2:9)))
print(tune_res)
plot(tune_res)
# Darker the region better the model as RMSE is closer to zero in darker region.

tune_res <- tune(svm, y~x, data=dt,
                 range=list(epsilon=seq(0,0.2,0.01), cost=2^(2:9)))
print(tune_res)
plot(tune_res)

tune_mod <- tune_res$best.model
tune_mod_pred <- predict(tune_mod, dt)
error <- dt$y - tune_mod_pred
tune_modRMSE <- rmse(error) # The value decreased from 3.15 to 2.1214


# Visualizing first SVM model and tuned SVM model.
plot(dt, pch=16)
points(dt$x, pred_svm, col='red', pch=4)
?lines
lines(dt$x, pred_svm, type='l', col='red')

points(dt$x, tune_mod_pred, col='blue', pch=10)
lines(dt$x, tune_mod_pred, type='l', col='blue')
