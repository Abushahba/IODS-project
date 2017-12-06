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

# To complete the data wrangling part,
# we will continue working on my create_human.R from last week 
# transform the Gross National Income (GNI) variable to numeric
human <- read.csv(file = "C:/Users/ahmed/Desktop/IODS-project/data/human.csv")
human <- human[-1]

str(human$GNI)

# removing commas from GNI and make it numeric

str_replace(human$GNI, pattern=",", replace ="")

is.factor(human$GNI)

human$GNI = as.numeric(human$GNI)
is.numeric(human$GNI)

# Exclude unneeded variables: keep only the columns matching the following
# variable names:  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" 

keep_columns <- c("country", "popu_sec_edu_fem", "lab_force_partic_femal", "exp_year_edu", "life_exp_birth", "GNI", "MMR", "ABR", "parl_repres")
human <- dplyr::select(human, one_of(keep_columns))

# Remove all rows with missing values and remove
# the observations which relate to regions instead of countries
complete.cases(human)

data.frame(human, comp = complete.cases(human))
human_mut <- mutate(human, comp = complete.cases(human))
dim(human_mut)

human_mut <- filter(human, human_mut$comp == TRUE)
human_ <- human_mut

tail(human_, n=10)
humanW <- human_ [1:155,]

# Define the row names of the data by the country names
# and remove the country name column from the data. 

rownames(humanW) <- humanW$country
humanW <- dplyr::select(humanW, -country)

# Save the human data in your data folder 
# including the row names. You can overwrite your old 'human' data

write.csv(humanW, file = "C:/Users/ahmed/Desktop/IODS-project/data/human.csv")

