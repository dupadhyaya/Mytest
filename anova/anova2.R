# Two way ANOVA
smarks = read.
library(readxl)
smarks = read_excel('dudata2.xlsx',sheet=2)
str(smarks)
smarks1 = smarks[1:50,c('btechmarks','gender','cat')]
str(smarks1)
# Now the data has 2 IV which are categorical and 1 IV which is continuous: 2 way ANOVA
head(smarks1)
summary(smarks1)
smarks1
# convert gender & cat to factors
smarks1$gender = as.factor(smarks1$gender)
smarks1$cat = as.factor(smarks1$cat)
summary(smarks1)

smarks1.aov1 = aov(btechmarks ~ gender + cat, data = smarks1)
# this is variability due to each factor seperately
summary(smarks1.aov1)

# Next take into account interactions between two IVs ie cat & gender
smarks1.aov2 = aov(btechmarks ~ gender * cat, data = smarks1)
summary(smarks1.aov2)

# this is same as
smarks1.aov3 = aov(btechmarks ~ gender + cat + gender:cat, data = smarks1)
summary(smarks1.aov3)

# Compare ANOVA results
anova(smarks1.aov1, smarks1.aov2)
# Understand these values

# Post-hoc Testing
TukeyHSD(smarks1.aov2)

TukeyHSD(smarks1.aov2, which='gender')
TukeyHSD(smarks1.aov2, which='cat')
TukeyHSD(smarks1.aov2, which='gender:cat')

# Alter Confidence Level
TukeyHSD(smarks1.aov2, which='cat', conf.level=0.99)

TukeyHSD(smarks1.aov2, which='gender:cat', ordered=T) # gender:cat in order

ftable(smarks1$cat, smarks1$gender)

# Plotting data
boxplot(btechmarks ~ gender * cat, data = smarks1, cex.axis=0.7)
title(xlab='Interaction between Gender & Category', ylab=' BTech Marks')

plot(TukeyHSD(smarks1.aov2),cex.axis=0.7, las=1)

op=par(mar=c(5,8,4,2))
plot(TukeyHSD(smarks1.aov2, ordered=T), cex.axis=0.7, las=1)
abline(v=0, lty=2, col='gray40')

model.tables(smarks1.aov2,type='means',se=T)
