corr <- function(directory, threshold=0) {
  complete_data <- c()
  files <- list.files(
    path=directory,
    pattern="*.csv",
    all.files=TRUE,
    full.names=TRUE)
  
  for (id in 1:332) {
    air <- read.csv(file=files[id])
    clean <- air[complete.cases(air), ]
    
    rows <- dim(clean)[1]
    if (rows > threshold) {
      complete_data <- rbind(complete_data, cor(clean[2], clean[3]))
    }
  }
  return(complete_data)
}