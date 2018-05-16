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

# #First, we need to clean the data for hotel condition and staff care (as for not it is only cleaned for LTR). 
new_clean_data <- clean_data [!is.na(clean_data$Condition_Hotel_H),] 
new_clean_data2 <- new_clean_data [!is.na(new_clean_data$Staff_Cared_H),] 
#Now we can proceed with generating a heatmap where we take x for hotel condition, y for staff care.
#Colors range from white to blue depending on fil value of LTR.
library(ggplot2)
myPlotHeat <- ggplot(new_clean_data2)
myPlotHeat <- myPlotHeat + aes(x=new_clean_data2$Condition_Hotel_H, y=new_clean_data2$Staff_Cared_H) + 
              geom_tile(aes(fill=new_clean_data2$Likelihood_Recommend_H)) +
              scale_fill_gradient(low="white", high="blue")
myPlotHeat
#Creating the png file of the heatmap
png(filename="heat_hc-sc.png")
myPlotHeat
dev.off()

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write heat_hc_sc.png
####################################



