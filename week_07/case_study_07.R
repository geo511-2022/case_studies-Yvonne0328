# library(tidyverse)
# run this first
library(reprex)
# library(sf)

# copy these
library(ggplot2)
library(spData)
data(world)
ggplot(world, aes(x=gdpPercap, y=continent, color=continent))+
  geom_density(alpha=0.5,color=F)


