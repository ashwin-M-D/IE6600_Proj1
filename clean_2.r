# Load libraries 
library(dplyr)
library(magrittr)
library(tidyr)


answer1 <- read.csv("./la-county-neighborhoods-v6.csv", sep=",", header=T, check.names = FALSE, stringsAsFactors = FALSE)


data <- read.csv("./LA_Dist.csv", sep=",", header=T, check.names = FALSE, stringsAsFactors = FALSE)
cityval <- rep("", length(answer1$name))


for (i in 1:length(answer1$name)) {
  check <- 0;
  for(j in data$Districts){
    if (j == answer1$name[i]){
      check <- 1
      break
    }
  }
  if(check == 1){
    cityval[i] <- "Los Angeles"
  }
  else {
    cityval[i] <- answer1$name[i]
  }
}

answer1$cityname <- cityval
write.csv(answer1,"clean_2.csv")
