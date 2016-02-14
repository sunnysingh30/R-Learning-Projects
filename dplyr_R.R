rm(list=ls())
# dplyr for faster data manipulation

#load packages
library(dplyr)
install.packages("hflights")
library(hflights)

data(hflights)
head(hflights)

# tbl_df creates local data frame
flights <- tbl_df(hflights)
print(flights, n=20)

# convert normal data frame 
data.frame(head(flights))


# Filter: Keep rows matching criteria
# --------Base R approach 
flights[flights$Month == 1 & flights$DayofMonth == 1,]
# --------dplyr approach
# Can use Comma or Ampersand for and condition and '|', pipe symobol for OR operation. 
filter(flights, Month==1, DayofMonth == 1)
filter(flights, UniqueCarrier == "AA" | UniqueCarrier == "UA")


#SELECT : Pick columns by name
# Base R approach
flights[, c("DepTime", "ArrTime", "FlightNum")]
# dplyr approach
select(flights, DepTime, ArrTime, FlightNum)
# Use ':' to select multiple columns and 'contains() to match column by name
# note: starts_with, ends_with and matches for regular expression can also be used 
# to match  columns by name.
select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay"))



# "Chaining" or "Pipelining" 
filter(select(flights, UniqueCarrier, DepDelay), DepDelay > 60)
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  filter(DepDelay > 60)


# ----- Calculate euclidean distance between them
x1 <- 1:5; x2 <- 2:6
sqrt(sum((x1-x2)^2))

OR

(x1-x2)^2 %>% sum() %>% sqrt()



############## ------- ARRANGE : Reorder 
#base R approach 
flights[order(flights$DepDelay), c("UniqueCarrier", "DepDelay")]
#dplyr approach

flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(DepDelay)

# Use descending order
flights %>% 
  select(UniqueCarrier, DepDelay) %>%
  arrange(desc(DepDelay))


# Mutate: Add new variables
# Base R approach 
flights$Speed <- flights$Distance / flights$AirTime*60
flights[,c("Distance", "AirTime", "Speed")]
#dplyr appraoch 
# --- prints the new variable but does not store it
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  mutate(flights$Distance/flights$AirTime*60)

# ------ Stores the new variable
flights <- flights %>% mutate(Speed = Distance/AirTime*60)


########### ----------- SUMMARISE: Reduce variables to values
# group_by:  creates the groups that will be operated on 
# summarise : uses provide aggregation function to summarise each group 
#summarise_each : allows you to apply the same summary function to multiple columns at once.
# mutate_each : is also available.
#base R approach 
colnames(flights)
head(aggregate(ArrDelay ~ Dest, flights, mean))

# dplyr approach :
flights %>% 
  group_by(Dest) %>%
  summarise(avg_delay = mean(ArrDelay, na.rm=T))

colnames(flights)
unique(flights$Cancelled)
head(flights$Cancelled, 3)

#   for each carrier, calculate % of flights cancelled and diverted.
flights %>% 
  group_by(UniqueCarrier) %>%
  summarise_each(funs(mean), Cancelled, Diverted)

# for each carrier, the minimum and maximum arrival and departure delays.
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(min(., na.rm=T), max(.,na.rm=T)), matches('Delay'))

# ------- HELPER FUNCTION n() counts the number of rows in group 
# helper function n_distinct(vector) counts the number of unique items in that vector.
# For each day of the year count the total number of flights and sort in ascending order.
colnames(flights)

flights %>%
  group_by(Month, DayofMonth) %>%
  summarise(flight_count = n(), flight_unique_count=n_distinct(TailNum)) %>%
  arrange(desc(flight_count,flight_unique_count))

# Rewrite above more simply with TALLY() function for n() 
flights %>%
  group_by(Month, DayofMonth) %>%
  tally(sort=T)
  
# For each destination, count total number of flights and numbe of distinct planes tha flew there
flights %>%
  group_by(Dest) %>%
  summarise(flight_count=n(), distinct_planes=n_distinct(TailNum))

  
# for each destination, show te number of cancelled and not cancelled flights
flights %>%
  group_by(Dest) %>%
  select(Cancelled) %>%
  table()

# for each carrier, calculate which 2 days of the year they had their longest 
# departure delay 
# note: smallest value is ranked as '1'. so you have to use desc() to rank by largest value.
flights %>%
  group_by(UniqueCarrier) %>%
  select(Year, Month, DayofMonth, DepDelay) %>%
  filter(min_rank(desc(DepDelay)) <= 2) %>%
  arrange(UniqueCarrier, desc(DepDelay))

# rewrite above more simply with 'top_n' function
flights %>%
  group_by(UniqueCarrier) %>%
  select(Year, Month, DayofMonth, DepDelay) %>%
  top_n(2) %>%
  arrange(UniqueCarrier, desc(DepDelay))

# for each month, calculate the number of flights and change from previous month
flights %>%
  group_by(Month) %>%
  summarise(flight_count = n()) %>%
  mutate(change = flight_count - lag(flight_count))

# rewrite the above more simply with 'tally()' function
flights %>%
  group_by(Month) %>%
  tally() %>%
  mutate(change = n - lag(n))


############ --------------------------------------
############ --------------------------------------
#Other Usefull Convinience functions

# randomly sample fixed number of rows, without replacement 
flights %>% sample_n(5)
#randomly sample fraction of rows with replacement
flights %>% sample_frac(0.25, replace=T)

# base R approach to view structure fo an object
str(flights)
# dplyr approach to view structure of an object: better formatting, and adapts to your screen width
glimpse(flights)



############ --------------------------------------
############ --------------------------------------
# Connecting to the database.







