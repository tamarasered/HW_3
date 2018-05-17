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
usa_clean_data <- clean_data[clean_data$GUEST_COUNTRY_R == "UNITED STATES",] 
# To make sure there are no blanks/nas in states column for each UNITED STATES row
# we need to clean the data for states as well as follows.
states_clean_data <- usa_clean_data[!is.na(usa_clean_data$STATE_R),]
states_clean_data <- states_clean_data[!(states_clean_data$STATE_R == ""),]

# We can now proceed with creating the US map. 
library(ggplot2)
library(ggmap)

#Crearing new data frame 

new_df <- setNames(aggregate(states_clean_data$Likelihood_Recommend_H, by=list(states_clean_data$STATE_R), FUN=mean), c('STATE_R', 'MEAN_LTR'))
new_df$STATE_R <- state.name[match(as.character(new_df$STATE_R), state.abb)]
new_df$STATE_R <- tolower(new_df$STATE_R)

us <- map_data("state")
# Create a new column in us data frame with corresponding matching LTR.
us$MEAN_LTR <- new_df$MEAN_LTR[match(us$region,new_df$STATE_R)]
# Creating the map.
map_usa_LTR <- ggplot(us) + 
  geom_polygon(aes(x = long, y = lat, fill=MEAN_LTR, group = group), color = "black") +
  scale_fill_gradient(low="white", high="green")

map_usa_LTR

# Creating png for the map.
png(filename="map_usa_LTR.png")
map_usa_LTR
dev.off()

# Part F:	Put three points on the colored map of the US – one for Orlando FL, 
# one for Nashville, TN and one for Burlington VT. Have the points color and
# size based on the average LTR for the hotels in that city.Have the color of 
# the points range from black to red (using ‘scale_colour_gradient’).

Locations  <- geocode(c('Orlando FL',  'Nashville TN', 'Burlington VT'))

new_df2 <- setNames(aggregate(states_clean_data$Likelihood_Recommend_H, by=list(states_clean_data$City_PL), FUN=mean), 
                     c('City_PL', 'MEAN_LTR'))
Locations$MEAN_LTR <- c(new_df2$MEAN_LTR[as.character(new_df2$City_PL) == 'Orlando'], 
                        new_df2$MEAN_LTR[as.character(new_df2$City_PL) == 'Nashville'],
                        new_df2$MEAN_LTR[as.character(new_df2$City_PL) == 'Burlington'])

map_usa_LTR_FL_TN_VT <- map_usa_LTR +
  geom_point(data=Locations, aes(x=lon, y=lat, color=MEAN_LTR, size=MEAN_LTR)) +
  scale_colour_gradient(low = 'black', high='red')
map_usa_LTR_FL_TN_VT

# Creating png for the map.
png(filename="map_usa_LTR_FL_TN_VT.png")
map_usa_LTR_FL_TN_VT
dev.off()

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write map_usa_LTR_FL_TN_VT.png
####################################




