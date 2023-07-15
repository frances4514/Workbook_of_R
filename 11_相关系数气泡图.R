library(ggplot2)  
library(RColorBrewer)  
library(reshape2)

#这段代码加载了mtcars数据集，该数据集是R内置的一个示例数据集，包含了32辆汽车的性能数据。
#接着，cor函数计算了mtcars数据集中各个变量之间的相关系数，并使用round函数将相关系数四舍五入为一位小数。

data("mtcars")
mat <- round(cor(mtcars), 1)
mat


#这部分代码使用melt函数将mat矩阵转换为长格式的数据框，其中包含了三列：
#Var1表示相关系数的行变量，Var2表示相关系数的列变量，value表示相关系数的值;

mydata <- melt(mat) 
mydata


#这段代码在mydata数据框中添加了一列AbsValue，其中存储了相关系数的绝对值。
#通过abs函数计算相关系数的绝对值，并将结果存储在AbsValue列中。

mydata$AbsValue <- abs(mydata$value)
mydata


ggplot(mydata, aes(x= Var1 , y=Var2)) +
  
  #气泡大小表示相关系数的绝对值，填充颜色表示相关系数，气泡形状为21，气泡边框颜色为黑色
  geom_point(aes(size=AbsValue,fill = value), shape=21, colour="black") +
  
  #设定颜色渐变的三个梯度，即起始(负)、中间(0)、结束颜色(正)；
  #scale_fill_gradientn(colours=c(颜色1, 颜色2, 颜色3))
  #scale_fill_gradientn(colours=c(brewer.pal(7,"Set1")[2],"white",brewer.pal(7,"Set1")[1]),na.value=NA)+
  scale_fill_gradientn(colours=c(brewer.pal(7,"GnBu")[6],"white",brewer.pal(7,"Set1")[1]),na.value=NA)+
  
  #限制气泡的最大面积为12，guide='none'表示不显示大小的指导项
  scale_size_area(max_size=12, guide='none') +
  
  theme(
    text=element_text(size=15,face="plain",color="black"),
    axis.title=element_text(size=13,face="plain",color="black"),
    axis.text = element_text(size=12,face="plain",color="black"),
    legend.position="right"
  )