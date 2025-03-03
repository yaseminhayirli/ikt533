library(haven)
library(dplyr)
library(tidyverse)
library(ggplot2)

setwd("C:/Users/Bilgisayar/Documents/YH-�dev1/2020-fall/analysis")

data <- read_dta("~/YH-�dev1/2020-fall/data/raw/NEW7080.dta") %>% rename(EDUC = v4,  QOB = v18, YOB= v27  , CENSUS = v16 )

deg<- c("QOB", "EDUC", "YOB", "CENSUS")
data80 <- subset(data, CENSUS==80 & YOB<40, select = c(deg)) %>%  unite(YEARQ, c(YOB, QOB), sep = "/q", remove = FALSE) %>%
  group_by(YEARQ, QOB) %>% summarise(EDUCMEAN= mean(EDUC)) %>% mutate(a= format(YEARQ, format = "%y/0%q"))

ggplot(data80, aes(x = a, y = EDUCMEAN, group= 1, size=1.2))  + geom_point(aes(shape = factor(QOB), size=1.5)) + geom_line() +
  labs(title = "1930- 1939 D�neminde Do�anlar ��in Do�um �eyreklerine G�re Ortalama E�itim S�resi", 
       x="1930-1939", y="Ortalama E�itim S�resi") + theme_light()+ 
  theme_light() + scale_size(guide = 'none') + 
  theme(axis.text.x = element_text(face = "bold", color="black", size = 9, angle = 90))+
  theme(axis.text.y = element_text(face = "bold", color="black", size = 9, angle = 0)) +
  scale_shape(labels = c("1.Do�um �eyre�i", "2.Do�um �eyre�i", "3.Do�um �eyre�i", "4. Do�um �eyre�i"), name = "Do�um �eyrekleri") +
  theme(legend.title = element_text(face="bold")) + theme(legend.position = "bottom")
