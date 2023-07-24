library(ggplot2)
library(tidyr)

student <- read.csv(file.choose(), sep = ",", header = TRUE, na.strings = NA)
student <- na.omit(student)

# 1.身高体重年龄的柱状图
shwa <- student[1:4]
shwa <- tidyr::gather(shwa, variable,value, -sex)
#柱状图(合)
bar_sum <- ggplot(shwa, aes(variable, value, fill=sex))+
  geom_bar(stat='identity', position = position_dodge())+
  ylim(c(0, 200))+
  labs(title='Mean values of age、height and weight')+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
bar_sum

#柱状图(男)
shwa_m <- subset(shwa, sex=='Male')
bar_m <- ggplot(shwa_m, aes(variable, value, fill=variable))+
  geom_bar(stat='identity', position = position_dodge())+
  ylim(c(0, 200))+
  labs(title='Mean values of age、height and weight of male')+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
bar_m
#柱状图(女)
shwa_f <- subset(shwa, sex=='Female')
bar_f <- ggplot(shwa_f, aes(variable, value, fill=variable))+
  geom_bar(stat='identity', position = position_dodge())+
  ylim(c(0, 200))+
  labs(title='Mean values of age、height and weight of female')+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
bar_f
#--------------------------------------------------------------------------------------------------------

# 2.身高体重年龄的箱图、小提琴图
#箱图

bp_age <- ggplot(student, aes(sex, age, fill=sex))+
  geom_boxplot()+
  geom_jitter(aes(group=sex),
              shape=21, alpha=0.5, 
              position=position_jitterdodge())+
  labs(title='Boxplot of age')+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
bp_age

bp_height <- ggplot(student, aes(sex, height, fill=sex))+
  geom_boxplot()+
  geom_jitter(aes(group=sex),
              shape=21, alpha=0.5, 
              position=position_jitterdodge())+
  labs(title='Boxplot of height')+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
bp_height

bp_weight <- ggplot(student, aes(sex, weight, fill=sex))+
  geom_boxplot()+
  geom_jitter(aes(group=sex),
              shape=21, alpha=0.5, 
              position=position_jitterdodge())+
  labs(title='Boxplot of weight')+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
bp_weight

#小提琴图
vp_age <- ggplot(student, aes(sex, age))+
  geom_violin(aes(fill=sex))+
  geom_boxplot(width=0.2)+
  labs(title='Violin plot of age')+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
vp_age

vp_height <- ggplot(student, aes(sex, height))+
  geom_violin(aes(fill=sex))+
  geom_boxplot(width=0.2)+
  labs(title='Violin plot of height')+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
vp_height

vp_weight <- ggplot(student, aes(sex, weight))+
  geom_violin(aes(fill=sex))+
  geom_boxplot(width=0.2)+
  labs(title='Violin plot of weight')+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
vp_weight
#-------------------------------------------------------------------------------------------------------

# 3.1 身高和体重的相关性分析
# (1)两个变量的正态性检验
shapiro.test(student$height)
shapiro.test(student$weight)
# 由结果可知，其中一组数据不满足正态性
# (2)求身高和体重的Spearman相关系数(r)
cor.test(student$height, student$weight, method="spearman", exact=FALSE)
# Spearman相关系数为0.8，呈正相关，身高会影响体重

# 3.2 不同性别身高和体重的相关系数的差异显著性分析
# (1)正态性检验
student_m <- subset(student, sex=='Male')
shapiro.test(student_m$height)
shapiro.test(student_m$weight)
# 男性两组数据都满足正态性，选择pearson相关系数
student_f <- subset(student, sex=='Female')
shapiro.test(student_f$height)
shapiro.test(student_f$weight)
# 女性其中一组数据不满足正态性，选择spearman相关系数

# (2)分别求出男性和女性的相关系数
cor_m <- cor(student_m$height, student_m$weight, method="pearson")
cor_f <- cor(student_f$height, student_f$weight, method="spearman")

# (3)将线性相关系数r转换为统计量z
z_m <- 0.5 * log((1 + cor_m) / (1 - cor_m))
z_f <- 0.5 * log((1 + cor_f) / (1 - cor_f))

# (4)z检验
z <- ((z_m-z_f)-0)/(1/(nrow(student_m)-1)+1/(nrow(student_f)-1))
p <- pnorm(abs(z))
p_value <- 2 * (1 - p)
p_value
# 结果得出p_value=7.764538e-08，说明不同性别的身高对体重的影响有显著性差异
# (5)绘图
ggplot(student, aes(height, weight, fill=sex, colour=sex))+
  geom_point(colour='black', size=3, shape=21, alpha=0.4)+
  geom_smooth(method='auto', span=0.4, se=TRUE, alpha=0.3)+
  scale_fill_manual(values = c("#E88B30", "#489D8B"))+
  labs(title = "Point plot of height and weight")+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.line = element_line(linetype = "solid"),
    axis.ticks = element_line(colour = "black"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 12),
    legend.title = element_text(size = 12),
    panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
