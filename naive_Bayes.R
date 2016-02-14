##################################################
   introduction to Naive Bayes classification
- The calssification problem is to figure out affiliation from knowledge of 
voting patterns.
##################################################

library(mlbench)
dt <- HouseVotes84

plot(dt[,2]) # vote cast for issue 1
plot(dt[dt$Class=='republican',2]) # Vote cast for republican
plot(dt[dt$Class == 'democrat', 2])



# Creatign function to impute NA values 
# function to return number of NA values by vote and class
na_by_col_class <- function(col, cls){
  return(sum(is.na(dt[,col]) & dt$Class == cls))
}   

# function to compute conditionl probability that a number of party will cast
# a 'yes' vote for particular issue. Ignore 'na' values.
p_y_col_class <- function(col, cls){
  sum_y <- sum(dt[,col] == 'y' & dt$Class == cls, na.rm=T)
  sum_n <- sum(dt[, col] == 'n' & dt$Class == cls, na.rm = T)
  return(sum_y/(sum_y+sum_n))
}

na_by_col_class(2, 'democrat')
p_y_col_class(2, 'democrat')
p_y_col_class(2, 'republican')


# Imputing missing values.
for(i in 2:ncol(dt)){
if(sum(is.na(dt[,i]))>0){
  c1 <- which(is.na(dt[,i]) & dt$Class == 'democrat', arr.ind = T)
  c2 <- which(is.na(dt[,i]) & dt$Class == 'republican', arr.ind = T)
  
  dt[c1, i] <- 
    ifelse(runif(na_by_col_class(i, 'democrat')) < p_y_col_class(i, 'democrat'), 'y', 'n')
  dt[c2, i] <-
    ifelse(runif(na_by_col_class(i, 'republican')) < p_y_col_class(i, 'republican'), 'y', 'n')
  }
}


# Divide in train and test data sets.
dt[, 'train'] <- ifelse(runif(nrow(dt)) <0.8, 1, 0)
trcolnum <- grep('train', names(dt))
train_ <- dt[dt$train==1, -trcolnum]
test_ <- dt[dt$train == 0, -trcolnum]

# Load e1071 package 
library(e1071)
nb_mod <- naiveBayes(Class~., data=train_)
nb_mod
summary(nb_mod)
str(nb_mod)


nb_test_pred <- predict(nb_mod, test_[,-1])
# confusion matrix
table(pred = nb_test_pred, true=test_[,1])

# fraction of correct prediction.
mean(nb_test_pred == test_$Class)


# Function to create, run and record model results.
nb_mutiple_runs <- function(train_frac, n){
  frac_corr <- rep(NA,n)
  for(i in 1:n){
  dt[,'train'] <- ifelse(runif(nrow(dt))< train_frac, 1, 0)
  tr_colnum <- grep('train', names(dt))
  train_ <- dt[dt$train == 1, -trcolnum]
  test_ <- dt[dt$train == 0, -trcolnum]
  
  nb_mod <- naiveBayes(Class~., data=train_)
  nb_test_pred <- predict(nb_mod, test_[,-1])
  frac_corr[i] <- mean(nb_test_pred == test_$Class)
  }
  return(frac_corr)
}

frac_corr_pred <- nb_mutiple_runs(0.8, 20)
summary(frac_corr_pred)
sd(frac_corr_pred)