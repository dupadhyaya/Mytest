# Practice Codes
library(xtable)
cars
htlmtable <- xtable(mtcars)
print(htlmtable,type="html")
site  <- read.csv("./data/site.csv")
str(site)

z = lm(sales ~ area , data = site, na.action = na.exclude)
z
summary(z)
str(site)
plot(z)
coef(z)
confint(z)
resid(z)
predict(z)
#predict(z, newdata = data.frame(c(1,3,5)))
plot(sales~area, data=site)
abline(z)
z1 = lm(sales~ 1,data=site)
z1
xnew = range(site$area)
xnew
yhat = predict(z,newdata=data.frame(area=xnew))
cbind(xnew,yhat)
xnew = seq(min(site$area),max(site$area), length.out = 100 )
xnew
ynew = data.frame( predict(z,newdata=data.frame(area=xnew)
               ,interval='prediction', level=0.95))
ynew
lines(ynew$lwr ~ xnew, lty=2)
lines(ynew$upr ~ xnew, lty=3)

library(visreg)
visreg(z)
visreg(z, points.par=list(cex=1.2,col='red'))
visreg(z, whitespaces=0.4)

hist(resid(z)) # histogram of residues

stripchart(sales ~ area, data=site, method='jitter', pch=16)
visreg(z, whitespaces=0.4)

library(lsmeans)
lsmeans(z,"area")

house  <- read.csv("./data/house3.csv")
str(house)
z1 = lm(value ~size + fireplace, data=house)
model.matrix(z1)
lsmeans(z1, 'fireplace')

student  <- read.csv("./data/student2.csv")
str(student)
names(student) = c('A','B','y')
str(student)
mydata = student
z3 = lm(y ~ A + B )

# Interactive Learning of R
library(swirl)
swirl()
fligner.test(value ~ fireplace, data=house)
library(coin)
str(student)

# Balance Factor
friedman_test(y~A|B, data=student, 
              distribution=approximate(B=9999))
