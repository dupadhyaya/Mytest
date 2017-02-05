# Parachute Levine Pg 426
#Determine whether significant differences exist in the 
#strength of parachutes woven from synthetic fibres from
# 4 different suppliers

parachute <- read.csv("./data/parachute.csv")
View(parachute)
parachute1 = parachute[-1]  # remove first blank coln
str(parachute1)
nm = paste('supp',1:4,sep='')
names(parachute1) = nm
str(parachute1)
apply(parachute1,2,mean)
apply(parachute1,2,sd)
apply(parachute1,2,median)
# Are the means almost same
# Ho : U1 = U2 = U3 = U4
# Ha : Not all means are equal
mean(stack(parachute1)[,1]) # Total Mean
parachute2 = stack(parachute1)
str(parachute2)
head(parachute2)
names(parachute2) = c('strength', 'supplier')
head(parachute2)
summary(parachute2)
#Anova
p2.aov = aov(strength ~ supplier, data= parachute2)
p2.aov

summary(p2.aov)
# F value = 3.4 with df 3 by 16
# p value = 0.0414 < 0.05 : 4% chance of observing diff this large or larger
# accept if chance was 5% or more of finding difference
# Reject Ho : There is difference in at least work by 1 suppliers
# which supplier is ? find
# Tukey Kramer Procedure
TukeyHSD(p2.aov)
# 4 suppliers - 6 comparisons: difference among them
# pvalue for supp2-supp1 is < 0.05 : Significant
# Strength of S1 is much less than S2
# Others are not so signficant
# can be seen from 
model.tables(p2.aov, type='means')
model.tables(p2.aov, type='means', se=T)
model.tables(p2.aov, type='effects')

# Assumptions
# Randomness

# Normality

?qqplot

# Variance
#http://www.cookbook-r.com/Statistical_analysis/Homogeneity_of_variance/
library(car)
leveneTest(strength ~ supplier, data=parachute2)
# p value > 0.8902 : Can accept that variances are same 
