# House 3 : Use of Dummy Variables
# one of variable is Categorical
house1  <- read.csv("./data/house3.csv")
str(house1)

house1.lm = lm(value ~ size + fireplace, data=house1)
summary(house1.lm)
levels(house1$fireplace)

#newdata = data.frame(size=1,fireplaceYes=0)
#https://www.r-bloggers.com/regression-on-categorical-variables/
  
house2.lm = lm(value ~ size * fireplace, data=house1)
summary(house2.lm)
