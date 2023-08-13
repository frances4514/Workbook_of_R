# 单因素方差分析

# 使用multcomp包中的cholesterol数据集，trt为疗法，response为胆固醇下降量
data(cholesterol, package = 'multcomp')

# 方差分析
fit <- aov(response~trt, data = cholesterol)
summary(fit)
# P=9.8e-13，说明5中疗法的效果差异很大

# 数据处理，新建表格，可观察哪种疗法效果最好，并绘图
library(dplyr)
plotdata <- cholesterol %>%
  group_by(trt) %>%
  summarise(n=n(),
            mean=mean(response),
            sd=sd(response),
            ci=qt(0.975, df=n-1)*sd/sqrt(n))
plotdata

# 绘图
library(ggplot2)
ggplot(plotdata, aes(x=trt, y=mean, group=1)) +
  geom_point(size=3, color='red')+
  geom_line(linetype='dashed', color='darkgrey')+
  geom_errorbar(aes(ymin=mean-ci,
                    ymax=mean+ci),
                width=.1)+
  labs(x="Treatment",
       y="Response",
       title="Mean Plot with 95% Confidence Interval")+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',linewidth=1,fill = NA)) 
