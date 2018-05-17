#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
df <- read.csv('clean_data.csv')
####################################

## start writing your R code from here
# Part C.1: Generate a scatterplot (x for hotel condition, y for LTR).

#First, we need to clean the data for hotel condition (as for not it is only cleaned for LTR).
hotel <- df[!is.na(clean_data$Condition_Hotel_H),] 

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

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write scat_hc_sc.png
####################################




