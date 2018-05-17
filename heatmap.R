#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
clean_data <- read.csv('clean_data.csv')
####################################

## start writing your R code from here
# Part D: Generate a heatmap (x for hotel condition, y for staff care)
# Have the colors range from white to blue
# Hint: use ‘scale_fill_gradient’

library(ggplot2)

# #First, we need to clean the data for hotel condition and staff care (as for not it is only cleaned for LTR). 
heat <- clean_data[!is.na(clean_data$Condition_Hotel_H),] 
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

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write heat_hc_sc.png
####################################



