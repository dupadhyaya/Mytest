# Teaching Methods : Significant Interaction Effects
# ACT : marks ~ method + duration
# Total Variation SST = SSA + SSB + SSAB (interaction)
act1 <- read.csv("./data/act.csv")
str(act1)
library(reshape)
act2 = reshape(act1, varying = c('condensed','regular')
             ,v.names=c('score')
             ,timevar = c("duration")
             ,times=c('condensed','regular')
             ,direction='long')
str(act2)
head(act2)
act2
act3 = act2[,c('method','duration','score')]
str(act3)
act3$duration = as.factor(act3$duration)
str(act3)
# data format ready

#Modeling
act3.aov = aov(score ~ method * duration,data=act3)
act3.aov
summary(act3.aov)
# Interaction significant -< 0.05 : see in graph


# Summaries
model.tables(act3.aov, type='means')

# Interaction plot
with(act3,interaction.plot(method,duration,score))
with(act3,interaction.plot(duration,method,score,pch=1:2,type='b',col=c('red','green')))

# to ensure max score, traditional class for 30day(regular)
# for online - condensed course

#Tunkey Test

TukeyHSD(act3.aov)
plot(TukeyHSD(act3.aov))
op=par(mar=c(5,8,4,2))
plot(TukeyHSD(act3.aov,ordered=T),cex.axis=0.7,las=1)
par(op)
