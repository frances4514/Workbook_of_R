#二维散点图与统计直方图的结合，简单的方法是使用ggpubr包的ggscatterhist()函数
library(ggplot2)
library(ggpubr)
library(RColorBrewer)

#利用rnorm()函数指定mean和sd可生成几组随机数
N<-200
x1 <- rnorm(mean=1.5, sd=0.5,N)
y1 <- rnorm(mean=2,sd=0.2, N)
x2 <- rnorm(mean=2.5,sd=0.5, N)
y2 <- rnorm(mean=2.5,sd=0.5, N)
x3 <- rnorm(mean=1, sd=0.3,N)
y3 <- rnorm(mean=1.5,sd=0.2, N)

#创建数据框
data <- data.frame(x=c(x1,x2,x3), y=c(y1,y2,y3), class=rep(c('A','B','C'), each=200))
data

#散点图+统计直方图
ggscatterhist(data, x='x', y='y',
              shape=21, color = 'black', fill='class', size=3, alpha=0.8,
              palette = c("#00AFBB", "#E7B800", "#FC4E07"),
              margin.plot = 'histogram',
              margin.params = list(fill='class', color='black', size=0.2),
              legend = c(0.9, 0.17),
              ggtheme = theme_minimal())

#更改margin.plot的参数换成核密度图，顺便换个颜色
library(wesanderson)
wes_palette("Darjeeling1")
ggscatterhist(data, x='x', y='y',
              shape=21, color = 'black', fill='class', size=3, alpha=0.8,
              palette = c("#E83720", "#489D8B", "#E6B03A"),
              margin.plot = 'density',
              margin.params = list(fill='class', color='black', size=0.2),
              legend = c(0.9, 0.17),
              ggtheme = theme_minimal())