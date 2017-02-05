# Balanced Design Anova
#This dataset contains a hypothetical sample of 30 students who were exposed to one of two learning environments (offline or online) and one of two methods of instruction (classroom or tutor), then tested on a math assessment. Possible math scores range from 0 to 100 and indicate how well each student performed on the math assessment. Each student participated in 
#either an offline or online learning environment and received either classroom 
#instruction (i.e. one to many) or instruction from a personal tutor (i.e. one to one).
https://www.r-bloggers.com/r-tutorial-series-two-way-anova-with-unequal-sample-sizes/

# read data set
student2 = read.csv("student2.csv")
str(student2)  
table1 =table(student2$environment,student2$instruction)
addmargins(table1)
