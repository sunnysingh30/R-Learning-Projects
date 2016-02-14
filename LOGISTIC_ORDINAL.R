# Ordinary Logistic Regression
Case 2 (Ordinal Regression)

A study looks at factors which influence the decision of whether to apply to graduate 
school. College juniors are asked if they are unlikely, somewhat likely, or very likely
to apply to graduate school. Hence, our outcome variable has three categories i.e. 
unlikely, somewhat likely and very likely.

Data on parental educational status, class of institution (private or state run), 
current GPA are also collected. The researchers have reason to believe that the 
???distances??? between these three points are not equal. For example, the ???distance???
between ???unlikely??? and ???somewhat likely??? may be shorter than the distance between 
???somewhat likely??? and ???very likely???. In such case, we???ll use Ordinal Regression.
#######################

require(foreign)
require(ggplot2)
require(MASS)
require(Hmisc)
require(reshape2)

rm(list=ls())
# Load data
data <- read.dta('http://www.ats.ucla.edu/stat/data/ologit.dta')
head(data)
levels(data$apply)

# Plottign distribution
ggplot(data, aes(x=apply, y=gpa)) +
  geom_boxplot(size= .75) +
  geom_jitter(alpha= .5) +
  facet_grid(pared~public, margins=T) +
  theme(axis.text.x=element_text(angle=45, hjust=1, vjust=1))

# Build model
m <- polr(apply~ pared + public + gpa, data=data, Hess=T)
coef(summary(m))
# NOw, lets' calculte essential metrics such as p-value, CI, Odds ratio.
ctable <- coef(summary(m))
ctable

p <- pnorm(abs(ctable[,'t value']), lower.tail = F)*2
ctable <- cbind(ctable, 'p value' = p)
# Confidence Interval
ci <- confint(m)

exp(coef(summary(m)))

# OR or CI
exp(cbind(OR=coef(m), ci))

##################################
Interpretation

1. One unit increase in parental education, from 0 (Low) to 1 (High), the 
odds of ???very likely??? applying versus ???somewhat likely??? or ???unlikely??? 
applying combined are 2.85 greater .

2. The odds ???very likely??? or ???somewhat likely??? applying versus ???unlikely??? 
applying is 2.85 times greater .

3. For gpa, when a student???s gpa moves 1 unit, the odds of moving from 
???unlikely??? applying to ???somewhat likely??? or ???very likley??? applying
(or from the lower and middle categories to the high category) are
multiplied by 1.85.
##################################
# -- Let???s now try to enhance this model to obtain better prediction estimates.
summary(m)
summary(update(m, method='probit', Hess=T), digits=3)
summary(update(m, method='cloglog', Hess=T), digits=3)

# Lets' add interaction terms here

head(predict(m, data,type='p'))
addterm(m, ~.^2, test='Chisq')

m2 <- stepAIC(m, ~.^2)
m2

summary(m2)
anova(m, m2)

# Time plot this model. 
m3 <- update(m, Hess=T)
pr <- profile(m3)
confint(pr)


plot(pr)
pairs(pr)



