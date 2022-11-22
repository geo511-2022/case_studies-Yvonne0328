library(tidyverse)
library(nycflights13)

farthest_airport <- flights %>%
  arrange(desc(distance)) %>%
  slice_head(n = 1) %>%
  left_join(airports, by = c("dest" = "faa")) %>%
  select(name) %>%
  as.character()

farthest_airport  

