#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
df <- read.csv('clean_data.csv')
####################################

## start writing your R code from here

#Part B: 1
# Creating a vector LTR
LTR <- df$Likelihood_Recommend_H

#Creating types of NPS
promoters <- (sum(LTR > 8))/length(LTR)
passives <- (sum(LTR > 6 & LTR<9))/length(LTR)
detractors <- (sum(LTR < 7))/length(LTR)
LTR
Type<- 

png(filename="hist_NPS10.png")
hist(AVG)
dev.off()

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write mean_NPSbystate_color.png
####################################









