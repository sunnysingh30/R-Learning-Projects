################ Data Preparation & Normalization
# How to prepare the data to be used in recommender model.
# Follow these steps.
- Select the relevant data. 
- Normalize the data.

# Select most relevant data.
 - We observed movies that have been viewed by only few users. The ratings might be biased. 
 - Users who rated only few movies. Their rating might be biased. 

We will rating_matrix containing:
  - Users who have rated at least 50 movies.
  - Movies that have been watched at least 100 times.

rat_mov <- MovieLense[rowCounts(MovieLense) > 50,
                      colCounts(MovieLense) >100]
rat_mov


# Exploring most relevant data
# visualize top matrix
min_mov <- quantile(rowCounts(rat_mov), 0.98)
min_user <- quantile(colCounts(rat_mov), 0.98)

# Heatmap of top users and movies.
image(rat_mov[rowCounts(rat_mov) > min_mov,
              colCounts(rat_mov) > min_user],
      main="Heatmap of top users and movies")


avg_rat_per_user <- rowMeans(rat_mov)
qplot(avg_rat_per_user) + stat_bin(binwidth=0.1) +
  ggtitle("Distribution of the avg rating per user")
# Avg rating varies alot accross different users.

### Normalizing the data 
rat_mov_norm <- normalize(rat_mov)
sum(rowMeans(rat_mov_norm) > 0.01) 

#Visualize normalize data 
image(rat_mov_norm[rowCounts(rat_mov_norm) > min_mov,
                   colCounts(rat_mov_norm) > min_user])

# OBSERVATIONS FROM ABOVE HEATMAP:
- colors beacause the data is continous. 
- ratings were between 1 and 5. After normalization, the rating can be any 
  number between -5 and 5
  
  





