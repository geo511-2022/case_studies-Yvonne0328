Case Study 09
================
Yvonne Huang
Nov 1, 2022

## library

``` r
library(sf)
library(tidyverse)
library(ggmap)
library(rnoaa)
library(spData)
```

## data

``` r
# data - polygon
data(world)
data(us_states)


# data - storm
# Download zipped data from noaa with storm track information
dataurl="https://www.ncei.noaa.gov/data/international-best-track-archive-for-climate-stewardship-ibtracs/v04r00/access/shapefile/IBTrACS.NA.list.v04r00.points.zip"

tdir=tempdir()
download.file(dataurl,destfile=file.path(tdir,"temp.zip"))
unzip(file.path(tdir,"temp.zip"),exdir = tdir) #unzip the compressed folder
storm_data <- read_sf(list.files(tdir,pattern=".shp",full.names = T))
```

# data processing

``` r
storms <- storm_data %>%
  filter(SEASON >= 1950) %>%
  mutate_if(is.numeric, function(x) ifelse(x==-999.0,NA,x)) %>%
  mutate(decade=(floor(year/10)*10)) 

region <- storms %>%
  st_bbox()
```

# plots

``` r
ggplot(storms)+
  facet_wrap(~decade)+
  stat_bin2d(data=storms, aes(y=st_coordinates(storms)[,2], x=st_coordinates(storms)[,1]),bins=100)+
  scale_fill_distiller(palette="YlOrRd", trans="log", direction=-1, breaks = c(1,10,100,1000))+
  coord_sf(ylim=region[c(2,4)], xlim=region[c(1,3)])
```

![](case_study_09_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## tables

``` r
# tables
us_states <-  us_states %>%
  st_transform(crs = st_crs(storms))%>%
  select(state = NAME)
storm_states <- st_join(storms, us_states, join = st_intersects,left = F)
table <- storm_states %>%
  group_by(state) %>%
  summarize(storms=length(unique(NAME))) %>%
  arrange(desc(storms)) %>%
  slice(1:5)
```