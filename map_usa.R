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
library(ggmap)

#Crearing ne data frame 

new_df <- data.frame("state" = states_clean_data$STATE_R, "ltr" = states_clean_data$Likelihood_Recommend_H)

aggregateState <- setNames(aggregate(new_df$ltr, by=list(new_df$state), FUN=mean), c('state', 'meanLTR'))
aggregateState$state <- state.name[match(as.character(aggregateState$state), state.abb)]
aggregateState$state <- tolower(aggregateState$state)

us <- map_data("state")

us$meanLTR <- aggregateState$meanLTR[match(us$region,aggregateState$state)]

map_usa_LTR <- ggplot(data = us) + 
  geom_polygon(aes(x = long, y = lat, fill=meanLTR, group = group), col = "white")

map_usa_LTR

# Creating png for the map.
png(filename="map_usa_LTR.png")
map_usa_LTR
dev.off()

# Part F:	Put three points on the colored map of the US – one for Orlando FL, 
# one for Nashville, TN and one for Burlington VT. Have the points color and
# size based on the average LTR for the hotels in that city.Have the color of 
# the points range from black to red (using ‘scale_colour_gradient’).

lonlat  <- geocode(c('burlington vermont', 'orlando florida', 'nashville tennessee'))
lonlat1 <- geocode(c('burlington vermont'))
lonlat2 <- geocode(c('orlando florida'))
lonlat3 <- geocode(c('nashville tennessee'))
lonlat[1,] <- lonlat1
lonlat[2,] <- lonlat2
lonlat[3,] <- lonlat3

cityData <- setNames(aggregate(c(states_clean_data$Likelihood_Recommend_H), by=list(states_clean_data$City_PL), FUN=mean), 
                     c('city', 'LTR'))
lonlat$meanLTR <- c(cityData$LTR[as.character(cityData$city) == 'Burlington'], 
                    cityData$LTR[as.character(cityData$city) == 'Orlando'],
                    cityData$LTR[as.character(cityData$city) == 'Nashville'])

# Adding the points to the previous map.
map_usa_LTR_FL_TN_V <- map_usa_LTR +
  geom_point(data=lonlat, aes(x=lon, y=lat, color=meanLTR, size=meanLTR)) +
  scale_colour_gradient(low = 'black', high='red')
map_usa_LTR_FL_TN_V

# Creating png for the map.
png(filename="map_usa_LTR_FL_TN_VT.png")
map_usa_LTR_FL_TN_V
dev.off()

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write map_usa_LTR_FL_TN_VT.png
####################################




