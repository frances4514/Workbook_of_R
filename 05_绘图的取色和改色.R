install.packages("RColorBrewer")
install.packages("viridis")
install.packages("wesanderson")
install.packages("ggsci")
library(wesanderson)
wes_palette("Darjeeling1")
library(ggsci)
pal_npg("nrc", alpha=0.7)(9)

library(ggplot2)
# 构造一个数据集用来绘图
N <- 100
df <- data.frame(group=rep(c(1,2), each=N*2),
                 y=append(append(rnorm(N,5,1), rnorm(N,2,1)), append(rnorm(N,1,1),rnorm(N,3,1))),
                 x=rep(c("A","B","A","B"),N))
df
#换一种颜色
bp4 <- ggplot(df, aes(x=x, y=y, fill=as.factor(group)))+
  geom_boxplot(
    position = position_dodge(0.75),
    outlier.size = 0, colour="black")+
  geom_jitter(aes(group=as.factor(group)), 
              shape=21, alpha=0.5,
              position=position_jitterdodge(dodge.width = 0.75))+
  scale_fill_manual(values = c("#E64B35B2", "#4DBBD5B2"))
bp4 