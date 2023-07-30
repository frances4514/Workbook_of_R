# 导入数据student2
student <- read.csv(file.choose(), sep = ",", header = TRUE, na.strings = NA)
student <- na.omit(student)

# 计算线性回归斜率及其95%置信区间，通过建立线性回归模型获取模型描述
model <- lm(weight ~ height, data = student)
model
summary(model)
# 方程可写为weight = -85.7373 + 0.8524*height, 95%置信区间为估计系数 (0.85242) ± 两个标准误差 (0.06757)

# 或者用confint()函数求95%置信区间：
confint(model, 'height', level=0.95)

# 绘图
library(ggplot2)
ggplot(student, aes(height, weight, fill=sex, colour=sex))+
  geom_point(colour='black', size=2, shape=21, alpha=0.4)+
  geom_smooth(method='lm', span=0.4, se=TRUE, alpha=0.5, linewidth=0.8)+
  scale_fill_manual(values = c("#E64B35B2", "#489D8B"))+
  labs(title = "Point plot of height and weight")+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',linewidth=1,fill = NA))