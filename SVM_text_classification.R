#########################################################
  How to prepare data for text classificaion ?
#########################################################

setwd('/Users/sunnysingh/Documents/INSTITUTES\ COURSES/Analytics/datasets_/')
list.files()
dt <- read.csv(paste('sunnyData.csv', sep = ""), header=T)
dt
# Convert data to document term matrix
# Using RTextTools package:
# Create the document term matrix
install.packages("RTextTools")
library(RTextTools)
dtmatrix <- create_matrix(dt['Text'])

# Create and train the SVM model
# First put the dataset in the container
container <- create_container(dtmatrix, dt$IsSunny, trainSize = 1:11, virgin=F)
# Train a SVM Model
model <- train_model(container, 'SVM', kernel='linear', cost=1)


# new data
predictionData <- list("sunny sunny sunny rainy rainy", "rainy sunny rainy rainy", "hello", "", "this is another rainy world")


# create a prediction document term matrix
predMatrix <- create_matrix(predictionData, originalMatrix=dtmatrix)
# 
trace("create_matrix",edit=T)

# create the corresponding container
###################################################
Two things are different:
- we use a zero vector for labels, because we want to predict them
- we specified testSize instead of trainingSize so that the data will be used for testing
####################################################
predSize = length(predictionData)
predictionContainer <- create_container(predMatrix, labels=rep(0,predSize), testSize=1:predSize, virgin=FALSE)

# predict
results <- classify_model(predictionContainer, model)
results
