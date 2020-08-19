source("pollutantmean.R")
source("complete.R")
source("corr.R")

# needs abs path for windows, R complains that it lacks permission to read if relative
data_dir = paste(getwd(), "specdata", sep="/")

# pollutantmean(directory=data_dir, pollutant="nitrate")

# RNGversion("3.5.1")
# set.seed(42)
# cc <- complete(directory=data_dir, ids=332:1)
# use <- sample(332, 10)
# print(cc[use, ])

cr <- corr(directory=data_dir, threshold=129)
cr <- sort(cr)                
n <- length(cr)    
RNGversion("3.5.1")
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)
