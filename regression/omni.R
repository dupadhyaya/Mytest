# Multiple Regression
#omni dataset
omni1  <- read.csv("./data/omni.csv")
str(omni1)
omni1.lm = lm(sales ~ price + promotion, data=omni1)
summary(omni1.lm)
newdata1 = data.frame(price=79,promotion=400)
predict(omni1.lm, newdata1, interval="predict") 
predict(omni1.lm, newdata1, interval="confidence", level=.95) 
summary(omni1.lm)
# Ho : No linear relationship between all IVs & DV
# Ha : Linear relationship with at least one IV

# pvalue < 0.015 : Reject Ho : 
confint(omni1.lm, level=0.99)
confint(omni1.lm, level=0.95)
omni1.lm

omni1.lm = lm(sales ~ price + promotion, data=omni1)
omni2.lm = lm(sales ~ price, data=omni1)
omni3.lm = lm(sales ~ promotion, data=omni1)

anova(omni1.lm,omni2.lm)
# p value is < 0.05 : Reject Ho : Price var improves regression model
anova(omni1.lm,omni3.lm)
# p value is < 0.05 : Reject Ho : Promotion var improves regression model

# Partial Determiniation
library(lmSupport)
modelEffectSizes(omni1.lm)
# contribution of each variable  on Sales
# price = 0.6605, promotion = 0.4728