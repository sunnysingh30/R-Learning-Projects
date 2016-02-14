library(recommenderlab)
set.seed(1)

dt <- data(package = "recommenderlab")
dt$results

data("MovieLense")
MovieLense # sparse matrix

# Explore MovieLense dataset.
class(MovieLense)

methods(class=class(MovieLense)) # 
head(colSums(MovieLense),3)

object.size(as(MovieLense, 'matrix'))/
  object.size(MovieLense)
object.size(MovieLense)


#Computing the similarity 
similarity_u <- similarity(MovieLense[1:4,],
              method='cosine', which='users')

as.matrix(similarity_u)
image(as.matrix(similarity_u))

# similar items
similarity_i <- similarity(MovieLense[,1:4], 
                  method='cosine', which='items')

as.matrix(similarity_i)
image(as.matrix(similarity_i))


# recommendation models 
rm <- recommenderRegistry$get_entries(dataType = 
                        'realRatingMatrix')

lapply(rm, '[[','description')
rm$IBCF_realRatingMatrix$parameters # checking parameters of the recommender model
rm$PCA_realRatingMatrix$parameters
browseVignettes(package='recommenderlab')



