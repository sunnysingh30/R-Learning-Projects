# Epxloring ggplot2 part-1

library(ggplot2)
library(dplyr)
attach(mtcars)
str(mtcars)
mtcars <- tbl_df(mtcars)
glimpse(mtcars)

ggplot(mtcars, aes(x=cyl, y=mpg))+
  geom_point()

# Above wasn't satisfying. Even cyl is categoric is classified as numeric
# you have to explicitly tell ggplot that cyl is categorical.

ggplot(mtcars, aes(x=factor(cyl), y=mpg))+
  geom_point()

############################################################
Grammar of Graphics
- Plottign Framework
- Leland Wilinkinson, Grammar of Graphics, 1999
- 2 principles:
  Graphics = distinct layers of grammatical elements
  Meaningful plots through aesthetic mapping
Essenyial grammatical elements:
  Data.
  Aesthetics : The scales onto whoch we map our data.
  Geometries : The visual elements used for our data. 
  Facets : Plotting small multiples.
  Statistics : Representations of our datato aid unerstanding.
  Coordinates : Coordinates The space on which data will be plotted. 
  Themes : All non-data ink.
############################################################
#Course 1: 1st 3 Layers
#Course 2: Remaining 4 layers

# Scatter plot
  ggplot(mtcars, aes(x=wt, y=mpg)) +
    geom_point()

# colour should be dependent on the displacement of the car engine
  ggplot(mtcars, aes(x=wt, y=mpg, col=disp))+
    geom_point()

# the size should be dependent on the displacement of the car engine
ggplot(mtcars, aes(x=wt, y=mpg, size=disp, col=disp))+
  geom_point()

# What is an error
# shape cannot be defined on continous var scale
ggplot(mtcars, aes(x=wt, y=mpg, shape=cyl)) +
  geom_point()


######################################################
  LAYERS:
- Data, is the first layer.
- Aesthetics, is the 2nd layer in the grammer of graphics
- Geometries, define how the plot will look.
- Facets, dictates how to spread our plots. 
- Statistics, calculate and add many different param, eg: lm
- Coordinates, allows to specify dimensions
- Theme, 
######################################################

str(diamonds)
# Add point and smooth
ggplot(diamonds, aes(x=carat, y=price)) +
  geom_point() +
  geom_smooth()

# Show only the smooth line
ggplot(diamonds, aes(x=carat, y=price)) +
  geom_smooth()

# Above but colour according to 'clarity'
ggplot(diamonds, aes(x=carat, y=price, col=clarity))+
  geom_smooth()

# Keep the color settings from previous command. Plot only the points with argument alpha.
ggplot(diamonds, aes(x=carat, y=price, col=clarity))+ 
  geom_point(alpha=0.4)



#############################################
  Understanding grammer, part1 
Here we explore some of the different grammatical elements. 
Throughout this course we'll discover how they can be combined
in all sorts of ways to develop unique plots.

In the following instructions, you'll 
start by creating a ggplot object from the diamonds dataset. Next, you'll add layers onto this object to build beautiful plots.'
#############################################

# Create the object containing the data and aes layers: dia_plot
dia_plot <- ggplot(diamonds, aes(x=carat, y=price))
# Add a geom layer with + and geom_point()
dia_plot + geom_point()
# Add the same geom layer, but with aes() inside
dia_plot + geom_point(aes(col=clarity))



#############################################
Understanding grammer, part - 2 

Continuing with the previous exercise, here we'll explore mixing
arguments and aesthetics in a single geometry.
We're still working on the diamonds dataset.
#############################################
set.seed(1)
# The dia_plot object has been created for you
dia_plot <- ggplot(diamonds, aes(x = carat, y = price))

# Expand dia_plot by adding geom_point() with alpha set to 0.2
dia_plot <- dia_plot + geom_point(alpha=0.2)

# Plot dia_plot with additional geom_smooth() with se(error shading) set to FALSE
dia_plot + geom_smooth(se=F)

# Copy the command from above and add aes() with the correct mapping to geom_smooth()
dia_plot + geom_smooth(aes(col=clarity), se=F)
















