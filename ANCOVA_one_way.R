#################################################
  One way ANCOVA
- Extends one-way ANOVA to include one or more quantitative 
covariates.
- litter dataset from 'multcomp' package.
Pregnent mice were divided into 4 treatment groups;
each group received a different dose of drug (0,5,50 or 50)
The mean post-birth weight for each litter was the dependent 
variable and gestation time was as covariate.
The analysis is given in following listing:
#################################################

data(litter, package='multcomp')
attach(litter)
head(litter)
table(dose)

aggregate(weight, by=list(dose),  FUN=mean)
fit <- aov(weight ~ gesttime + dose)
summary(fit)

######### Observations:
- from table(), you can see that there are unequal no. of litters at 
  each dose.
- Based on group means, no-drug had the highest mean litter weight,
- ANCOVA F-test indicates: gestation time was related to birth weight, and
  drug dosage was related to birth weight afer controlling for gestation time. 
  The mean birth weight isn't' same for each drug dosages.
  
Beacuse you are using covariates, you may want to use adjusted group means, that is, 
the group means obtained after partialing out the effects of covarites.
You can use effects() function in the effects library to calculate adjusted means:
  
# Adjusted group means
library(effects)
effect('dose', fit) # adjusted mean is similar to unadjusted means, but this is not always the case. Explore effects documentation.

# Multiple comparison tocompute pairwise means
library(multcomp)
contrast <- rbind('no drug vs. drug' = c(3,-1,-1,-1))
summary(glht(fit, linfct=mcp(dose=contrast)))

################## Observations :::::::::::::
The contrast c(3, -1, -1, -1) specifies a comparison of the first group with the average
of the other three. The hypothesis is tested with a t statistic (2.581 in this case),
which is significant at the p < .05 level. Therefore, you can conclude that the no-drug
group has a higher birth weight than drug conditions. Other contrasts can be added
to the rbind() function (see help(glht) for details).
################################################




#######################################
# Assessign test assumptions:::::::::::::
Test for homogenity --> its assumed that the regression slope for predicting birth weight 
from gestation time is same in each treament groups.

# Testing for homogenity of regresison slopes:

library(multcomp)
fit2 <- aov(weight ~ gesttime*dose, data=litter)
summary(fit2)

# Observation: 
- The interaction is not significant, supporting the assumption of equality of slope.

# Visualizing the results 
- ancova() in 'HH' package provides a plot of the relatioship between the dependent variable, the covariance, and
the factor. eg-
install.packages("HH")
library(HH)
ancova(weight ~ gesttime * dose, data=litter)
# ancova(weight ~ gesttime * dose, data=litter)
# Observations
- regression lines for predicting birth weight form gestation time
  are parallel in each group but have different intercepts.
- As gestation time increases , birth weight increases.
- 0 group has largest intercept and 5 dose group has lowest intercept.
  The lines are parallel cz you have specified them to be. 
