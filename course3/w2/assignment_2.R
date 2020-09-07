# list.dirs("../..")
# getwd()
# setwd("../../course3/w2")

# Reading from MySQL
# Test connect mysql
ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;")

# hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
# allTables <- dbListTables(hg19)
# dbListFields(hg19, "affyU133Plus2")
# query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
# affy <- fetch(query, n=10)
# dbClearResult(query)

dbDisconnect(ucscDb)

# HDF5 - Hierarchical Data Format
# Installation Process
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()

BiocManager::install("rhdf5")
library(rhdf5)


created = h5createFile("example.h5")
h5ls("example.h5")

# Reading from Web
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)

xpathSApply(html, "//td[@is='col-citedby']", xmlValue)



# Quiz
# Q1
# Q2/3
getwd()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile="./american_comm_survey.csv")

acs <- read.csv("./american_comm_survey.csv")
library(sqldf)
sqldf("select pwgtp1 from acs")
sqldf("select AGEP")

# Q4
html <- readLines("http://biostat.jhsph.edu/~jleek/contact.html")
nchar(html[c(10,20,30,100)])

# Q5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", destfile="./noaa_wksst8110.for")
noaa <- read.fwf("./noaa_wksst8110.for", widths=c(10,9,4,9,4,9,4,9,4), skip=4)
head(noaa[4])
sapply(noaa[4], sum)
