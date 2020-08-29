# list.dirs("..")
hospital_data <- read.csv("../w4/data/hospital-data.csv")

care_outcome <- read.csv("../w4/data/outcome-of-care-measures.csv",
                         na.strings = "Not Available",
                         stringsAsFactors = FALSE)

outcomes = c("heart attack"=11, "heart failure"=17, "pneumonia"=23)


# best(state, mortality-type)
best <- function(state, mort_type) {
  tmp <- care_outcome[, c(2, 7, outcomes[mort_type])]
  names(tmp) <- c("hospitalName", "state", "mort_rate")
  tmp <- tmp[complete.cases(tmp), ]
  tmp <- tmp[order(tmp$state, tmp$mort_rate, tmp$hospitalName), ]
  s <- split(tmp, tmp$state)
  s[[state]][1,]
}
# best("SC", "heart attack")
# best("NY", "pneumonia")
# best("AK", "pneumonia")


# rankhospital(state, mortality-type, row [1-n or 1-"worst"])
rankhospital <- function(state, mort_type, row) {
  tmp <- care_outcome[, c(2, 7, outcomes[mort_type])]
  names(tmp) <- c("hospitalName", "state", "mort_rate")
  tmp <- tmp[complete.cases(tmp), ]
  tmp <- tmp[order(tmp$state, tmp$mort_rate, tmp$hospitalName), ]
  s <- split(tmp, tmp$state)
  if (row != "worst") {
    s[[state]][row, ]
  }
  else {
    s[[state]][nrow(s), ]
  }
}
# rankhospital("NC", "heart attack", "worst")
# rankhospital("WA", "heart attack", 7)
# rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)


# rankall(mortality-type, row [1-n or 1-"worst"])
rankall <- function(mort_type, row) {
  tmp <- care_outcome[, c(2, 7, outcomes[mort_type])]
  names(tmp) <- c("hospitalName", "state", "mort_rate")
  tmp <- tmp[complete.cases(tmp), ]
  tmp <- tmp[order(tmp$state, tmp$mort_rate, tmp$hospitalName), ]
  s <- split(tmp, tmp$state)
  # browser()
  hosp <- if (row == "worst") {
    lapply(s, function (s) s[nrow(s), 1])
  }
  else if (row == "best") {
    lapply(s, function (s) s[1, 1])
  }
  else {
    lapply(s, function (s) s[row, 1])
  }
  hosp
}

# rankall("heart attack", 4)[["HI"]]
# rankall("pneumonia", "worst")[["NJ"]]
rankall("heart failure", 10)[["NV"]]
# as.character(subset(r, state == "HI")$hospital)
