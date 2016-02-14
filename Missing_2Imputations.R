####################################################
  Multiple imputation
How does the m ice() function impute missing values?
Missing values are imputed by G ibbs sampling. By default, each variable containing
missing values is predicted from all other variables in the dataset. These prediction
equations are used to impute plausible values for the missing data. The process
iterates until convergence over the missing values is achieved. For each variable, the
user can choose the form of the prediction model (called an elementary imputation
                                                  method), and the variables entered into it.
By default, predictive mean matching is used to replace missing data on continuous
variables, while logistic or polytomous logistic regression is used for target
variables that are dichotomous (factors with two levels) or polytomous (factors with
                                                                        more than two levels) respectively. Other elementary imputation methods include
Bayesian linear regression, discriminant function analysis, two-level normal imputation,
and random sampling from observed values. Users can supply their own
methods as well.
####################################################
library(mice)
mice() --> with() --> poo()
#mice : starts with data containing missing data and returns 
#    an object containing several complete datasets. 
#    Random component so each set is unique.
#with : applys statistical model to each complete set in turn.
#poot : combines results of these separate analyses into single
#      set of results.'';

library(mice)
# Format:
imp <- mice(mydata, m)
fit <- with(imp, analysis)
pooled <- pool(fit)
summary(pooled)

#### Example ::::::::::::::::::::::
library(mice)
data(sleep, package='VIM')
imp <- mice(sleep, seed=123)
fit <- with(imp, lm(Dream ~ Span + Gest))
pooled <- pool(fit)

summary(pooled)
imp$imp$Dream # Displays 5 imputed values  for each 12 mamals
              # with missing data on the Dream varaible. 
              # A review of these matrices helps you determine if the imputed.
              # values are reasonable. A negative value for length of sleep might give you pause (or nightmares).

# To view m imputed datassets via complete() function.
complete(imp, action=3)

########################################################################
The multiple imputation FAQ page (www.stat.psu.edu/~jls/mifaq.html)
??? Articles by Van Buuren and Groothuis-Oudshoorn (2010) and Yu-Sung, Gelman,
Hill, and Yajima (2010)
??? Amelia II: A Program for Missing Data (http://gking.harvard.edu/amelia/)


library(lattice)
histogram(~height | voice.part, data = singer,
          main="Distribution of Heights by Voice Pitch",
          xlab="Height (inches)")
