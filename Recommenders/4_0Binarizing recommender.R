######################### 
Binarizing the data 
Some recommendation models work on binary data, so we might want
to binarize our data, table containing 0s and 1s.
 0s - treated as missing values or as bad ratings.

- Define matrix having 1 if the user rated the movie, and 0 otherwise.
  In this case, we are losing information about the rating.
- Define matrix having 1 if the ratign is above or equal to a definit 
  threshold, and 0 otherwise. In this case, giving a bad rating to a movie.
############################################################
library(recommenderlab)  
data("MovieLense")
rat_mov <- MovieLense[rowCounts(MovieLense) >50,
                      colCounts(MovieLense) >100]


  rat_mov_watched <- binarize(rat_mov, minRating = 1)

  min_mov_bin <- quantile(rowCounts(rat_mov), 0.95)
  min_usr_bin <- quantile(colCounts(rat_mov), 0.95)
  
  image(rat_mov_watched[rowCounts(rat_mov_watched) > min_mov_bin,
                        colCounts(rat_mov_watched) > min_usr_bin],
        main="Heatmap of top users ad movies")
# Only few are white cells cz we selected only top user and movies.
  
# Lets' visualise other binary matrix with threshold >= 3
  rat_mov_gd <- binarize(rat_mov, minRating = 3)
  image(rat_mov_gd[rowCounts(rat_mov) > min_mov_bin,
                   colCounts(rat_mov) > min_usr_bin],
        main="heatmap of top users and movies")  
