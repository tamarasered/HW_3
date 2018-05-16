#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
clean_data <- read.csv('clean_data.csv')
####################################

## start writing your R code from here

# Part E:Generate a Map of the USA, where the color of the state represents 
# the average LTR for people from that state. Use tapply to generate 
# the average ltr for each state. Hint: Create a subset dataframe, with only 
# surveys of US hotels. Hint 2: it’s not where the hotel is located, it’s 
# where the person is who made the reservation

# First we need to have data with only USA information. For that we need to 
# keep only those rows where GUEST_COUNTRY_R is UNITED STATES.
usa_clean_data <- clean_data [clean_data$GUEST_COUNTRY_R == "UNITED STATES",] 
# To make sure there are no blanks in states column for each UNITED STATES row
# we need to clean the data for states as well as follows.
states_clean_data <- usa_clean_data[!is.na(usa_clean_data$STATE_R),]
# We can now proceed with creating the US map.
library(ggplot2)
library(fiftystater)
data("fifty_states")
map_usa_LTR <- ggplot(states_clean_data, aes(map_id = states_clean_data$STATE_R)) +
               geom_map(aes(fill = states_clean_data$Likelihood_Recommend_H), map = fifty_states)

map_usa_LTR

# Part F:	Put three points on the colored map of the US – one for Orlando FL, 
# one for Nashville, TN and one for Burlington VT. Have the points color and
# size based on the average LTR for the hotels in that city.Have the color of 
# the points range from black to red (using ‘scale_colour_gradient’).


## end your R code and logic 

####################################
##### write output file ############
# add your R code to write map_usa_LTR_FL_TN_VT.png
####################################




