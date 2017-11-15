#author: Abushahba, in 13/11/2017, this is exercise 2 initial steps
#Read the full learning2014 data from url; which has 183 observations for 60 variables
learning2014_data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header = TRUE, sep = "\t")
learning2014_data

library(dplyr)


str(learning2014_data)
dim(learning2014_data)

# variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data
learning2014_data$gender
learning2014_data$Age
learning2014_data$Attitude

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_questions

surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#select the columns related to deep learning and create column e.g. "deep" by averaging
deep_columns <- select(learning2014_data, one_of(deep_questions))
head(deep_columns)

learning2014_data$deep <- rowMeans(deep_columns)
head(learning2014_data$deep)

#same for surface and strategic questions
surface_columns <- select(learning2014_data, one_of(surface_questions))
head(surface_columns)

learning2014_data$surf <- rowMeans(surface_columns)
learning2014_data$surf

stra_columns <- select(learning2014_data, one_of(strategic_questions))
head(stra_columns)

learning2014_data$stra <- rowMeans(stra_columns)
learning2014_data$stra

# choose columns to keep
kept_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

#ceate our homework data set lrnhwset
lrn2014hwset <- select(learning2014_data, one_of(kept_columns))
str(lrn2014hwset)

#Exclude observations where the exam points variable is zero

lrn2014hwset <- filter(lrn2014hwset, Points > 0)

#showing the data should then have 166 observations and 7 variables
str(lrn2014hwset)

#Save the analysis dataset as "learning2014_AGA"

?write.csv
write.table(lrn2014hwset, file = "learning2014_AGA.txt")

read.csv(file = "C:/Users/ahmed/Desktop/IODS-project/data/learning2014_AGA.csv")
learning2014_AGA <- read.csv(file = "C:/Users/ahmed/Desktop/IODS-project/data/learning2014_AGA.csv")
str(learning2014_AGA)
head(learning2014_AGA)
