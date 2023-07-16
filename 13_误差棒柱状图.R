library(ggplot2)
library(RColorBrewer)
library(reshape2)
data <- read.csv(file.choose(), header = TRUE, stringsAsFactors = FALSE)
data
data <- melt(data)
data

ggplot(data, aes(variable, value))+ 
  #柱状图
  stat_summary(fun=mean, fun.args = list(mult=1),geom='bar',fill='grey90',colour="black",width=.7) +
  #误差棒
  stat_summary(fun.data = mean_sdl, fun.args = list(mult=1),geom='errorbar', color='black',width=.2) + 
  #抖动散点图
  geom_jitter(aes(fill = variable),position = position_jitter(0.2),shape=21, size = 1.5, alpha=0.7)+
  
  scale_fill_brewer(palette = 'Set1')+
  
  labs(x='water parameters', y='content', title = 'contents of water parameters')+
  
  theme(
    plot.title = element_text(size = 15, hjust = 0.5),
    axis.title = element_text(size = 14, hjust = 0.5),
    axis.text = element_text(size = 12, colour = "black"),
    legend.position = 'none')
  
 

