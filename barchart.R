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

#Generating PNG file
png(filename="bar_LTR.png")
MeanLTRPlot
dev.off()

##################################################

#Part G: 1
library(dplyr)

#Filtering the dataframe 
StateDF<- df %>% filter(GUEST_COUNTRY_R=="UNITED STATES") %>% select(STATE_R, Likelihood_Recommend_H)


#Creating a function of NPS that returns a number
NPS <- function(LTR) {
  promoters  <- (sum(LTR > 8))/length(LTR)
  detractors <- (sum(LTR < 7))/length(LTR)
  nps <- promoters-detractors 
  return(nps)
}

#Creating a vector with all states
stateabb<- c('AL', 'AK', 'AZ', 'AR','CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA',
  'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH','OK',
  'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY', 'DC')

#Calculating mean NPS for each state
NPSmean <- tapply(StateDF$Likelihood_Recommend_H, StateDF$STATE_R, NPS)

#Filtering the states
NPSmean <- NPSmean[names(NPSmean) %in% stateabb]

#Creating a dataframe
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

#Generating PNG file
png(filename="mean_NPSbystate_sorted.png", width=800, height=600)
MeanNPSPlotArr
dev.off()

#Part G: 3

#Generating a sorted and colored bar chart
MeanNPSPlotArrCol <- ggplot(NPSmeans, aes(x=reorder(state, LTR),y=LTR, fill=as.factor(LTR))) + geom_bar(stat="identity", width=0.8, show.legend=FALSE) + xlab("states") + ylab("mean NPS")
MeanNPSPlotArrCol <- MeanNPSPlotArrCol + scale_shape_manual(values = 0:length(unique(NPSmeans$state)))

#Generating PNG file
png(filename="mean_NPSbystate_color.png", width=800, height=600)
MeanNPSPlotArrCol
dev.off()

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write mean_NPSbystate_color.png
####################################









