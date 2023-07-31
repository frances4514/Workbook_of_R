# 设置max.print，改变显示的观测数上限
options(max.print = 10000)
# read.table()可以导入csv和txt格式的文件
mydata <- read.table(file.choose(), header = TRUE, sep = ",")
mydata
# na.strings = "NA"将缺失值标记为NA，没这句话如果表格里有缺失值就会报错
mydata2 <- read.csv(file.choose(), na.strings = "NA")
mydata2
# xlsx包的read.xlsx()可导入xlsx格式的文件
library(xlsx)
mydata3 <- read.xlsx(file.choose(), sheetIndex = 1, na.strings = "NA")
mydata3$Site.Name <- as.character(mydata3$Site.Name)
mydata3

# 用ggplot2包绘制散点图、直方图、箱型图
library(ggplot2)
hp <- ggplot(mydata3, aes(ODO.mg.L))+geom_histogram(bins=30, colour="black", fill="white")
hp
pp <- ggplot(mydata3, aes(x=Site.Name, y=ODO.mg.L))+geom_point()
pp
bp <- ggplot(mydata3, aes(x=Site.Name, y=ODO.mg.L))+geom_boxplot()
bp
# alpha参数可以调整颜色的透明度，范围0-1
barp <- ggplot(mydata3, aes(x=Site.Name, y=ODO.mg.L))+geom_bar(stat="identity", alpha=0.5)
barp
# 散点图可转换为气泡图，fill=和size=设定填充色和大小随数据改变，stroke=可调整轮廓线条的粗细
qp <- ggplot(mydata3, aes(x=Site.Name, y=ODO.mg.L, fill=ODO.mg.L, size=ODO.mg.L))+
  geom_point(shape=21, colour="black", stroke=0.25, alpha=0.8)
qp
# 用颜色表示分组的气泡图，或许呈线性关系的数据比较适合这种图
qp2 <- ggplot(mydata3, aes(x=Temp., y=ODO.mg.L, fill=Site.Name, size=ODO.mg.L))+
  geom_point(shape=21, colour="black", stroke=0.25, alpha=0.8)
qp2
# 折线图+点图，代码没问题，就是数据不合适，画出的图也太tm离谱了
lp <- ggplot(mydata3, aes(x=Temp., y=ODO.mg.L, fill=Site.Name, shape=Site.Name))+
  geom_line()+
  geom_point(size=4, colour="black")+
  scale_fill_manual(values = c("grey60","grey30","black","white"))+
  scale_shape_manual(values = c(21,22,23,24))+
  theme_classic()
lp  
 
