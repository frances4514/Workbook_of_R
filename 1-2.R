library(ggplot2)
library(car)

data("Boston", package = "MASS")

# 1.变量MEDV的正态性检验
qqnorm(Boston$medv)
qqline(Boston$medv)
shapiro.test(Boston$medv)
# 结果显示，p-value = 4.941e-16，p<0.05, 房价中位数（MEDV）不服从正态分布
#-----------------------------------------------------------------------------------------------------------

# 2.地理位置（河边chas=1，非河边chas=0）对房价是否存在影响（差异显著性检验）
# (1)正态性检验
chas_1 <- subset(Boston, chas==1)
chas_0 <- subset(Boston, chas==0)
shapiro.test(chas_1$medv)
shapiro.test(chas_0$medv)
# 由结果可知，两组数据都不满足正态性
# (2)由于数据不满足正态性，选择wilcoxon秩和检验进行两组比较
wilcox.test(medv~chas, data = Boston)
# W = 5605.5, p-value = 0.001582 < 0.05, 说明河边与不在河边（CHAS）的房价有显著差异
# (3)箱线图
Boston$chas <- as.character(Boston$chas)
bp <- ggplot(Boston, aes(x=chas, y=medv, fill=chas))+
  geom_boxplot(outlier.size = 0, colour="black")+
  geom_jitter(aes(group=as.factor(chas)), 
              shape=21, alpha=0.5, 
              position=position_jitterdodge())+
  labs(title='Boxplot of chas and medv')+
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
bp
#----------------------------------------------------------------------------------------------------------

# 3.分析一氧化碳浓度NOX与房价MEDV的关系，绘制散点图

# (1)正态性检验
nox_1 <- subset(Boston, chas==1)
nox_0 <- subset(Boston, chas==0)
shapiro.test(nox_1$medv)
shapiro.test(nox_0$medv)
# 两组数据都不满足正态性，选择spearman相关系数
# (2)求spearman相关系数
cor_n <- cor.test(Boston$nox, Boston$medv, method="spearman", exact=FALSE)
cor_n
# spearman相关系数为0.563，NOX与MEDV呈负相关

# (3)判断是否能用线性回归
# 1) 残差是否满足正态分布？
model_1 <- lm(medv~nox, data=Boston)
residuals_1 <- residuals(model_1)
qqnorm(residuals_1)
qqline(residuals_1)
# 看QQ图可认为残差不满足正态分布
# 2) 残差是否满足方差齐性？
library(car)
fit=lm(medv~nox, data=Boston)
ncvTest(fit)
# 得到Chisquare = 2.063412, Df = 1, p = 0.15087，残差不满足方差齐性，同时也不满足正态性，因此不能用线性回归

# (4)绘图，用非参数回归模型
plot <- ggplot(Boston, aes(nox, medv,fill=chas,colour=chas))+
  geom_point(colour='black', size=3, shape=21, alpha=0.4)+
  geom_smooth(method='loess', span=0.4, se=TRUE, alpha=0.3)
plot

# ---------------------------------------------------------------------------------------------------------------
# 4.用多元回归方法找到影响Boston 房价的主要因素, 并进行回归诊断。
model_2 <- lm(medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + tax + ptratio + black + lstat, data = Boston)
summary(model_2)
plot(model_2)
# 可看出除了indus和age外，其他因素都对房价有明显影响。