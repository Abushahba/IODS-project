# Author: Abushahba in 22/11/2017, data set preparation from the UCI Machine Learning Repository, Student Performance Data (incl. Alcohol consumption) 

# Read both student-mat.csv and student-por.csv into R (from the data folder) and explore the structure and dimensions of the data.

student_mat <- read.csv("C:/Users/ahmed/Desktop/IODS-project/data/student-mat.csv", header = TRUE)

student_por <- read.csv("C:/Users/ahmed/Desktop/IODS-project/data/student-por.csv", header = TRUE)

str(student_mat)

dim(student_mat) #showing that student_mat data frame holds 395 obs. of  33 variables 

colnames(student_mat)

glimpse(student_mat)

tbl_df(student_mat) %>% View()

str(student_por)

dim(student_por) #showing that student_mat data frame holds 649 obs. of  33 variables

colnames(student_por)

glimpse(student_por)

# Joining the two data sets using some variables

install.packages("dplyr")
library(dplyr)

join_by <- c("ï..school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

math_por <- inner_join(student_mat, student_por, by = join_by)

# Explore the structure and dimensions of the joined data;showing so far we have 385 obs. of 53 variables

str(math_por)

dim(math_por)

colnames(math_por) # shows how we have duplicated columns from the two frames

# to combine the 'duplicated' answers in the joined data, create a new data frame with only the joined columns (ojc)

ojc <- select(math_por, one_of(join_by))

dim(ojc)

# likewise; the columns in the datasets which were not used for joining the data (notjc) are

notjc <- colnames(student_mat)[!colnames(student_mat) %in% join_by]
notjc

# for every column name not used for joining...
for(column_name in notjc) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the ojc data frame
    ojc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the ojc data frame
    ojc[column_name] <- first_column
  }
}

glimpse(ojc)

dim(ojc)

# Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data. 
ojc <- mutate(ojc, alc_use = (Dalc + Walc)/2)

glimpse(ojc)

# create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2
ojc <- mutate(ojc, high_use = (alc_use > 2))

# The joined data should now have 382 observations of 35 variables.

glimpse(ojc)

dim(ojc)

write.csv(ojc, file = "C:/Users/ahmed/Desktop/IODS-project/data/joined data set for analysis.csv")

