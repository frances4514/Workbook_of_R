# 一段绘制普通箱型图的语句

ggplot(mydata, aes(Class, Value))+
  
  #这一行创建了一个箱线图，通过fill = Class将不同类别的数据以不同颜色进行填充。
  #notch = FALSE表示不绘制缺口。
  geom_boxplot(aes(fill = Class),notch = FALSE)+
  
  #这一行创建了一组抖动点图，用于显示每个类别的数据分布。
  
  geom_jitter(binaxis = "y",                      #binaxis = "y"表示在Y轴方向进行抖动。
              position = position_jitter(0.3),    #position_jitter(0.3)指定了抖动的幅度为0.3。
              stackdir = "center",                #stackdir = "center"将点在Y轴方向进行堆叠，并以"center"为基准。
              dotsize = 0.4)                      #dotsize = 0.4表示抖动点的大小为0.4。