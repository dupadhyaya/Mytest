# Parachute 2 : Strength ~ Supplier + Loom
# Total Variation SST = SSA + SSB + SSAB (interaction)
parachute5 <- read.csv("./data/parachute2.csv")
str(parachute5)
head(parachute5)
names(parachute5) = c('loom',paste('supp',1:4,sep=''))
head(parachute5)
stack(parachute5)
#http://www.ats.ucla.edu/stat/r/faq/reshape.htm

library(reshape)
p6 = reshape(parachute5, varying = c('supp1','supp2','supp3','supp4')
            ,v.names='strength', times=c('supp1','supp2','supp3','supp4')
            ,direction='long')
head(p6)
p7 = p6[,1:3]
head(p7)
names(p7)= c('loom','supplier','strength')
row.names(p7) = NULL
p7
# now the data is properly organised 

# Groupwise summary of Mean

with(p7,tapply(strength,list(loom,supplier), mean))
with(p7,tapply(strength,list(loom,supplier), length))
with(p7,tapply(strength,list(loom,supplier), var))

addmargins(with(p7,tapply(strength,list(loom,supplier), mean)))
addmargins(with(p7,tapply(strength,list(loom,supplier), mean)), FUN=mean)

?addmargins

addmargins(with(p7,tapply(strength,list(supplier), mean)),FUN=mean)

# 2 way ANOVA
p7.aov = aov(strength ~ loom * supplier, data=p7)
p7.aov
summary(p7.aov)
# p value for supplier < 0.05 : Significant diff in strength due suppliers
# no diff due to loom or interaction betw loom & loom:supplier

# Graphical Summary
boxplot(strength ~ loom * supplier, data=p7, cex.axis=0.9)
boxplot(strength ~ supplier, data=p7, cex.axis=0.9)

# Interaction Plots
TukeyHSD(p7.aov)
TukeyHSD(p7.aov, which='supplier')
# p value of supp2-supp1 is < 0.05 : 
TukeyHSD(p7.aov,ordered=T)
op=par(mar=c(5,8,4,2))
plot(TukeyHSD(p7.aov,ordered=T),cex.axis=0.7,las=1)
par(op)
?TukeyHSD

# Extacting Means -similar to tapply
model.tables(p7.aov, type='means')
model.tables(p7.aov, type='means',se=T) # for balanced design
model.tables(p7.aov, type='means',se=T,cterms=c('supplier'))

# Interaction Plot
interaction.plot(p7$supplier,p7$loom,p7$strength, type='b',pch=1:4,lty=1:4,col=c('green','red'))
# both the lines are parallel. diff in strength is same for 2 looms for 4 suppliers
interaction.plot(p7$loom,p7$supplier,p7$strength, type='b')
interaction.plot(p7$supplier,p7$loom,p7$strength, type='b',pch=1:4,lty=1:4,col=c('green','red'),fun=median)
interaction.plot(p7$supplier,p7$loom,p7$strength, type='b',pch=1:4,lty=1:4,col=c('green','red'),fun=var)

interaction.plot(p7$supplier,p7$loom,p7$strength, type='b',pch=1:4,lty=1:4,col=c('green','red')
                      ,xlab = 'Supplier'
                      ,ylab = 'Strength')
plot.2
