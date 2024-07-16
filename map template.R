rm(list = ls())
setwd("//netid.washington.edu/wfs/EvansEPAR/Project/EPAR/Working Files/446 - ACASA")

#install.packages("dplyr")
#install.packages("haven")
#install.packages("ggplot2")
#install.packages("ggmap")
#install.packages("maps)
#install.packages("sf")
#install.packages("rgdal") 
#install.packages("raster")
#install.packages("maps")

library(ggplot2)
library(ggmap)
library(haven)
library(dplyr)
library(sf)
#library(rgdal)
library(raster)
library(maps)

#For terrain map
#retrieve API key
register_stadiamaps(key = "339cfa3c-fe2f-4e1e-8ac6-386b1d501c4b")

#Define the bounding box for India
bbox <- c(left = 68, bottom = 6, right = 98, top = 36)

#Get the country map from Stamen
india_map <- get_stadiamap(bbox, zoom = 5, maptype = "stamen_terrain_background")

terrain_map <- ggmap(india_map)
terrain_map

#Toner map
#whole country:
path <- "//netid.washington.edu/wfs/EvansEPAR/Project/EPAR/Spatial Data/Raw data/Shape files/India"
india.0 <- st_read(dsn = file.path(path, "Country", "IND_adm0.shp")) %>%  st_transform(crs = 3857)  
plot0 <- ggplot(data=india.0) + geom_sf() +
  theme(
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    axis.text.x = element_blank(),  # Remove x-axis text
    axis.text.y = element_blank(),  # Remove y-axis text
    axis.ticks = element_blank())   # Remove axis ticks
plot0

#Import sub-region shapefile (boundaries from 2011 census)

#states
india.1 <- st_read(dsn = file.path(path, "States", "IND_adm1.shp")) %>%  st_transform(crs = 3857)  
plot1 <- plot0 + geom_sf(data=india.1) 
  
plot1

#districts
india.2 <- st_read(dsn = file.path(path, "Districts", "IND_adm2.shp")) %>%  st_transform(crs = 3857) 

plot2 <- plot0 + geom_sf(data=india.2) 

plot2

#sub-districts
india.3 <- st_read(dsn = file.path(path, "Sub-districts", "IND_adm3.shp")) %>%  st_transform(crs = 3857)  

plot3 <- plot0 + geom_sf(data=india.3) 

plot3


