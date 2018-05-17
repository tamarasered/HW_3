#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
df <- read.csv('clean_data.csv')
####################################

## start writing your R code from here
library(ggplot2)



# PART A.1: Generate a boxplot of LTR, which is already cleaned.

# Creating a box plot
myPlot <- ggplot(df, aes(x=Likelihood_Recommend_H, y=Likelihood_Recommend_H)) + geom_boxplot(fill="yellow", col="black")
myPlot <- myPlot + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

# Invoke the plot to draw it. 
myPlot

#Creating the png file of the boxplot.
png(filename="box_LTR.png")
myPlot
dev.off()


# PART A.2: Generate a boxplot for each NPS Type. 
# The data.
myPlot_NPS <- ggplot(df, aes(x=NPS_Type, y=Likelihood_Recommend_H))
# The geometry.
myPlot_NPS <- myPlot_NPS + geom_boxplot(fill="orange", col="black") 
myPlot_NPS <- myPlot_NPS + scale_y_continuous( breaks = 1:10) + xlab("NPS type") + ylab("Likelihood to recommend")

# Invoke the plot to draw it. 
myPlot_NPS

#Creating the png file of the boxplot.
png(filename="box_NPS.png")
myPlot_NPS
dev.off()



##################################################

#Part B: 1
# Creating a vector LTR
LTR <- df$Likelihood_Recommend_H

#Creating types of NPS
promoters <- (sum(LTR > 8))/length(LTR)*100
passives <- (sum(LTR > 6 & LTR<9))/length(LTR)*100
detractors <- (sum(LTR < 7))/length(LTR)*100

#Creating vectors for the NPS types and values  
Type<- c(promoters, passives, detractors)
Names <- c("promoters", "passives", "detractors")

#Generating a bar chart
MyPlot <- ggplot() + geom_bar(aes(x=Names,y=Type), stat="identity") + ggtitle(paste("Overall NPS value:", round(mean(Type)))) + xlab("NPS types") + ylab("NPS type values")

#Generating PNG file
png(filename="bar_NPS.png")
MyPlot
dev.off()



#Part B: 2
#Creating a new dataframe by omitting NAs from 'hotel condition' column
hc <- df[!is.na(df$Condition_Hotel_H),] 

#Getting mean values of LTR for each value of the 'hotel condition' and storing in a new dataframe
meanLTR <- aggregate(.~Condition_Hotel_H, data=hc, mean)

#Generating a bar chart
MeanLTRPlot <- ggplot() + geom_bar(aes(x=meanLTR$Condition_Hotel_H,y=meanLTR$Likelihood_Recommend_H), stat="identity") + xlab("hotel condition") + ylab("LTR")
MeanLTRPlot <- MeanLTRPlot + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

#Generating PNG file
png(filename="bar_LTR.png")
MeanLTRPlot
dev.off()



##################################################

# Part C.1: Generate a scatterplot (x for hotel condition, y for LTR).

#First, we need to clean the data for hotel condition (as for not it is only cleaned for LTR).
hotel <- df[!is.na(df$Condition_Hotel_H),] 

#Having both x and y of the scatterplot clean, we can proceed with plotting it.
library(ggplot2)
myPlot <- ggplot(hotel, aes(x=Condition_Hotel_H, y=Likelihood_Recommend_H))
myPlot <- myPlot + geom_point() + geom_jitter(alpha=0.3, position=position_jitter(width=0.3, height=0.3))
myPlot <- myPlot + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)
myPlot
#Creating the png file of the scatterplot.
png(filename="scat_hc_LTR.png")
myPlot
dev.off()


# Part C.2: Generate a scatterplot (x for hotel condition, y for staff care).
# Have the size and color be represented by LTR.

#First we need to clean the data for staff care (as for not it is only cleaned for LTR and hotel condition).
hotel2 <- hotel[!is.na(hotel$Staff_Cared_H),] 

# Having both x and y of the scatterplot clean, we can proceed with plotting it.
myPlot2 <- ggplot(hotel2, aes(x=Condition_Hotel_H, y=Staff_Cared_H))
myPlot2 <- myPlot2 + geom_point(aes(color=Likelihood_Recommend_H, size=Likelihood_Recommend_H)) + scale_colour_gradient(low="red", high="black", name="LTR")
myPlot2 <- myPlot2 + geom_jitter(alpha=0.3, position=position_jitter(width=0.3, height=0.3))
myPlot2 <- myPlot2 + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10) + coord_fixed() + theme_minimal()
#Creating the png file of the scatterplot.
png(filename="scat_hc_sc.png")
myPlot2
dev.off()



##################################################

# Part D: Generate a heatmap (x for hotel condition, y for staff care)
# Have the colors range from white to blue

library(ggplot2)

# #First, we need to clean the data for hotel condition and staff care (as for not it is only cleaned for LTR). 
heat <- df[!is.na(df$Condition_Hotel_H),] 
heat <- heat[!is.na(heat$Staff_Cared_H),] 

#Now we can proceed with generating a heatmap where we take x for hotel condition, y for staff care.
#Colors range from white to blue depending on fil value of LTR.
myPlotHeat <- ggplot(heat, aes(x=Condition_Hotel_H, y=Staff_Cared_H, fill=Likelihood_Recommend_H)) + geom_tile(color = "white") 
myPlotHeat <- myPlotHeat + scale_fill_gradient(low="white", high="blue", space = "Lab", name="LTR") + xlab("Hotel condition") + ylab("Staff care")
myPlotHeat <- myPlotHeat + coord_fixed() + theme_minimal() + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

#Creating the png file of the heatmap
png(filename="heat_hc_sc.png")
myPlotHeat
dev.off()


##################################################

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
point  <- geocode(c("burlington, vt", "orlando, fl", "nashville, tn"))

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




##################################################

#Part G: 1
library(dplyr)

#Filtering the dataframe by "United States"
StateDF<- df %>% filter(GUEST_COUNTRY_R=="UNITED STATES") %>% select(STATE_R, Likelihood_Recommend_H)


#Creating a function of NPS that returns a number
NPS <- function(LTR) {
  promoters  <- (sum(LTR > 8))/length(LTR)
  detractors <- (sum(LTR < 7))/length(LTR)
  nps <- (promoters-detractors)*100 
  return(nps)
}


#Calculating mean NPS for each state
NPSmean <- tapply(StateDF$Likelihood_Recommend_H, StateDF$STATE_R, NPS)

#Filtering the vector by 50 states
NPSmean <- NPSmean[names(NPSmean) %in% state.abb]

#Creating a dataframe of 50 states and mean NPS
NPSmeans <- data.frame(state=(names(NPSmean)), LTR=NPSmean)

#Generating a bar chart
MeanNPSPlot <- ggplot(NPSmeans, aes(x=state,y=LTR)) + geom_bar(stat="identity", width=0.8) + xlab("states") + ylab("mean NPS")

#Generating PNG file
png(filename="mean_NPSbystate.png", width=800, height=600)
MeanNPSPlot
dev.off()



#Part G: 2

#Generating a sorted bar chart
MeanNPSPlotArr <- ggplot(NPSmeans, aes(x=reorder(state, LTR),y=LTR)) + geom_bar(stat="identity", width=0.8) + xlab("states") + ylab("mean NPS")

#Generating sorted PNG file
png(filename="mean_NPSbystate_sorted.png", width=800, height=600)
MeanNPSPlotArr
dev.off()



#Part G: 3

#Generating a sorted and colored bar chart
MeanNPSPlotArrCol <- ggplot(NPSmeans, aes(x=reorder(state, LTR),y=LTR, fill=as.factor(LTR))) + geom_bar(stat="identity", width=0.8, show.legend=FALSE) + xlab("states") + ylab("mean NPS")
MeanNPSPlotArrCol <- MeanNPSPlotArrCol + scale_shape_manual(values = 0:length(unique(NPSmeans$state)))

#Generating sorted and colored PNG file
png(filename="mean_NPSbystate_color.png", width=800, height=600)
MeanNPSPlotArrCol
dev.off()





## end your R code and logic 

####################################
##### write output file ############
# add your R code to write mean_NPSbystate_color.png
####################################









