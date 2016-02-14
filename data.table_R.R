# # 3hr tutorial "DATA.TABLE"
rm(list=ls())
getwd()
setwd('/Users/sunnysingh/Documents/INSTITUTES\ COURSES/Analytics/kaggle/datasets')
list.files()

df <- data.table(x = c('A','B','A','B'), y=c(1:4))

library(data.table)
#Reading datasets
df <- fread("train.csv") # faster than read.csv
head(df)

# Adding new column in data.table by id
df[,new_var:=sum(y), by=x]
head(df)

# delete the column
df[,new_var:=NULL]

# To copy entire 20 GB file
df2 <- copy(df)
df2

#comparing 2 columns
df[y > new_var]
df[new_var > y]


# Sorts the table by colA and then colB
df2 <- setkey(df, new_var, y)
df2


#Search values in the key column 'x'
setkey(df2, x)
df2["B",]
df2["B", mult="first"]
df2["B", mult="last"]

df2["B", sum(y)]
df2["B", sum(y)] > 10

df2[c("A", "B"), sum(y)]

# Adhoc by clause
df2[, sum(y), by=x]

df2[,y%%2]


# Programmatically vary 'by'
bys = list(quote(y%%2),
           quote(x),
           quote(y%%3))

for (i in bys)
  print (df2[, sum(new_var), by=eval(i)])

df2[,sum(new_var) ,keyby=x]



system.time(df2[x=='A'])
system.time(df2["B"])


df2[order(new_var)]

# Multiple ':=' 
df2[, ':='(newCol = mean(y),newcol2=sd(new_var)), by = x ][] # '[]' prints result to the screen
df2[, list(mean(y),sd(new_var)), by = x ]
df2

df2[,print(.SD), by=x]

########### Set functions 
set()
setattr()
setnames()
setcolorder()
setkey()
setkeyv()
setDT()
setorder()



df2[,lapply(.SD, sum),by=x]























