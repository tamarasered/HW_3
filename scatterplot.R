#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
clean_data <- read.csv('clean_data.csv')
####################################

## start writing your R code from here
# Part C.1: Generate a scatterplot (x for hotel condition, y for LTR).

#First, we need to clean the data for hotel condition (as for not it is only cleaned for LTR).
new_clean_data <- clean_data [!is.na(clean_data$Condition_Hotel_H),] 

#Having both x and y of the scatterplot clean, we can proceed with plotting it.
library(ggplot2)
myPlot <- ggplot(new_clean_data)
myPlot <- myPlot + aes(x=new_clean_data$Condition_Hotel_H,y=new_clean_data$Likelihood_Recommend_H)
myPlot <- myPlot + geom_point() 
myPlot <- myPlot + geom_jitter()
myPlot
#Creating the png file of the scatterplot.
png(filename="scat_hc_LTR.png")
myPlot
dev.off()

# Part C.2: Generate a scatterplot (x for hotel condition, y for staff care).
# Have the size and color be represented by LTR.

#First we need to clean the data for staff care (as for not it is only cleaned for LTR and hotel condition).
new_clean_data2 <- new_clean_data [!is.na(new_clean_data$Staff_Cared_H),] 

# Having both x and y of the scatterplot clean, we can proceed with plotting it.
library(ggplot2)
myPlot2 <- ggplot(new_clean_data2)
myPlot2 <- myPlot2 + aes(x=new_clean_data2$Condition_Hotel_H,y=new_clean_data2$Staff_Cared_H)
myPlot2 <- myPlot2 + 
           geom_point(aes(color=new_clean_data2$Likelihood_Recommend_H, size=new_clean_data2$Likelihood_Recommend_H)) +
           scale_colour_gradient(low="red", high="black")
myPlot2 <- myPlot2 + geom_jitter()
myPlot2
#Creating the png file of the scatterplot.
png(filename="scat_hc_sc.png")
myPlot2
dev.off()

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write scat_hc_sc.png
####################################




