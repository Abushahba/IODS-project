# This is the Data wrangling for the next week's data! by Author: Ahmed Abushahba, 29/11/2017, let's import our data sets

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables.

str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

# rename the variables with (shorter) descriptive names

fix(hd)

names(hd)

fix(gii)

names(gii)

# Mutate the "Gender inequality" data and create two new variables. The first one should be the ratio of Female and Male populations with
# secondary education in each country. (i.e. edu2F / edu2M). The second new variable should be the ratio of labour force participation of females and males in each country 
#(i.e. labF / labM).

gii <- mutate(gii, edu2F_edu2M = (popu_sec_edu_fem/popu_sec_edu_male))
gii <- mutate(gii, labF_labM = (lab_force_partic_femal/lab_force_partic_male))

colnames(gii)


# Join together the two datasets using the variable Country as the identifier. 
# Keep only the countries in both data sets. The joined data should have 195 observations and 19 variables.
# Call the new joined data "human" and save it in your data folder.

hd_gii <- inner_join(hd, gii, by = "country") 

str(hd_gii)

glimpse(hd_gii)

human <- hd_gii

write.csv(human, file="C:/Users/ahmed/Desktop/IODS-project/data/human.csv")

