rm(list=ls())
#######################################################
  Two way factorial ANOVA

- 60 guinea pigs are randomly assigned to receive one of 3 levels of ascorbic 
(0.5,1, 2mg) and one of 2 delivery methods (Orange juice & vitamin C), under thr restriction
that each treatment of combination has only 10 guinea pigs.
- Dependent variable is ToothGrowth lenght

#######################################################

attach(ToothGrowth)
head(ToothGrowth)
table(supp, dose)

# Group mean
aggregate(len, by=list(supp,dose), FUN=mean)

# Group standard deviation
aggregate(len, by=list(supp, dose), FUN=sd)

fit <- aov(len ~ supp*dose)
summary(fit)



# Interaction plot between Dose and supplement type
# plot provides mean length for each supplement at each dose.
interaction.plot(dose, supp, len, type='b',
                 col=c('red','blue'), pch=c(16,18),
                 main='Interaction between dose and supplement type')


interaction.plot(dose, supp, len, type='b',
                 col=c('red','blue'), pch=c(16, 18),
                 legend = TRUE)

?interaction.plot
# fine interaction plot with plotmeans() function in gplots package.
library(gplots)
plotmeans(len ~ interaction(supp, dose, sep=' '),
          connect=list(c(1,3,5), c(2,4,6)),
          col=c('red', 'darkgreen'),
          main='Interaction Plot with 95% CIs',
          xlab='Treatment and dose combination')

# to plot both main effects and two-way interactions for any factorial 
# design of an order.
library(HH)
interaction2wt(len~supp*dose)


