# Customer Sales 
#custsale.csv
custsale1  <- read.csv("./data/custsale.csv")
str(custsale1)

custsale1.lm = lm(sales ~ customers, data=custsale1)
summary(custsale1.lm)
library(lmtest)
dwtest(custsale1.lm)

dwt(custsale1.lm)
durbinWatsonTest(custsale1.lm)
# p value < 0.05 : Reject Ho : Auto Correl > 0
# Positive Auto Correlation

custsale1.stdres = rstandard(custsale1.lm)
fligner.test(sales ~ customers, data=custsale1) # p > 0.05 : Accept Ho
# Not working :bartlett.test( ) # p > 0.05 : Accept Ho

plot(fitted(custsale1.lm),custsale1.stdres)
plot(custsale1$customers, custsale1.stdres)

abline(h=0)
