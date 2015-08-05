best <- function(state, outcome) {
  
  ## Read outcome data
  outcome.data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  #state="TX"
  #outcome="heart attack"
  if (!(state %in% levels(as.factor(outcome.data$State)))) {
    stop("invalid state")
    
  }
  
  if (!(outcome %in% c("heart attack","heart failure","pneumonia"))) {
    stop("invalid outcome")
    
  }
  
  outcome.data=outcome.data[which(outcome.data$State==state),]
  if (outcome=="heart attack"){
    ind=which(names(outcome.data)=="Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")
  } else if (outcome=="heart failure") {
    ind=which(names(outcome.data)=="Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")
  } else if (outcome=="pneumonia") {
    ind=which(names(outcome.data)=="Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  } else {
    stop("something went horribly wrong")
  }
  outcome.data[,ind]=as.numeric(outcome.data[,ind])
  outcome.data=outcome.data[which(!is.na(outcome.data[,ind])),]  
  hosp_min=min(outcome.data[,ind])
  hosp_name=outcome.data$Hospital.Name[which(outcome.data[,ind]==hosp_min)]
  hosp_name=hosp_name[order(hosp_name)[1]]
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  return(hosp_name)  
}


