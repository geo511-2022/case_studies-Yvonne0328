data(iris)
head(iris)# read the head
library(ggplot2)
petal_length_mean <- mean(iris$Petal.Length)
p1 <- hist(iris$Petal.Length)
p2 <- ggplot(iris, aes(x=Petal.Length, fill = Species)) +  
  geom_histogram(alpha=0.9) +
  ggtitle("Petal.Length")+
  theme(plot.title = element_text(hjust = 0.5))

p2
plot(p1)
