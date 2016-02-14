####################################################
Missing Data: Advanced methods.
####################################################

- Tabulating missing data. 

install.packages("VIM")
data("sleep", package='VIM')
library(mice)
md.pattern(sleep) # 0- missing / 1 non-missing


# Visually exploring missing data:
aggr(), matrixplot(), scatMiss()

library('VIM')
aggr(sleep, prop=F, numbers=T)
matrixplot(sleep)
marginplot(sleep[c('Gest', 'Dream')], pch=c(20),
           col=c('darkgray', 'red', 'blue'))

# Using correlations to ecxplore missing values.
- Replace data in dataset with indicator variables, 
  codes 1 for missing and 0 for present.
- Resultant matrix is called shadow matrix.
- Correlatng indicator variables with each other and
  with original(observed) variables can help you see 
  which variables tend to be missing together, as well
  as relationships between a variables missingness and the values 
  of other variables.

  x <- as.data.frame(abs(is.na(sleep)))
  
  cor(x)
  cor(sleep, x, use='pairwise.complete.obs')
  