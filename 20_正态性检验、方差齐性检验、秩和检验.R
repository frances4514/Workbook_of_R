
data("Boston", package = "MASS")

# 例子：检测在河边(chas=1)或不在河边(chas=0)的房价(medv)是否有差异？有什么样的差异？

# 1.正态性检验

chas_1 <- subset(Boston, chas==1)
chas_0 <- subset(Boston, chas==0)
shapiro.test(chas_1$medv)
shapiro.test(chas_0$medv)

# p<0.05，说明该变量的分布与正态分布有显著差异，不满足正态分布


# 2.方差齐性检验
library(car)

# (1) 数据满足正态性-Barlett法

# bartlett.test(x~y, data= )，x为分组变量，y为数值变量

# (2) 数据不满足正态性-levene法，
# 组均值的表示方式可以为mean、median、Trimmed Mean(截取平均数，即去掉最大、最小几个值后的平均数)等等

leveneTest(Boston$medv, Boston$chas, center=median)
leveneTest(Boston$medv, Boston$chas, center=mean)

# p<0.05，说明两组方差有显著差异，不满足方差齐性


# 3.Wilcoxon秩和检验

# (1)双侧检验
wilcox.test(chas_0$medv, chas_1$medv, data = Boston, alternative = c("two.sided"))
# W = 5605.5, p-value = 0.001582 < 0.05, 说明河边与不在河边（CHAS）的房价有显著差异

# (2)单侧检验
wilcox.test(chas_0$medv, chas_1$medv, data = Boston, alternative = c("less"))
# p-value = 0.0007908，推翻原假设(H0)，选择备择假设(H1)：不在河边(chas=0)的房价低于在河边(chas=1)的房价

wilcox.test(chas_1$medv, chas_0$medv, data = Boston, alternative = c("greater")),
# 该语句意思与上句相同，H1：(逗号)前组比(逗号)后组"less" or "greater"





