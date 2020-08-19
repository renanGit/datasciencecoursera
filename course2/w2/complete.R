complete <- function(directory, ids=1:332) {
  complete_data <- c()
  
  files <- list.files(
    path=directory,
    pattern="*.csv",
    all.files=TRUE,
    full.names=TRUE)
  
  for (id in ids) {
    air <- read.csv(files[id])
    clean <- air[complete.cases(air), ]
    
    rows <- dim(clean)[1]
    complete_data <- rbind(complete_data, c(id, rows))
  }
  return(complete_data)
}