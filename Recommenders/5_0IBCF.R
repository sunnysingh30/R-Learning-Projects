######################################
Item based Collaborative filtering
######################################
Define train and test data sets

set.seed(12)
which_train <- sample(x=c(TRUE, FALSE), replace=T, size=nrow(rat_mov),
                     prob=c(0.8,0.2))

recc_dt_train <- rat_mov[which_train,]
recc_dt_test <- rat_mov[!which_train,]

# We could use k-fold
- Split users in 5 groups as training sets.
- Use a group as test and other groups as training sets.
- Repeat is for each group.

# sample code:
which_set <- sample(x=1:5, size=nrow(rat_mov), replace=T)
for(i in 1:5){
  which_train <- which_set == i
  recc_dt_train <- rat_mov[which_train, ]
  recc_dt_test <- rat_mov[!which_train, ]
  
  #build recommendation model
}


######################################
  Building recommendation model.
######################################
rec_models <- recommenderRegistry$get_entries(dataType='realRatingMatrix')
rec_models$IBCF_realRatingMatrix$parameters

rec_mod <- Recommender(data=recc_dt_train, method='IBCF',
                       parameter=list(k=30))
class(rec_mod)
mod_details <- getModel(rec_mod)
class(mod_details$sim)

# lets build heatmap of above built model of square matrix.
image(mod_details$sim[1:30, 1:30], main='Hetmap of rows and columns')

mod_details$k
row_sum <- rowSums(mod_details$sim >0)
table(row_sum)

# Matrix is not supposed to be symmetric. 
# Lets check distribution of the number of elements by col.

col_sums <- colSums(mod_details$sim > 0)
# Build distribution chart
library(ggplot2)
qplot(col_sums) + stat_bin(binwidth = 1) + 
  ggtitle("Distribution of the column count")
# There are few movies siilar to many others. Lets see 
# which are the movies with the most elements.
which_max <- order(col_sums, decreasing=T)[1:6]
rownames(mod_details$sim)[which_max]


############################################
Apply recommendation on the test data set.
############################################
n_recommend <- 6 # number of items to be reommended.
- Extract user rating for each purchase associated with this item.
  The rating is used as a weight.
- Extract similarity of ite with each purchase associated with this item.
- Multiply each weight with the related similarity.
- Sum everything up.
- Algo identifies top n recommendations:
    
  recc_pred <- predict(rec_mod, newdata=recc_dt_test,
                       n= n_recommend)
recc_pred
class(recc_pred)
slotNames(recc_pred)

recc_user_1 <- recc_pred@items[[1]]
movies_user_1 <- recc_pred@itemLabels[recc_user_1]
movies_user_1


