# 安装ggThemeAssist包后可通过菜单操作来调整图形
library(xlsx)
mydata <- read.xlsx(file.choose(), sheetIndex = 1, na.strings = "NA")
mydata$Site.Name <- as.character(mydata$Site.Name)
mydata
library(ggplot2)
# 下面是几种不同主题的图
p1 <- ggplot(mydata, aes(x=Site.Name, y=ODO.mg.L))+
  geom_bar(stat="identity", alpha=0.5) + 
  scale_y_continuous(breaks = seq(0,600,50))+
  theme(axis.line = element_line(linetype = "solid"),
    axis.title = element_text(family = "serif",
        size = 15), axis.text = element_text(size = 12),
    panel.background = element_rect(fill = NA))
p1

p2 <- ggplot(mydata, aes(x=Site.Name, y=ODO.mg.L))+
  geom_bar(stat="identity", alpha=0.5) + 
  scale_y_continuous(breaks = seq(0,600,50))+
  theme_test()
p2

p3 <- ggplot(mydata, aes(x=Site.Name, y=ODO.mg.L))+
  geom_bar(stat="identity", alpha=0.5) + 
  scale_y_continuous(breaks = seq(0,600,50))+
  theme_classic()
p3

# 构造一个数据集用来绘图
N <- 100
df <- data.frame(group=rep(c(1,2), each=N*2),
                 y=append(append(rnorm(N,5,1), rnorm(N,2,1)), append(rnorm(N,1,1),rnorm(N,3,1))),
                 x=rep(c("A","B","A","B"),N))
df
# 基本箱型图
bp0 <- ggplot(df, aes(x=x, y=y, fill=as.factor(group)))+
  geom_boxplot(outlier.size = 0, colour="black")
bp0

# 加上geom_jitter()扰动处理出现散点图的效果，也就是抖动散点图
bp1 <- ggplot(df, aes(x=x, y=y, fill=as.factor(group)))+
  geom_boxplot(outlier.size = 0, colour="black")+
  geom_jitter(aes(group=as.factor(group)), 
              shape=21, alpha=0.5)
bp1

# geom_jitter()里的位置参数position改为position_jitterdodge()并列扰动
bp2 <- ggplot(df, aes(x=x, y=y, fill=as.factor(group)))+
  geom_boxplot(outlier.size = 0, colour="black")+
  geom_jitter(aes(group=as.factor(group)), 
              shape=21, alpha=0.5, 
              position=position_jitterdodge())
bp2

# 同时调整箱图(position=position_dodge(数值))和
# 抖动散点图(position=position_jitterdodge(dodge.width=数值))的位置
bp3 <- ggplot(df, aes(x=x, y=y, fill=as.factor(group)))+
  geom_boxplot(
    position = position_dodge(0.75),
    outlier.size = 0, colour="black")+
  geom_jitter(aes(group=as.factor(group)), 
              shape=21, alpha=0.5, 
              position=position_jitterdodge(dodge.width = 0.75))
bp3 

# 关于rep()的理解
N <- 100
a <- rep(c("A","B","A","B"),N)
b <- rep(c("A","B"),each=N*2)
a
b
