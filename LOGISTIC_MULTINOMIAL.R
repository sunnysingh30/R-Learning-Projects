# Multinomial & Ordinal Regression

# Case 1 --- Multinomial  Regression
The modeling of program choices made by high school students can be done using
Multinomial logit. The program choices are general program, vocational program 
and academic program. Their choice can be modeled using their writing score 
and their social economic status.

Based on a variety of attributes such as social status, channel type, awards 
and accolades received by the students, gender, economic status and how well 
they are able to read and write in the subjects given, the choice on the type 
of program can be predicted. Choice of programs with multiple levels 
(unordered) is the dependent variable. This case is suited for using 
Multinomial Logistic Regression technique.
######################################
library(foreign)
ml <- read.dta('http://www.ats.ucla.edu/stat/data/hsbdemo.dta')
names(ml)
head(ml)

# releveling the data
ml$prog2 <- relevel(ml$prog, ref='academic')
levels(ml$prog)

# Lets' execute Multinomial regeression.
library(nnet)
test <- multinom(prog2 ~ ses + write, data=ml)
summary(test)

# Interpretation:::::::
# - The first line is being compared to prog=general to our baseline prog='academic
# - The second row to prog=vocation to our baseline prog=academic
# - One unit increase in write decrease the log odds of being in general program vs aademic.
# - One unit increase in write decreases log odds of being in vocation vs academin.
# - Log odds of being in general program s academic decreases by 1.162if moving frm ses=low to ses=high.
# - Log odds of being in general program than in academic decreases by 0.53 if moving from ses=low to ses=middle.
# - Log odds of being in vocation than in academic decreases by 0.98 as we move from ses=low to ses=high.
# - Log odds of being in vocation vs academic increases by 0.29 as we move from ses=low to ses=middle.

# Lests' calculate Z score and p-calue for the variables in the model.

z <- summary(test)$coefficients/summary(test)$standard.errors
p <- (1 - pnorm(abs(z), 0, 1)) *2
exp(coef(test)) # exponential form.

#### 
The p values tells tha ses variables are not significant. Now we will explre 
the entire dataset and analyze if we can remove ay variables which do not add to
mode performance.
####

names(ml)
levels(ml$female)
levels(ml$ses)
levels(ml$schtyp)
levels(ml$honors)

# Now letes build multinomial on entire data set. after removing id and prog variables.

test <- multinom(prog2~., data=ml[,-c(1,5,13)])
summary(test)

# Lets' check fitted values now.
head(fitted(test))

## ONce we have bild the model. We will use it for prediction. Let us create a new data 
# set with different permutation and combinations.
expanded=expand.grid(female=c("female", "male", "male", "male"),
                       ses=c("low","low","middle", "high"),
                       schtyp=c("public", "public", "private", "private"),
                       read=c(20,50,60,70),
                       write=c(23,45,55,65),
                       math=c(30,46,76,54),
                       science=c(25,45,68,51),
                       socst=c(30, 35, 67, 61),
                       honors=c("not enrolled", "not enrolled", "enrolled","not enrolled"),
                       awards=c(0,0,3,0,6) )

head(expanded)
predicted <- predict(test, expanded)
predicted <- predict(test, expanded, type='probs')
head(predicted)

#####
Now, in order to plot predicted probabilities for intuitive understanding, we add predicted 
probability values to data.
#####

bpp <- cbind(expanded, predicted)
head(bpp)

# Now we will calculate mean probabilities.
head(bpp[,4:7])
by(bpp[,4:7], bpp$ses, colMeans)
by(bpp[,11:13], bpp$ses, colMeans)

# melt() function melts data with the purpose of each row being a unique id variable combination.

library(reshape2)
bpp2 <- melt(bpp, id.vars = c('female', 'ses', 'schtyp', 'read', 'write', 'math','science', 'socst', 'honors', 'awards'), value.name = 'probability')
head(bpp2)
# Now we will be plottign graphs to explore the distribution of dependent variable 
# vs  independent variables usgin ggplot(). 
library(ggplot2)
ggplot(bpp2, aes(x=write, y=probability, colour=ses)) +
  geom_line() +
  facet_grid(variable~., scales='free')

