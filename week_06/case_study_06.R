library(sp)
library(spData)
library(tidyverse)
library(sf)
library(ncdf4)
library(raster)
library(dplyr)

# download data from world
data(world)
tmax_monthly <- getData(name = "worldclim", var="tmax", res=10)
download.file("https://crudata.uea.ac.uk/cru/data/temperature/absolute.nc","crudata.nc", method = "curl")
tmean=raster("crudata.nc")


# world
worldN <- world %>%
  filter(continent != "Antarctica")
as(worldN,"Spatial") # sf to sp format

# climate data
tmax_annual <- max(tmean)
names(tmax_annual) <- "tmax"

# Calculate the maximum temperature observed in each country
tmax_country <- raster::extract(tmax_annual, worldN, fun=max, na.rm=T, small=T, sp=T)%>%
  st_as_sf(worldN)

# plot
ggplot(tmax_country, aes(fill = tmax))+
  geom_sf()+
  scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)")+
  theme(legend.position = 'bottom')

hottest_continents <- tmax_country %>% 
  group_by(continent) %>%
  arrange(.by_group = TRUE) %>% # sort first by grouping variable. Applies to grouped data frames only
  select(c(name_long, continent, tmax))%>%
  slice_max(order_by = tmax)%>% # select the countries that has the higest tmax
  st_set_geometry(NULL) #drop the geo


