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

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write mean_NPSbystate_color.png
####################################









