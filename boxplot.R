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

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write NPS_Pro.png
####################################






