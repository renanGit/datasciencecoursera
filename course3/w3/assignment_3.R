# list.dirs("../..")
# getwd()
# setwd("../../course3/w3")

# Notes
# Subsetting
d <- data.frame(c(1,NA,3,4), c(1,2,NA,4))
colnames(d) <- c("A", "B")
d[which(d$A >= 1 & d$B >= 1),]
# which, used to remove NA
#   A  B
# 1 1  1
# 4 4  4

# Ordering
d <- data.frame(c(4,NA,2,1), c(1,2,NA,4))
colnames(d) <- c("A", "B")
d[order(d$A, d$B, na.last=T),]
#    A  B
# 4  1  4
# 3  2 NA
# 1  4  1
# 2 NA  2

# dplyr
# select: return a subset of the columns of a data frame
# filter: extract a subset of rows from a data frame based on logical conditions
# arrange: reorder rows of a data frame
# mutate: add new variables/columns or transform existing variables
# summarise / summarize: generate summary statistics of different vars in the data frame

# Common Params
# First arg is a data frame
# Subsequent args describe what to do with it, and you can refer to columns
#  in the data frame directly without using the $

# Quiz
# 1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="./american_community_survey.csv")
acs <- read.csv("./american_community_survey.csv", na.strings=c("b"))

# library(dplyr)
# d <- select(acs, 11:12)
# filter(d, acs$AGS >= 6 & acs$ACR >=3)
which(acs$AGS >= 6 & acs$ACR >=3)

# 2
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile="./pic.jpg", mode="wb")
p <- readJPEG("./pic.jpg", native=T)
quantile(p, probs=c(0.3,0.8))

# 3
library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="./gdp.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile="./fedstats.csv")
gdp <- read.csv("./gdp.csv", skip=4, na.strings = c(""))
fs <- read.csv("fedstats.csv")
names(gdp) <- c("CountryCode", "Rank","B","C","D","E","F","G","H","I")
gdp <- gdp[!is.na(gdp$Rank) & !is.na(gdp$CountryCode),]

gdpjoin <- inner_join(gdp, fs, by="CountryCode")
gdpjoin$Rank <- as.numeric(as.character(gdpjoin$Rank))
# class(gdpjoin$Rank)
gdpjoin[order(gdpjoin$Rank, decreasing = T),1:11]

# OR
# merged <- merge(gdp, fs, by="CountryCode", all=T)
# merged$Rank <- as.numeric(merged$Rank)
# arrange(merged, desc(merged$Rank))

# sum(fs$CountryCode %in% gdp$CountryCode)

# 4
gdpjoin %>% group_by(gdpjoin$Income.Group) %>% summarize(r=mean(gdpjoin$Rank))
# income_group <- group_by(gdpjoin, gdpjoin$Income.Group)
# summarize(income_group, mean(gdpjoin$Rank))

# R is being a pain in the ass
mean(gdpjoin[gdpjoin$Income.Group == "High income: OECD", 2])
# [1] 32.96667
mean(gdpjoin[gdpjoin$Income.Group == "High income: nonOECD", 2])
# [1] 91.91304

# 5
table(gdpjoin$Income.Group, cut(gdpjoin$Rank, breaks=5))
# quantile(gdpjoin$Rank, probs = c(0.2, 0.4, 0.6, 0.8, 1))
