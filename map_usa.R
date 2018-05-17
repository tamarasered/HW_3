#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
df <- read.csv('clean_data.csv')
####################################

## start writing your R code from here
# Part E:Generate a Map of the USA, where the color of the state represents the average LTR for people from that state.

# First we need to have data with only USA information. For that we need to 
# keep only those rows where GUEST_COUNTRY_R is UNITED STATES.

#Calling the libraries
library(dplyr)
library(ggplot2)
library(ggmap)

#Filtering the dataframe by "United States"
StateDF<- df %>% filter(GUEST_COUNTRY_R=="UNITED STATES") %>% select(STATE_R, Likelihood_Recommend_H)

#Calculating mean LTR for each state
LTRmean <- tapply(StateDF$Likelihood_Recommend_H, StateDF$STATE_R, mean)

#Filtering the vector by 50 states
LTRmean <- LTRmean[names(LTRmean) %in% state.abb]

#Creating a dataframe of 50 states and mean NPS
LTRmeans <- data.frame(state=(names(LTRmean)), LTR=LTRmean)

#Adding 'state name' in lowercase format to the dataframe
LTRmeans <- LTRmeans %>% mutate(statename=tolower(state.name[match(LTRmeans$state,state.abb)]))

# We can now proceed with creating the US map.
#Getting the US map
US <- map_data("state") 

USmap <- ggplot(LTRmeans, aes(map_id = statename)) + geom_map(map = US, aes(fill=LTR), color="black") 
USmap <- USmap + expand_limits(x = US$long, y = US$lat)
USmap <- USmap + coord_map() + ggtitle("Map of USA filled by mean LTR")
USmap<- USmap + scale_fill_gradient(low = "lightgreen",high = "darkgreen", breaks=c(8.1,8.5,9,9.5,10))


# Creating png for the map.
png(filename="map_usa_LTR.png")
USmap
dev.off()

##################################################

# Part F:	Put three points on the colored map of the US one for Orlando FL, 
# one for Nashville, TN and one for Burlington VT. Have the points color and
# size based on the average LTR for the hotels in that city.Have the color of 
# the points range from black to red (using scale_colour_gradient).

#Getting coordinates for three cities and creating a new dataframe
point  <- geocode(c('burlington vermont', 'orlando florida', 'nashville tennessee'))

#Creating a vector for three cities
threestates <- c("VT", "FL", "TN") 

#adding mean LTR to the dataframe point
point$LTR <- c(LTRmeans$LTR[match(threestates,LTRmeans$state)])

#Creating a vector for three states with state names to draw coordinates
statename<- c("vermont", "florida", "tennessee")

#Adding a layer with points
USmap2 <- USmap + geom_point(data=point, aes(x=lon, y=lat, color=LTR)) + scale_colour_gradient(low = 'black', high='red')

#Scaling points by radius
USmap2<- USmap2 + scale_radius(aes(size=point$LTR))


# Creating png for the map.
png(filename="map_usa_LTR_FL_TN_VT.png")
USmap2
dev.off()


## end your R code and logic 

####################################
##### write output file ############
# add your R code to write map_usa_LTR_FL_TN_VT.png
####################################




