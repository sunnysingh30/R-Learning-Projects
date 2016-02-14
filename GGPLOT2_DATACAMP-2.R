###################################################
  Course - 2 ( GGPLOT2 )
- STATS
- Coordinates
- Facets
- Themes
- Data visualizations Best Practices
- Case Study: California Health Information Surevey
###################################################

# - Statistics Layer :
 Two categories of functions:
  - Called from within geom
  - Called independently
  -stats_ functions


# Smoothing --------------
library(ggplot2)
# Explore the mtcars data frame with str()
str(mtcars)
# A scatter plot with LOESS smooth:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()+
  geom_smooth() # default is LOESS smooth
# A scatter plot with an ordinary Least Squares linear model:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method='lm')
# The previous plot, without CI ribbon:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method='lm', se=F)
# The previous plot, without points:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_smooth(method='lm', se=F)


###### -- Grouping Variables
# ggplot2 is already loaded
# Define cyl as a factor variable
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F)

# Modify the previous plot by setting the group aesthetic. 
# In order to see model for whole group inside aes() to a summary variable, 1:
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl), group=1)) +
  geom_point() +
  stat_smooth(method = "lm", se = F)

# Modify the second plot by adding a second smooth layer in which the group aesthetic is set.
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  geom_smooth(group=1)



######## Modifying Stat_smooth_1
In the previous exercise we saw how to modify the smooth aesthetic by removing the 95%
Confidence Interval. Here we'll consider the span for LOESS smoothing and we'll take a 
look at a nice scenario of how to properly map our different models.
##############################
# Case 1: change the LOESS span with span arfument in geom_smooth():
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(se = F, span=0.7)

# Case 2: Set the overall model to the default LOESS and use a span of 0.7.
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  stat_smooth( se=F, aes(group = 1),
              col = "black",
              span = 0.7)

# Case 3: Set col to "All", inside the aes layer:
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  stat_smooth( se=F, aes(group = 1, col = 'All'),
              span = 0.7)

# Case 4: Add scale_color_manual to change the colors
library(RColorBrewer)
?brewer.pal
myColors <- c(brewer.pal(3, "Dark2"), "black")
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  stat_smooth( se=F, aes(group = 1, col = 'All'),
              span = 0.7) +
  scale_color_manual('Cylinder',values=myColors)  # -------------------------


######## Modifying Stat_smooth_2
# Plot 1: Jittered scatter plot, add a linear model (lm) smooth:
str(Vocab)
ggplot(Vocab, aes(x=education, y=vocabulary)) +
  geom_jitter(alpha=0.2) +
  stat_smooth(method='lm', se=F)
# Plot 2: Only lm, colored by year
ggplot(Vocab, aes(x=education, y=vocabulary, col=factor(year))) +
  stat_smooth(method='lm', se=F)
# Plot 3: Set a color brewer palette
ggplot(Vocab, aes(x=education, y=vocabulary,col=factor(year))) +
  stat_smooth(method='lm', se=F) +
  scale_color_brewer()

# Plot 4: Change col and group, specify alpha, size and geom, and add scale_color_gradient
# year should be taken as numeric in col parameter.
ggplot(Vocab, aes(x = education, y = vocabulary, col = year, group = factor(year)))+
  stat_smooth(method = "lm", se = F, alpha = 0.6, size = 2, geom = "path") +
  scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))



################ Quantile ------------
stat_quantile() to apply a quantile regression (method rq).
By default, the 1st, 2nd (i.e. median), and 3rd quartiles are modeled as a response to 
the predictor variable, in this case education. Specific quantiles can be specified with
the quantiles argument.
####
ggplot(Vocab, aes(x=education, y=vocabulary, col=year, group=factor(year))) +
  scale_color_gradientn(colors=brewer.pal(9, 'YlOrRd')) +
  stat_quantile(quantile=0.5, alpha=0.6, size=2)



############ SUM --------------- stat_sum()
Another useful stat function is stat_sum() which calculates the count for each group.
############
# Plot with linear and loess model
p <- ggplot(Vocab, aes(x = education, y = vocabulary)) +
  stat_smooth(method = "loess", aes(col = "red"), se = F) +
  stat_smooth(method = "lm", aes(col = "blue"), se = F) +
  scale_color_discrete("Model", labels = c("red" = "LOESS", "blue" = "lm"))

# Add stat_sum: (by overall proportion)
p + stat_sum()
  
  # Set size range:
  p + stat_sum() +
    scale_size(range=c(1,10))
  
  # proportional within years of education - set group aesthetic:
  p + stat_sum(aes(group=education))
  
  # Set the n, not the prop:
  p + stat_sum(aes(group=education, size=3))



------------------------------------------------------
    Statistics outside Geoms
#####################################################
  ?diff

diff(1:10)
library(MASS)
str(mammals)
?quantile
quantile(mammals$body)
quantile(mammals$body, c(0.25, 0.75))
diff(quantile(mammals$body, c(0.25, 0.75)))/qnorm(0.25, 0.75)

48.2025 - 0.6000
?qnorm
qnorm(0, 0.50)
