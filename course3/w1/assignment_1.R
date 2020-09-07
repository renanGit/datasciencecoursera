# list.dirs("../..")
# getwd()
# setwd("../../course3/w1")

# -------- Part 1/2 --------
download.file(
  "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
  destfile="./us_communities.csv"
)
f <- read.csv("./us_communities.csv")

# head(f)
# f["VAL"]
val <- f[complete.cases(f["VAL"]), "VAL"]
val_million <- as.matrix(val[val >= 24])
nrow(val_million)

# -------- Part 3 --------
download.file(
  "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
  destfile="./natural_gas_aquisition.xlsx",
  mode="wb"
)
dat <- read_xlsx("./natural_gas_aquisition.xlsx", range="G18:O23")
sum(dat$Zip*dat$Ext,na.rm=T)

# -------- Part 4 --------
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileURL, isURL=TRUE)
sum(xmlSApply(
  xmlRoot(doc)[[1]],
  function(el) xmlValue(xmlElementsByTagName(el, "zipcode")) == 21231 )
)

# -------- Part 5 --------
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile="./housing_idaho.csv")
DT <- fread(file="./housing_idaho.csv")
Rprof()
# means <- sapply(split(DT$pwgtp15,DT$SEX), mean)
# means <- rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
# means <- mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
# means <- tapply(DT$pwgtp15, DT$SEX,mean)
# means <- mean(DT$pwgtp15, by=DT$SEX)
means <- DT[,mean(pwgtp15), by=SEX]
Rprof(NULL)
summaryRprof("Rprof.out")

system.time({
  means <- sapply(split(DT$pwgtp15,DT$SEX), mean)
  # means <- rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
  # means <- mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
  # means <- tapply(DT$pwgtp15, DT$SEX,mean)
  # means <- mean(DT$pwgtp15, by=DT$SEX)
  # means <- DT[,mean(pwgtp15), by=SEX]
})
