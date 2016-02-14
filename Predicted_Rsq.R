################################
Predicted R-squared
################################

rm(list=ls())

library(dplyr)
crimes <- tbl_df(UScrime) 
colnames(crimes)
glimpse(crimes)

mod <- lm(y~U1+U2+Ed+Ineq, data=crimes)
summary(mod)

pr <- resid(mod)/(1 - lm.influence(mod)$hat)
press <- sum(pr^2)
press


man <- anova(mod)
man
tss <- sum(man$`Sum Sq`)

pred_r_squared <- 1- (press/tss)





################################
dt <- iris
head(iris)

library(cluster)
library(ggplot2)

dt$Species <- as.numeric(iris$Species)
cost_df <- data.frame()
for(i in 1:200){
  km <- kmeans(dt, centers = 5, iter.max = 50)
  cost_df <- rbind(cost_df, cbind(i,km$tot.withinss))
}

head(cost_df)
nrow(dt)

names(cost_df) <- c('cluster', 'cost')

ggplot(cost_df, aes(x=cluster, y=cost, group=1)) +
  #theme_bw(base_family = "Garamond") +
  geom_line(colour="darkgreen") 


###############################
library(e1071)
data(iris)
sample = iris[sample(nrow(iris)),]
train = sample[1:105,]
test = sample[106:150,]
tune =tune(svm,Species~.,data=train,kernel
           ="radial",scale=FALSE,ranges =list(cost=c(0.001,0.01,0.1,1,5,10,100)))
tune$best.model

best.tune(method = svm, train.x = Species ~ ., data = train, ranges =
            list(cost = c(0.001,
                          0.01, 0.1, 1, 5, 10, 100)), kernel = "radial", scale = FALSE)


