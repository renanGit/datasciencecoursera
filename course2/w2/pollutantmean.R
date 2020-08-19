pollutantmean <- function(directory, pollutant="sulfate", ids=1:332) {
  rows <- 0
  pollute_data <- c(0, 0)
  names(pollute_data) <- c("sulfate", "nitrate")
  
  files <- list.files(
    path=directory,
    pattern="*.csv",
    all.files=TRUE,
    full.names=TRUE)
  
  for (id in ids) {
    air <- read.csv(files[id])
    clean <- air[complete.cases(air), ]
    pollute_data <- pollute_data + colSums(clean[2:3], na.rm = TRUE)
    
    rows <- rows + dim(clean)[1]
  }
  return(pollute_data[pollutant] / rows)
}