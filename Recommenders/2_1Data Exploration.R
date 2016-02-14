#### Visualizing the matrix
We can visualise the matrix by building a heat map whose colors represent the
ratings. 
Each row of matrix corresponds to user, each column to a movie and each cell to rating.
############################

image(MovieLense, main="Heatmap of rating matrix")
# We can observe white area in th top right. Reason is taht te row and col are sorted.

image(MovieLense[1:10, 1:15], main="heat map of top 10 rows & col")
# some users saw more movies than others. 
What if we select most relevant users and items ?
means visualizing only users who have seen many movies 
and the movies that have been seen by many users:
  - Determine minimum num of movies per user.
  - Determine minimum num of users per movie.
  - Select the users and movies matching these criteria.

For instance, we can visualize op percentile of users & movies. In order to do this 
we use quantile function:
min_n_movies <- quantile(rowCounts(MovieLense), 0.99)
min_n_users <- quantile(colCounts(MovieLense), 0.99)

image(
  MovieLense[rowCounts(MovieLense) > min_n_movies, 
             colCounts(MovieLense) > min_n_users]
, main="Heatmap of the top users and movies")







