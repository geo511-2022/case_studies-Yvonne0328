library(ggplot2)
library(gapminder)
library(dplyr)

# head(gapminder)
dataN <- gapminder %>%
  filter(country != "Kuwait")

# plot1
plot1 <- ggplot(dataN, aes(lifeExp, gdpPercap , color = continent, size=pop/100000))+
  geom_point()+
  theme_bw()+
  scale_y_continuous(trans = "sqrt")+
  facet_wrap(~year,nrow=1)+
  labs("color = continent, size = population(100k)")+
  xlab("life expectancy")+
  ylab("GDP per capita")

#data2
gapminder_continent <- dataN %>% 
  group_by(continent, year) %>%    
  summarize(
    gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop),
    pop = sum(as.numeric(pop))) %>% 
  ungroup() 

#plot2
plot2 <- ggplot(dataN, aes(year, gdpPercap))+
  geom_line(aes(color = continent, group=country))+
  geom_point(aes(color = continent, group=country))+
  geom_line(data = gapminder_continent, aes(year, gdpPercapweighted))+
  geom_point(data = gapminder_continent, aes(year, gdpPercapweighted, size=pop/100000))+
  facet_wrap(~continent,nrow=1)+
  theme_bw()+
  labs(size = "population")+
  xlab("year")+
  ylab("GDP per capita")


#save the plots
png(file = "task3-1.png", width = 1000, height = 500)
plot1
dev.off()

png(file = "task3-2.png", width = 1000, height = 500)
plot2
dev.off()
