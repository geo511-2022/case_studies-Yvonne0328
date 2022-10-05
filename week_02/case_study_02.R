library(tidyverse)
library(ggplot2)
dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"
datanyc="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00094728_14_0_1/station.txt"
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1")
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00094728&ds=14&dt=1")
read_table(dataurl)
read_table(datanyc)
temp_Buffalo=read_table(dataurl,
                        skip=3, #skip the first line which has column names
                        na="999.90", # tell R that 999.90 means missing in this dataset
                        col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                                      "APR","MAY","JUN","JUL",  
                                      "AUG","SEP","OCT","NOV",  
                                      "DEC","DJF","MAM","JJA",  
                                      "SON","metANN"))
temp_NYC=read_table(datanyc,
                    skip=3, #skip the first line which has column names
                    na="999.90", # tell R that 999.90 means missing in this dataset
                    col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                                  "APR","MAY","JUN","JUL",  
                                  "AUG","SEP","OCT","NOV",  
                                  "DEC","DJF","MAM","JJA",  
                                  "SON","metANN"))
#View(temp)
#summary(temp)
p1 <- ggplot(temp_Buffalo,aes(x = YEAR, y = JJA))+
  geom_line()+
  geom_smooth(color = "#ff0000")+
  ggtitle(label = "Mean Summer Temperature in Buffalo, NY", 
          subtitle = "Summer includes June, July, and August
Data from Global Historical Climate Network
Red line is a LOESS smooth")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Mean Summer Temperatures (C)")

p2 <- ggplot(temp_NYC,aes(x = YEAR, y = JJA))+
  geom_line()+
  geom_smooth(color = "#ff0000")+
  ggtitle(label = "Mean Summer Temperature in New York City, NY", 
          subtitle = "Summer includes June, July, and August
Data from Global Historical Climate Network
Red line is a LOESS smooth")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Mean Summer Temperatures (C)")



# legend_colors <- c("#28753f","#baeb34","#632929","#ff0000")

p_all <- ggplot(temp_Buffalo,aes(x = YEAR, y = JJA))+
  geom_line(color = "#28753f")+
  geom_smooth(color = "#baeb34")+
  geom_line(data = temp_NYC, aes(x = YEAR, y = JJA),color = "#632929")+
  geom_smooth(data = temp_NYC,color = "#ff0000")+
  ggtitle("Mean Summer Temperature in New York City and Buffalo", 
          subtitle = "Summer includes June, July, and August
Data from Global Historical Climate Network
Red line is a LOESS smooth in NYC
Green line is a LOESS smooth in Buffalo")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.title.subtitle = element_text((hjust = 0.5)))+
  labs(color = "the legend") + 
  scale_color_manual(values = legend_colors) + 
  theme_bw()+
  ylab("Mean Summer Temperatures (C)")

##facet
# p + facet_grid(rows = vars(drv))




## saving png files
png(file = "task2_BUFFALO.png", width = 480, height = 300)
p1
dev.off()

png(file = "task_NYC.png", width = 480, height = 300)
p2
dev.off()

png(file = "task_all.png", width = 480, height = 300)
p_all
dev.off()
