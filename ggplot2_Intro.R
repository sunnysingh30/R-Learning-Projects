########################------------------- Intro to ggplot2
########################------------------- PLOTTING BASICS
update.packages(checkBuilt = T, ask=F) # to update packages
rm(list=ls())
R.version

# Scatter plott ---------------
install.packages("ggplot2")
library(ggplot2)
library(dplyr)
?mpg # Fuel economy data from 1999 and 2008 for 38 popular models of car
head(mpg)
glimpse(mpg)
summary(mpg)

qplot(displ, hwy, data=mpg) # always explicity specify the data
# Additional variables:
# Can specify additional variables with aesthetics(like shape, color, size) or
# facetting (small multiples displaying different subsets)

qplot(displ, hwy, data=mpg, colour=class) # Legends chosen and displayed automatically

# Try mapping different variables to the color, size, and shape aesthetics. Is there a 
# difference between discrete and continous variables ? What happens when you use multiple
# aesthetics ?

qplot(displ, hwy, colour=as.factor(cyl), 
      data=mpg, size=1) # discrete : Rainbow of colors
qplot(displ, hwy, colour=cyl, data=mpg) # continous : gradient from red to blue


##################------------- FACETING
# Small multiples displaying different subsets of the data.
# Useful for exploring conditional relatioships. Useful for 
# large data.
# -- facet_grid() : 2d grid, rows ~ cols, '.' for no split.
# -- facet_wrap() : 1d ribbon wrapped into 2d

glimpse(mpg)
qplot(displ, hwy, data=mpg) +
  facet_grid(.~cyl) # cyl ~ . 

qplot(displ, hwy, data=mpg) +
  facet_grid(drv ~.) # drv ~ .

qplot(displ, hwy, data=mpg) +
  facet_grid(drv ~ cyl)

qplot(displ, hwy, data=mpg) + 
  facet_wrap(~ class) 



########------ Whats the problem with the plot
glimpse(mpg)
?mpg
qplot(cty, hwy, data=mpg)

# Now try above this way:
qplot(cty, hwy, data=mpg, geom="jitter") # geom controls type of plot

qplot(class, hwy, data=mpg) # How could we improve this plot ?
qplot(reorder(class, hwy), hwy, data=mpg, geom="jitter") # reorder() incredibly useful technique.

qplot(reorder(class, hwy), hwy, data=mpg, geom="boxplot")
qplot(reorder(class, hwy), hwy, data=mpg, 
      geom=c('boxplot', 'jitter'))






