# Two way ANOVA
smarks = read.
library(readxl)
smarks = read_excel('dudata2.xlsx',sheet=2)
str(smarks)
marks2 = smarks[1:50,c('btechmarks','gender','cat')]
str(marks2)
# Now the data has 2 IV which are categorical and 1 IV which is continuous: 2 way ANOVA
head(marks2)
summary(marks2)
marks2
# convert gender & cat to factors
marks2$gender = as.factor(marks2$gender)
marks2$cat = as.factor(marks2$cat)
summary(marks2)

marks2.aov1 = aov(btechmarks ~ gender + cat, data = marks2)
# this is variability due to each factor seperately
summary(marks2.aov1)

# Next take into account interactions between two IVs ie cat & gender
marks2.aov2 = aov(btechmarks ~ gender * cat, data = marks2)
summary(marks2.aov2)

# this is same as
marks2.aov3 = aov(btechmarks ~ gender + cat + gender:cat, data = marks2)
summary(smarks2.aov3)

# Compare ANOVA results
anova(smarks2.aov1, smarks2.aov2)
# Understand these values

# Post-hoc Testing
TukeyHSD(smarks2.aov2)

TukeyHSD(smarks2.aov2, which='gender')
TukeyHSD(smarks2.aov2, which='cat')
TukeyHSD(smarks2.aov2, which='gender:cat')

# Alter Confidence Level
TukeyHSD(smarks2.aov2, which='cat', conf.level=0.99)

TukeyHSD(smarks2.aov2, which='gender:cat', ordered=T) # gender:cat in order

ftable(smarks2$cat, smarks2$gender)

# Plotting data
boxplot(btechmarks ~ gender * cat, data = smarks2, cex.axis=0.7)
title(xlab='Interaction between Gender & Category', ylab=' BTech Marks')

plot(TukeyHSD(smarks2.aov2),cex.axis=0.7, las=1)

op=par(mar=c(5,8,4,2))
plot(TukeyHSD(smarks2.aov2, ordered=T), cex.axis=0.7, las=1)
abline(v=0, lty=2, col='gray40')


model.tables(smarks2.aov2,type='means',se=T)
