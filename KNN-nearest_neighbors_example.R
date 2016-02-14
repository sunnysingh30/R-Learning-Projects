rm(list=ls())
library(class)

cancer <- read.csv('/Users/sunnysingh/Documents/INSTITUTES\ COURSES/Datasets/prostrate_cancer.csv', header=T, stringsAsFactors = F)
str(cancer)

cancer <- cancer[,-1]
head(cancer)

table(cancer$diagnosis_result)
cancer$diagnosis <- factor(cancer$diagnosis_result, levels=c('B', 'M'), labels = c("Benign", "Malignant"))

normalize <- function(x){
  return ((x - min(x)) / (max(x) - min(x)))
}

cancer_n <- as.data.frame(lapply(cancer[,2:9], normalize))
cancer_n$diagnosis_result <- cancer$diagnosis_result
head(cancer_n)

#sample train and test data set
set.seed(123)
ind <- sample(2, nrow(cancer_n), replace=T, prob=c(0.7, 0.3))
train_can <- cancer_n[ind == 1,]
test_can <- cancer_n[ind==2,]

train_can <- train_can[,-9]
test_can <- test_can[,-9]

cancer_train_labels <- train_can[1:nrow(train_can),9]
cancer_test_labels <- test_can[1:nrow(test_can),9]


# Train models --------------------------
mod_pred <- knn(train=train_can, test=test_can, cl=cancer_train_labels, k=10)

#Evaluate model performance -----------------
install.packages("gmodels")
library(gmodels)

CrossTable(x=cancer_test_labels, y=mod_pred, prop.chisq = F)

nrow(test_can)