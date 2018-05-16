#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
clean_data <- read.csv('clean_data.csv')
####################################

## start writing your R code from here
# PART A.1: Generate a boxplot of LTR, which is already cleaned.
library(ggplot2)
# The data.
myPlot <- ggplot(clean_data)
# The aesthetic.
myPlot <- myPlot + aes(x=clean_data$Likelihood_Recommend_H, y=clean_data$Likelihood_Recommend_H)
# The geometry.
myPlot <- myPlot + geom_boxplot(fill="yellow", col="black")
# Invoke the plot to draw it. 
myPlot
#Creating the png file of the boxplot.
png(filename="box_LTR.png")
myPlot
dev.off()

# PART A.2: Generate a boxplot for each NPS Type. 
# The data.
myPlot_NPS <- ggplot(clean_data)
# The aesthetic.
myPlot_NPS <- myPlot_NPS + aes(x=clean_data$NPS_Type, y=clean_data$Likelihood_Recommend_H)
# The geometry.
myPlot_NPS <- myPlot_NPS + geom_boxplot(fill="yellow", col="black")
# Invoke the plot to draw it. 
myPlot_NPS
#Creating the png file of the boxplot.
png(filename="box_NPS.png")
myPlot_NPS
dev.off()
# Create a new data frame with 
## end your R code and logic 

####################################
##### write output file ############
# add your R code to write NPS_Pro.png
####################################






