rm(list = ls())
# Collaborative filtering:
lastfm  <- read.csv('/Users/sunnysingh/Documents/INSTITUTES\ COURSES/Datasets/lastfm-matrix-germany.csv')
lastfm <- lastfm[10:300,c(1, 2:7)]

#Item based collaborative data frame
lastfm.ibf <- (lastfm[,!(names(lastfm) %in% c("user"))])
names(lastfm.ibf)

#Create helper function to measure cosine similarity
getcosine <- function(x, y){
  this.cosine <- sum(x*y) / sqrt(sum(x*x)) * sqrt(sum(y*y))
  return (this.cosine)
}

#Create placeholder for similarity
simi_lastfm <- 
  matrix(, nrow=ncol(lastfm.ibf), ncol=ncol(lastfm.ibf),
         dimnames = list(colnames(lastfm.ibf), colnames(lastfm.ibf)))
simi_lastfm

#Loop to fill the similarity in empty spaces
for(i in 1:ncol(lastfm.ibf)){
  for(j in 1:ncol(lastfm.ibf)){
    simi_lastfm[i,j] <- getcosine(as.matrix(lastfm.ibf[,i]), as.matrix(lastfm.ibf[,j]))
  }
}

simi_lastfm <- as.data.frame(simi_lastfm)
simi_lastfm_nei <- 
  matrix(NA, nrow=ncol(simi_lastfm),ncol=6,dimnames=list(colnames(simi_lastfm)))
simi_lastfm_nei

for(i in 1:ncol(lastfm.ibf)) 
{
  simi_lastfm_nei[i,] <- 
    t(rownames(
      simi_lastfm[order(simi_lastfm[,i],decreasing=TRUE),][i]))
}
