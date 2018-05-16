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

#Creating data frames for types of NPS
promoters <- clean_data[clean_data$Likelihood_Recommend_H > 8,]
passives <- clean_data[clean_data$Likelihood_Recommend_H > 6 & clean_data$Likelihood_Recommend_H<9,]
detractors <- clean_data[clean_data$Likelihood_Recommend_H < 7,]

#Creating corresponding boxplots. 
# The data for promoters.
myPlotPromoters <- ggplot(promoters)
# The aesthetic for promoters.
myPlotPromoters <- myPlotPromoters + aes(x=promoters$Likelihood_Recommend_H, y=promoters$Likelihood_Recommend_H)
# The geometry for promoters.
myPlotPromoters <- myPlotPromoters + geom_boxplot(fill="yellow", col="black")
# Invoke the plot to draw it. 
myPlotPromoters
#Creating the png file of the boxplot for promoters.
png(filename="box_NPS_promoters.png")
myPlotPromoters
dev.off()

# The data for passives
myPlotPassives <- ggplot(passives)
# The aesthetic for passives
myPlotPassives <- myPlotPassives + aes(x=passives$Likelihood_Recommend_H, y=passives$Likelihood_Recommend_H)
# The geometry for passives
myPlotPassives <- myPlotPassives + geom_boxplot(fill="yellow", col="black")
# Invoke the plot to draw it. 
myPlotPassives
#Creating the png file of the boxplot for passives
png(filename="box_NPS_passives.png")
myPlotPassives
dev.off()


# Create a new data frame with 
## end your R code and logic 

####################################
##### write output file ############
# add your R code to write NPS_Pro.png
####################################






