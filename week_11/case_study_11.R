library(tidyverse)
library(spData)
library(sf)

## New Packages
library(mapview) # new package that makes easy leaflet maps
library(foreach)
library(doParallel)
registerDoParallel(4)
getDoParWorkers() # check registered cores

library(tidycensus)
census_api_key("XXXXXX")
library(tidycensus)
racevars <- c(White = "P005003", 
              Black = "P005004", 
              Asian = "P005006", 
              Hispanic = "P004003")

options(tigris_use_cache = TRUE)
erie <- get_decennial(geography = "block", variables = racevars, 
                      state = "NY", county = "Erie County", geometry = TRUE,
                      summary_var = "P001001", cache_table=T) 
crop <- st_crop(erie, c(xmin=-78.9,xmax=-78.85,ymin=42.888,ymax=42.92))

# crop$variable=as.factor((crop$variable))
# crop$variable = levels(crop$variable)

point <- foreach(i = 1:4,.combine=rbind)  %do%
  { crop %>%
      filter(variable==unique(crop$variable)[i]) %>%
      st_sample(size=.$value) %>% 
      st_as_sf() %>% 
      mutate(variable=unique(crop$variable)[i])
    
  }

mapview(point,zcol='variable',cex=1,alpha=0)
