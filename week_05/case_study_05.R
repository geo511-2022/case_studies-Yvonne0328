library(spData)
library(sf)
library(tidyverse)
library(units) 

data(world) 
data(us_states)
# plot(world[1])
# plot(us_states[1])

# step 1: world
albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
canada <- world %>%
  st_transform(albers)%>%
  filter(name_long == "Canada") %>%
  st_buffer(dist = 10000)

#step 2: us
NY <- us_states %>%
  st_transform(albers)%>%
  filter(NAME == "New York")

#step 3:border
border <- st_intersection(canada, NY)

ggplot()+
  geom_sf(data = NY)+
  geom_sf(data = border, fill = "red")+
  ggtitle("New York Land within 10 km")

AREA <- st_area(border)  %>% set_units(km^2)
AREA
