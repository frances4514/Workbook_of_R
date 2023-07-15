library(ggplot2)

#原始数据
mydata<-data.frame(Name=paste0("Project",1:5),Scale=c(35,30,20,10,5),ARPU=c(56,37,63,57,59))
mydata

#构造矩形x轴的起点（最小点）
mydata$xmin<-0
for (i in 2:5){
  mydata$xmin[i]<-sum(mydata$Scale[1:i-1])
}
mydata
#构造矩形X轴的终点（最大点）
for (i in 1:5){
  mydata$xmax[i]<-sum(mydata$Scale[1:i])
}
mydata
#构造数据标签的横坐标：
for (i in 1:5){
  mydata$label[i]<-sum(mydata$Scale[1:i])-mydata$Scale[i]/2
}
mydata

#绘图
ggplot(mydata)+
  geom_rect(aes(xmin=xmin,xmax=xmax,ymin=0,ymax=ARPU,fill=Name),colour="black",size=0.25)+
  geom_text(aes(x=label,y=ARPU+3,label=ARPU),size=4,col="black")+
  geom_text(aes(x=label,y=-2.5,label=Name),size=4,col="black")+
  ylab("ARPU")+
  xlab("scale")+
  ylim(-5,80)+
  theme(panel.background=element_rect(fill="white",colour=NA),
        panel.grid.major = element_line(colour = "grey60",linewidth =.25,linetype ="dotted" ),
        panel.grid.minor = element_line(colour = "grey60",linewidth =.25,linetype ="dotted" ),
        text=element_text(size=15),
        plot.title=element_text(size=15,hjust=.5),#family="myfont",
        legend.position="none"
  )
#panel.background：设置面板背景的样式，使用element_rect()函数设置填充色为白色（"white"），边框颜色为无（"NA"）。
#panel.grid.major：设置主要网格线的样式，使用element_line()函数设置颜色为灰色（"grey60"），线条粗细为0.25（".25"），线条类型为虚线（"dotted"）。
#panel.grid.minor：设置次要网格线的样式，使用element_line()函数设置颜色为灰色（"grey60"），线条粗细为0.25（".25"），线条类型为虚线（"dotted"）。
#text：设置文本的样式，使用element_text()函数设置文本大小为15。
#plot.title：设置图表标题的样式，使用element_text()函数设置文本大小为15，水平对齐方式为居中（"hjust=.5"）。
#legend.position：设置图例的位置，设置为"none"表示不显示图例