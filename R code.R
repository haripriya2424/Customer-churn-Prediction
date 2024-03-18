#Reading the dataset into the Rstudio
TelcoData <- read.csv("Telco Dataset.csv")

#Checking the dataset for any missing values
str(TelcoData)
sapply(TelcoData, function(x) sum(is.na(x)))

#The TotalCharges have 11 NA's!
#The rows which have NA's are considered.
TelcoData[is.na(TelcoData$TotalCharges),]

#The proportion of the missing valued rows in the entire dataset
sum(is.na(TelcoData$TotalCharges))/nrow(TelcoData)

#The proportion is negligible and remove all the 11 rows that contain the missing values.
TelcoData_clean <- na.omit(TelcoData)

#checking for the leftover missing values if any
TelcoData_clean[is.na(TelcoData_clean$TotalCharges),]
sapply(TelcoData_clean, function(x) sum(is.na(x)))

#importing library plyr to use the mapvalues function
library(plyr)

#The SeniorCitizen variable is coded 0,1 rather than yes/no. Recoding interpretation for later.
TelcoData_clean$SeniorCitizen <- as.factor(mapvalues(TelcoData_clean$SeniorCitizen,
                                                 from=c("0","1"),
                                                 to=c("No", "Yes")))

#The MultipleLines variable is dependent on the PhoneService variable.
#Recoding the "No phone service" response to "No" for the Multiple Lines variables to ease modeling.
TelcoData_clean$MultipleLines <- as.factor(mapvalues(TelcoData_clean$MultipleLines, 
                                                 from=c("No phone service"),
                                                 to=c("No")))

#Similiarly, Multiple variables are dependent on the OnlineService variable. 
#Recode the responses from "No internet service" to "No" for these variables.
for(i in 10:15){
  TelcoData_clean[,i] <- as.factor(mapvalues(TelcoData_clean[,i],
                                         from= c("No internet service"), to= c("No")))
}
