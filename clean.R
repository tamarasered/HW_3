#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
raw_data <- read.csv('raw_data.csv')
####################################

## PART B.1: Creating a new data frame with rows that are NOT na in likelihood to recommend column.
clean_data <- raw_data [!is.na(raw_data$Likelihood_Recommend_H),] 

# PART B.2: By deducting the difference in lengths of vectors of likelihood to recommend columns of
# two raw and clean data we may see the difference of how many rows have been eliminated.
length(raw_data$Likelihood_Recommend_H) - length(clean_data$Likelihood_Recommend_H)
## end your R code and logic 

####################################
##### write output file ############
write.csv(clean_data, file = 'clean_data.csv')
####################################

