#This is me learning R

#R can be used as a calculator
2+3
5^3
#r also knows the order of operations
5+2^2
(5+2)^2

#Making R objects
weight_kg <- 55
#names cannot have a space, and have to start with a letter
weight_kg

#calculations with objects
weight_kg * 2.2
weight_lbs <- weight_kg * 2.2

#change value of weight_kg
weight_kg <- 100
weight_lbs <- weight_kg * 2.2
#R only updates objects when explicitly told

###########################
#Exercise 1
###################
#A. You have a patient with a height (inches) of 73 and a weight (lbs) of 203. Create r objects labeled 'height' and 'weight'.
height_inches <- 73
weight_lbs <- 203

#B. Convert 'weight' to 'weight_kg' by dividing by 2.2. Convert 'height' to 'height_m' by dividing by 39.37
weight_kg <- weight_lbs / 2.2
height_m <- height_inches / 39.37

#remove object height_inches
rm(height_inches)
height_inches #its gone!

#C. Calculate a new object 'bmi' where BMI = weight_kg / (height_m*height_m)
bmi <- weight_kg / height_m^2
bmi
###################
#Functions
sqrt(144)
log(1000)
#to ask for help type ?function()
?log
log10(1000)
log(1000, base = 10) #label arguments
log(1000, 10)

#nest functions together
sqrt(log(1000, base = 10))

#save intermediate value
mylog <- log(1000, base = 10)
sqrt(mylog)


##################
#Vectors
##################
#c means combine or concatenate
animal_weights <- c(50, 60, 66)
#character vector
animals <- c("cat", "rat", "dog")

#Investigating vectors
length(animal_weights)
length(animals)  

#what type of object?
class(animal_weights)
class(animals)

sum(animal_weights)
#sum(animals) #cannot take sum of characters

#adding onto vectors
animal_weights <- c(animal_weights, 70) #add to end
animal_weights <- c(45, animal_weights) 

#############################
#Dataframes
#############################

#load data using read_csv from readr package
library(tidyverse)
nh <- read_csv("nhanes.csv")
View(nh)

#dimensions
dim(nh)

length(nh) #number columns
nrow(nh) #number rows

str(nh) #structure
class(nh)

nh #printing top looks great because we used read_csv (this is a tibble dataframe)

#the $ calls one variable out of a dataframe
#just get BMI data
nh$BMI

#descriptive stats for BMI
mean(nh$BMI, na.rm = TRUE)
summary(nh$BMI)
sd(nh$BMI, na.rm = TRUE) #standard deviation

#######################
#Exercise 2
#######################

#1. What is the maximum Pulse recorded in our dataset? (hint: get help on the `max` function with `?max`)
max(nh$Pulse, na.rm = TRUE)

#2. What's the standard deviation of Weight (hint: get help on the `sd` function with `?sd`).
sd(nh$Weight, na.rm = TRUE)

#3. What's the range of systolic blood pressure represented in the data? (hint: `range()`).
range(nh$BPSys, na.rm=TRUE)

########################
#dplyr package
library(dplyr) #if you don't have the tidyverse
#for manipulating data

#filter selects for specific rows
#special syntax %>% to mean "THEN"

head(nh)

nh %>% 
  head()

#now with dplyr
#filter for just children (Age < 18)
nh %>%
  filter(Age < 18)

# to combine logical statements:
# AND &
# OR |

#logical operators
#equal to ==
#not equal to !=
#greater than or equal to >=
#less than or equal to <=
#greater than >
#less than <

#filter for obese children
nh %>%
  filter(Age < 18 & BMI >=30)

##############
#Exercise 3
##############
#A. Use `filter()` to find out how many people there are in this dataset who are current smokers (`SmokingStatus == "Current"`)
unique(nh$SmokingStatus) #see all options

nh %>%
  filter(SmokingStatus == "Current")

#summarize = creates a summary statistic
nh %>%
  summarize(mean(BMI, na.rm = TRUE))

nh %>%
  summarize(meanBMI = mean(BMI, na.rm = TRUE))

#group_by = group data into factor levels
unique(nh$SmokingStatus)

nh %>%
  group_by(SmokingStatus) %>%
  class()

#group_by and summarize mean BMI for each smoking status
nh %>%
  group_by(SmokingStatus) %>%
  summarize(meanBMI = mean(BMI, na.rm = TRUE))

##############
#Exercise 4
###############
# Use `filter()` followed by `group_by()` and `summarize()` to find the mean BMI by Smoking Status for people who have Diabetes.
nh %>%
  filter(Diabetes == "Yes") %>%
  group_by(SmokingStatus) %>%
  summarize(meanBMI = mean(BMI, na.rm = TRUE))

#or group_by both variables
nh %>%
  group_by(SmokingStatus, Diabetes) %>%
  summarize(meanBMI = mean(BMI, na.rm = TRUE))

##############
#ggplot2
###############
library(ggplot2)

#aesthetics takes variables to plot
#geom -- plot type

#Plot Age against Height (continuous X, continuous Y)
nh %>%
  ggplot(aes(x = Age, y = Height)) + geom_point()

#color by Gender
nh %>%
  ggplot(aes(x = Age, y = Height, color = Gender)) + geom_point()

#faceted by Gender
nh %>%
  ggplot(aes(x = Age, y = Height)) + 
  facet_wrap(~ Gender) + geom_point()

#line plot instead of points
nh %>%
  ggplot(aes(x = Age, y = Height, color = Gender)) + geom_smooth(se = TRUE)

?geom_smooth


#marieke@virginia.edu
