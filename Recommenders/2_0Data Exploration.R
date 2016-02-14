# Data exploration
library(recommenderlab)
library(ggplot2)
data("MovieLense")
class(MovieLense)

# Explorng the nature of the data 
dim(MovieLense)
slotNames(MovieLense)
class(MovieLense)

# Epxloring the values of th rating:
vec_rat <- as.vector(MovieLense@data)
# Thr rating are int in the range 0-5. Lets' count
# the occurance of each of them.

tab_rat <- table(vec_rat)
tab_rat

# removing entries with rating == 0
vec_rat <- vec_rat[vec_rat != 0]

# freq plot oof the rating using ggplot2

vec_rat <- factor(vec_rat)
qplot(vec_rat) + ggtitle("Distribution of ratings") # Most ratings are above 2

# Exploring which movies have been viewed
colcounts: number of non-missing values for each column
colMeans: This is the average value for each column.

views_per_mov <- colCounts(MovieLense)

# sort movies by numer of views:
tab_views <- data.frame(
  movie = names(views_per_mov),
  views = views_per_mov
)

tab_views <- tab_views[order(tab_views$views, decreasing=T),]
head(tab_views,2)

# Starwars is the most viewed movie
ggplot(tab_views[1:6,], aes(x=movie, y=views)) +
  geom_bar(stat="identity") +
  theme(axis.text.x=element_text(angle=35, hjust=1)) +
  ggtitle("Number of views of top six movies")  


###### Exploring average ratigs
avg_rat <- colMeans(MovieLense)

qplot(avg_rat, binwidth=0.1)
qplot(avg_rat) + stat_bin(binwidth = 0.1) +
  ggtitle("Distribution of the average movie rating") # The highest value is around 3 star

# 5- received rating from very few people. So we shouldn't take them into account
avg_rat_rev <- avg_rat[views_per_mov >100]

# Lets build chart : All ratings are between 2.5 and 4.5
qplot(avg_rat_rev) + stat_bin(binwidth = 0.1) +
  ggtitle("Distribution of relevant avg ratings") 















