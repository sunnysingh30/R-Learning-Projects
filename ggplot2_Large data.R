#############--------- Intro ggplot2
#############--------- LARGE DATA 

# - The diamonds data
# - histograms and bar charts
# - Frequency polygons
# - Scatterplots for large data

########--------- THE DIAMONDS DATA
rm(list=ls)
setwd('/Users/sunnysingh/Documents/INSTITUTES\ COURSES/Analytics/datasets_/')
library(ggplot2)
data(diamonds)
head(diamonds)
# Histograms 
# Categoriacal variable : bar chart 
# Continous ariable : Histogram 
qplot(cut, data=diamonds) # bar chart

qplot(carat, data=diamonds) # Histogram
qplot(carat, data=diamonds, binwidth=0.01)
qplot(carat, data=diamonds, binwidth=0.1)
qplot(carat, data=diamonds, binwidth=1)

resolution(diamonds$carat) # returns resolution
last_plot() + xlim(0,3) # providing x-axis limit

###############################
Always experiment with bin width
###############################
qplot(table, data=diamonds, binwidth=1)

#To zoom in on a plot region use xlim() and ylim()
qplot(table, data=diamonds, binwidth=1)+
  xlim(50,70) + ylim(0,50)
# Note that this type of zooming discards data outside of the plot regions
See coord_cartesian() for alternative
############################################


############################
Additional Variables 
############################
As with scatterplot you can aesthetics or faceting.
Usign aesthetics creates pretty, but ineffective plots

The following show the difference, when investigating 
the relationship between cut and depth.
####----------
qplot(depth, data=diamonds, binwidth=0.2)
qplot(depth, data=diamonds, binwidth=0.2,
      fill=cut) + xlim(55, 65) # Fill is te aesthetic for fill color


qplot(depth,data=diamonds, binwidth=0.2) +
      xlim(55, 70) + facet_wrap(~cut)

# your turn: Explore the distribution of price.
# how does it vary with colour, or cut ?
# Practice zooming in on reqions of interest.

qplot(price, data=diamonds, binwidth=0.2) +
  facet_grid(color ~ cut)



############################# 
        PROBLEMS 
# Each Hitogram for away form the others, but we know stacking ishrd to read _.
# use another way of displaying densities
# varying relative abundance makes comparisons difficult -> rescale to ensure constant area.
#############################

# Large distances make comparisons hard
qplot(price, data=diamonds, binwidth = 500) + 
  facet_wrap(~cut)

#Stacked heigts hard to compare.
qplot(price, data=diamonds, binwidth=500, fill=cut)

#Much better but still have differing relative abundance
qplot(price, data=diamonds, binwidth = 500,
      geom = "freqpoly", colour=cut)

# Instead of displaying count on y-axis, display density
# .. indicates that variable isn't in original data.
qplot(price, ..density.., data=diamonds, binwidth=500,
      geom="freqpoly", colour=cut)

# To use histogram, you need to be explicit.
qplot(price, ..density.., data=diamonds, binwidth=500,
      geom="histogram") + facet_wrap(~cut)

#################
YOUR TURN
# Explore relationship between price and cut,
# carat and cut
#################

qplot(carat, data=diamonds, binwidth=0.2,
      geom="freqpoly", colour=cut)


##########################################
      Revision: Interpretation
- Global patterns
- Local patterns
- Deviations
##########################################

# There are two ways to add additional geoms
# 1) A vector of geom names:
qplot(price, carat, data=diamonds,
      geom=c('point', 'smooth'))
# Add on extra geoms
qplot(price, carat, data=diamonds) + geom_smooth()


#to set aesthetics to a particular value, you need to 
# wrap that value in I().
qplot(price, carat, data=diamonds, colour="blue")
qplot(price, carat, data=diamonds, colour=I("blue"))

# Pratical applications varying alpha
#alpha -------
qplot(price, carat, data=diamonds, alpha=I(1/10))
qplot(price, carat, data=diamonds, alpha = I(1/250))
qplot(carat, price, data=diamonds,  colour=clarity)

# logs() ----------
qplot(log10(carat), log10(price), data=diamonds, colour=clarity)
qplot(log10(carat), log10(carat/price), 
      data=diamonds, colour=clarity)

#geom=hex $ facet_wrap() -------------
qplot(log10(carat), log10(price), data=diamonds,
      geom="hex", bins=50) + 
  facet_wrap(~cut)

qplot(carat, price, data=diamonds,
      geom="hex", bins=100) + 
  facet_wrap(~cut)

#geom_smooth("lm) --------------
qplot(log10(carat), log10(price), data=diamonds, colour=cut,
      geom="blank") +
  geom_smooth(method="lm")
  
# geom("bin2d) on Linear model
mod <- lm(log10(price) ~ log10(carat), data=diamonds)
qplot(log10(carat), log10(price), data=diamonds,
      geom="bin2d", colour=I("blue")) +
  facet_wrap(~ cut) + 
  geom_abline(intercept=coef(mod)[1], 
              slope = coef(mod)[2], size=1, colour="red")


############################ BOXPLOTS ---------------------------
Less information thatn histogram, but take up much less space.

Already seen them used with discrete x values. Can also use with continous x values, 
Can also use with continous x values, by specifying how we want the data grouped.
############################
qplot(table, price, data=diamonds)
qplot(table, price, data=diamonds, geom="boxplot")
qplot(table, price, data=diamonds, geom="boxplot", group=round(table)) # One Boxplot for each unique value







