####################################
# Boosting in R
install.packages("gbm")
library(gbm)
rm(list=ls())

set.seed(12)
data("iris")
samp <- iris[sample(nrow(iris)),]
train <- samp[1:105,]
test <- samp[106:150,]

?gbm
model <- gbm(Species~., data=train, distribution = "multinomial", n.trees = 1000, 
             interaction.depth = 4)
summary(model)
head(test)
pred <- predict(model, newdata = test[,-5], n.trees = 1000)

head(pred)
pred[1:5,,]
p.pred <- apply(pred, 1, which.max)


library(caret)
?train


######################### random forest
names(train)
form <- Crop_Damage ~ .
library(randomForest)
library(rattle)

rf <- randomForest(form, data=train[,-1], ntree=800, mtry=3)
pre_t <- predict(rf, newdata=train, type='class')
table(pred=pre_t , true=train$Crop_Damage )
(73604+4834+160)/nrow(train)

pre_ts <- predict(rf, newdata=test, type='class')
levels(pre_ts) <- c(0,1,2)

test$Crop_Damage <- pre_ts
sub <- test[,c(1,10)]
write.csv(sub, file='sub_rf.csv', row.names = F)

?svm

############################ 
library(e1071)
sv_mod <- svm(form, data=train[,-1], scale=T)
?svm



library(parallel)
# Cal no. of cores
no_cores <- detectCores() - 1
# Initiate cluster
cl <- makeCluster(no_cores)

sv_mod <- svm(form, data=train[,-1], scale=T)
pred_sv <- predict(sv_mod, newdata=train[,c(-1,-10)])

table(pred=pred_sv, true=train$Crop_Damage)

pred_sv = predict(sv_mod, newdata = test[,-1], type='class')
levels(pred_sv) <- c(0,1,2)

test$Crop_Damage <- pred_sv
sub <- test[,c(1,10)]
head(sub)

write.csv(sub, file='sv_sub.csv', row.names = F)

