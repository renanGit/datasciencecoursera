# setwd("../../course3/w4")
# getwd()

# Notes
# split
strsplit(c("A","B","AcC"), "c")

# sub - aka replace
sub("_", "", c("A_B_","C"))

# gsub - multiple replace
gsub("_", "", c("A_B__","C"))

# grep grepl - find values
grep("ABC", c("afABCasABC","ACB","ABC")) # returns vector indices from string vector
grepl("ABC", c("adfABCasABC","aa","ABC")) # returns vector bool from string vector

# date
as.Date(c("2020-11-1","2020-12-1"), "%Y-%m-%d")

# stringr - helpful package
# nchar - count chars
# substr - get a sub string
# paste - join strings
# paste0 - join strings with no space b/w
# str_trim - trim lead/trailing space

# lubridate - helpful package
# years
# weekdays

# Quiz
# Q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="./american_commun_survey.csv")
acs <- read.csv("./american_commun_survey.csv")
strsplit(colnames(acs), "wgtp")[123]

# Q2/3
library(stringr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="./gdp.csv")
gdp <- read.csv("./gdp.csv", skip=4, na.strings=c("", ".."))
gdp$X.4 <- gsub(",", "", str_trim(gdp$X.4))
gdp <- gdp[complete.cases(gdp$X.1, gdp$X.4), c(1,2,5)]
mean(as.numeric(gdp$X.4))

sum(grepl("^United", gdp$X.3))

# Q4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile="./edu_data.csv")
gdp <- read.csv("./gdp.csv", skip=4, na.strings=c("", ".."))
gdp <- gdp[complete.cases(gdp$X.1, gdp$X.4), c(1,2,4)]
edu <- read.csv("./edu_data.csv", na.strings="")
colnames(gdp) <- c("CountryCode", "X", "Y")

datajoin <- merge(gdp, edu, by="CountryCode")
sum(grepl("Fiscal year end: June 30", datajoin$Special.Notes))

# Q5
library(lubridate)
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = as.Date(index(amzn), "%Y-%m-%d")

sum(year(sampleTimes) == 2012)
sum(year(sampleTimes) == 2012 & weekdays(sampleTimes) == "Monday")
