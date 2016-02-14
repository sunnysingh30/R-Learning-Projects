############################################
  One way ANOVA
############################################

library(multcomp)
attach(cholesterol)
cholesterol
?cholesterol

table(trt) # group sample means

aggregate(response, by=list(trt), FUN=mean) # Group means
aggregate(response, by=list(trt), FUN=sd) # Group stand deviations
fit <- aov(response ~ trt) # test for group difference

summary(fit)
library(gplots)
plotmeans(response ~ trt, xlab='treatment', ylab='response',
          main='Mean plot with 95% CI') # produces graph of group mean and their CI
# DrugE produces greatest cholestrol reuduction
# std were relatively constant accross five groups.

##########################################
Multiple comparisons
Anova F test for treatment tells you that 5 drugs regiments arent equally effective.
ut it doesn't tell you which treatments differ from one another.'
-Use TukeyHSD() provides tests for all pairwise difference between group means.
- This function has compatibility issues with package HH. detach("package:HH").
##########################################

TukeyHSD(fit)
par(las=2) # rotate axis labels
par(mar=c(5,8,4,2)) # increases left margin area so that labels fit.
plot(TukeyHSD(fit))

#Another way of doing above.
library(multcomp)
par(mar=c(5,4,6,2))
tuk <- glht(fit, linfct=mcp(trt="Tukey"))
plot(cld(tuk, level=.01),col="lightgrey")

# Assessing test for assumptions:
# confidense in the results depends on the degree to which our data satisfies
# assumptions underlying the statistical tests. 
# In 1 way ANOVA, the dependent variable is assumed to be normally distributed, 
# and have equal variance in each group. Use Q-Q plot to assess normali assumption.
library(car)
qqPlot(lm(response~trt, data=cholesterol))

