# Load libraries 
library(dplyr)
library(magrittr)
library(tidyr)
library(rjson)

result <- fromJSON(file = "./la-county-neighborhoods-v6.geojson")
data <- read.csv("./LA_Dist.csv", sep=",", header=T, check.names = FALSE, stringsAsFactors = FALSE)
cityval <- rep("", length(result$features))


for (i in 1:length(result$features)) {
  check <- 0;
  for(j in data$Districts){
    if (j == result$features[[i]]$properties$name){
      check <- 1
      break
    }
  }
  if(check == 1){
    cityval[i] <- "Los Angeles"
  }
  else {
    cityval[i] <- result$features[[i]]$properties$name
  }
}


city <- c("Rolling Hills Estates", "Rolling Hills", "Palos Verdes Estates")
for (i in 1:length(cityval)) {
  check <- 0;
  for(j in city){
    if (j == cityval[i]){
      check <- 1
      break
    }
  }
  if(check == 1){
    cityval[i] <- "Palos Verdes Peninsula"
  }
}


city <- c("Whittier Narrows", "North Whittier", "West Whittier-Los Nietos", "South Whittier", "East Whittier")
for (i in 1:length(cityval)) {
  check <- 0;
  for(j in city){
    if (j == cityval[i]){
      check <- 1
      break
    }
  }
  if(check == 1){
    cityval[i] <- "Whittier"
  }
}


for(i in 1:length(cityval)){
  if(cityval[i] == "South San Gabriel"){
    cityval[i] <- "San Gabriel"
  }
  if(cityval[i] == "East San Gabriel"){
    cityval[i] <- "San Gabriel"
  }
  if(cityval[i] == "La Habra Heights"){
    cityval[i] <- "La Habra"
  }
  if(cityval[i] == "East Pasadena"){
    cityval[i] <- "Pasadena"
  }
  if(cityval[i] == "San Pasqual"){
    cityval[i] <- "Pasadena"
  }
  if(cityval[i] == "West Puente Valley"){
    cityval[i] <- "La Puente"
  }
  if(cityval[i] == "Unincorporated Santa Monica Mountains"){
    cityval[i] <- "Malibu"
  }
  if(cityval[i] == "North El Monte"){
    cityval[i] <- "El Monte"
  }
  if(cityval[i] == "Northwest Palmdale"){
    cityval[i] <- "Palmdale"
  }
  if(cityval[i] == "Castaic Canyons"){
    cityval[i] <- "Canyon Country"
  }
  if(cityval[i] == "Tujunga Canyons"){
    cityval[i] <- "Tujunga"
  }
  if(cityval[i] == "Hasley Canyons"){
    cityval[i] <- "Canyon Country"
  }
  if(cityval[i] == "La Crescenta-Montrose"){
    cityval[i] <- "La Crescenta"
  }
  if(cityval[i] == "Unincorporated Catalina Island"){
    cityval[i] <- "Avalon"
  }
  if(cityval[i] == "Unincorporated Santa Susana Mountains"){
    cityval[i] <- "Valencia"
  }
  if(cityval[i] == "Val Verde"){
    cityval[i] <- "Castaic"
  }
  if(cityval[i] == "Sun Village" | cityval[i] == "Northeast Antelope Valley" | cityval[i] == "Southeast Antelope Valley"| cityval[i] == "Lake Los Angeles"){
    cityval[i] <- "Littlerock"
  }
}

for (i in 1:length(result$features)) {
  result$features[[i]]$properties$cityname <- cityval[i]
}

result <- toJSON(result)
write(result, "result.geojson")

