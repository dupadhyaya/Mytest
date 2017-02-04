# Importing Data into R
# Clear Workspace
rm(list=ls())

# Text File
df = read.table('file1.txt', header=F)
df

# if there are some missing values in some colns, then use fill=T
df2 = read.table('file2.txt', header=F, fill=T)
df2

# CSV File - comma is default
df3 = read.csv(file='student1.csv',header=T)
df3

df3a =read.table(file='student1.csv', header=T, sep=',')
df3a

#CSV2 has different default format as per country
df3b = read.csv2(file='student1.csv',header=T, sep=',') 
df3b

# Other delim
df4 = read.delim(file='student1.csv',sep=',')
df4
# System Command
system('pwd')
system('ls')

library(XLConnect)
df5 = readWorksheetFromFile('dudata2.xlsx', sheet=1)
df5

df5 = loadWorkbook('dudata2.xlsx')
df5a = readWorksheet(df5,sheet=2)
df5a

#install.packages('readxl')
library(readxl)
df6 = read_excel('dudata2.xlsx')
df6
str(df6)






# from Keyboard
cat("\n","Enter x","\n") # prompt
y <-scan(n=1) # First item
y

y2 = scan()  # Default is numeric 
y2

# character from keyboard
y3 = scan(, what=' ')
y3

# This takes input from text, age becomes numeric and name col becomes text
x = scan("scan.txt", what=list(age=0, name=""))
x

# will reject 1st column
x2 = scan("scan.txt", what=list(NULL, name=character()))
x2
x2a = x2[sapply(x2, length) > 0]
x2a
is.vector(x2a)


# Fixed file format using read.fwf

names1 = scan('names.txt', what=character())
names1
print(names1)

test.fixed = read.fwf('testfixed.txt', col.names=names1, width=c(5,7,2,4,4))
test.fixed




# Copy from clipboard
x5 = read.table(file='clipboard', sep='\t', header=T)

# this works for Windows OS
x6 = readClipboard() 
x6  

# Published Data
mydata = read.csv("http://bit.ly/10ER84j")
mydata2 = read.csv("http://www.stats.ox.ac.uk/pub/datasets/csb/ch11b.dat")
mydata2

library(data.table)
mydat <- fread('http://www.stats.ox.ac.uk/pub/datasets/csb/ch11b.dat')
head(mydat)

# sudo apt-get install libcurl4-gnutls-dev
library(RCurl)
myfile <- getURL('https://sakai.unc.edu/access/content/group/3d1eb92e-7848-4f55-90c3-7c72a54e7e43/public/data/bycatch.csv', ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)

# Edit Command
# Editing data in R
a = c(10,23,25,14,25)
b = c('s1','s2','s3','s4','s5')
df7 = data.frame(a,b)
df7
df7 = edit(df7)
df7
fix(df7)
df7

vi(df7)

#??? check 
dataentry(df7)

# Saving Data
save.image()
