library(dplyr)
library(leaflet)

data <- read.csv("meteorite-landings.csv")

data <- na.omit(data[, c("name","year", "reclat", "reclong")])

data <- data %>% 
  filter(year>=2001 & year<=2016) %>%
  filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0))

data <- data[, c("name", "reclat", "reclong")]

data <- rename(data, lat=reclat, lng=reclong)

myMap <- data %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers(clusterOptions = markerClusterOptions(),
             popup = data$name)