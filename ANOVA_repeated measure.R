######################################################
  Repeated measures of ANOVA
- Subjects are measured more than once. 
- One withon-groups and one between-groups factor (common design)
- Data: physiological ecology
  studies how physiological and bichemical process of living systems 
  respond to variations in environmental factors (a crucial area of study given the realities of global warming).
- The CO2 data set: contains cold tolerance in Northern & Southern plants of grass species.
  photosynthetic rates of chilled plants are compared with photosynthetic rates of nonchilled plants and several ambient CO2 concentrations.
- In this example we will focus on 'chilled' plants.
######################################################
attach(CO2)
head(CO2)
w1b1 <- subset(CO2, Treatment='chilled')
fit <- aov(uptake ~ conc*Type + Error(Plant/(conc),w1b1))
summary(fit)

interaction.plot(conc, Type, uptake, type='b',
                 col=c('red', 'blue'), pch=c(16,18))

boxplot(uptake~Type*conc, col=c('gold', 'green'))


