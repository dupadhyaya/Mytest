# Regression : Sales  ~ Area
sales1  <- read.csv("./data/site.csv")
str(sales1)
# Stores have area and their sales wrt to area covered
head(sales1)
names(sales1) =  c('store','area','sales')
head(sales1)
sales.lm = lm(sales ~ area, data=sales1)
sales.lm
summary(sales.lm)

# Intercept = 0.9645, slope = 1.6699
# sales increase by 1 unit for 1.699 units increase in area(1000 sq feet)
coefficients(sales.lm)
confint(sales.lm)  # conf interval for coefficients
fitted(sales.lm)  # sales values as per best fit line
residuals(sales.lm)  # diff of best fit and actual values
paste(sales1$sales, round(fitted(sales.lm),1))
plot(sales1$area,sales1$sales)
abline(lm(sales ~ area, data=sales1),col='green')
abline(coef(sales.lm))  # another way for predicted line
#line

summary(sales.lm)
# r2 = 0.9042 : this % variation explained by area
# Std error of estimate = 0.9644 variability of actual Y
# values from predicted values : same unit of sales


#Validation of Assmuptions
# Linearity : relation is linear

# No correlation
sales2 <- sales1[order(sales1$area),]
sales2.lm = lm(sales ~ area,data=sales2)
plot(sales ~ area, data = sales2)
abline(lm(sales ~ area, data = sales2),col='green')
lines(sales ~ area, data = sales2,col='red')
lines(sales2$area, fitted(sales2.lm))
# plot shows linearity

# Independence of Errors : errors are independent of each other
#http://www.r-tutor.com/elementary-statistics/simple-linear-regression/residual-plot

plot(sales2.lm)
plot(sales2$area, resid(sales2.lm))
abline(0,0)
# plot shown randomness and no trend/ relationship

# Normality of error : errors ND wrt X
#http://www.r-tutor.com/elementary-statistics/simple-linear-regression/normal-probability-plot-residuals
sales2.stdres = rstandard(sales2.lm)
qqnorm(sales2.stdres 
    ,ylab="Standardized Residuals" 
    ,xlab="Normal Scores"
    ,main="Sales Residuals") 
qqline(sales2.stdres)
#?qqplot

# points do not depart much from normality

# Equal Variance : constt variance of errors does not change with value of X
#https://stat.ethz.ch/R-manual/R-devel/library/stats/html/bartlett.test.html
#https://www.r-bloggers.com/example-9-36-levenes-test-for-equal-variances/
#http://stackoverflow.com/questions/2933253/homoscedascity-test-for-two-way-anova
#https://www.ma.utexas.edu/users/mks/statmistakes/modelcheckingplots.html
# Hypothesis - that variances are same
fligner.test(sales ~ area, data=sales2) # p > 0.05 : Accept Ho
# Not working :bartlett.test( ) # p > 0.05 : Accept Ho

plot(fitted(sales2.lm),sales2.stdres)
plot(sales2$area, sales2.stdres)
abline(h=0)
sales2.stdres

# Auto Correlation 
# Durbin Watson  : Ho - No auto correation
library(car)
durbinWatsonTest(sales2.lm)
dwt(sales2.lm)
# p value > 0.58 : Accept Ho
#http://www.statmethods.net/stats/rdiagnostics.html
library(lmtest)
dwtest(sales2.lm)

sales2
# Prediction
newdata = data.frame(area=2)
predict(sales2.lm, newdata, interval="predict") 
predict(sales2.lm, newdata, interval="confidence") 
predict(sales2.lm)
cbind(sales2$area,sales2$sales, predict(sales2.lm, newdata, interval="predict"))
cbind(sales2$area,sales2$sales, predict(sales2.lm, newdata, interval="confidence", level=0.99))
cbind(sales2$area,sales2$sales, predict(sales2.lm, newdata, interval="confidence", level=0.95))

#Linearity
# Evaluate Nonlinearity
# component + residual plot 
crPlots(sales2.lm)
# Ceres plots 
#ceresPlots(sales2.lm)
?ceresPlots

library(gvlma)
gvmodel <- gvlma(sales2.lm) 
summary(gvmodel)

# Fitted Regression line plot
library(visreg)
