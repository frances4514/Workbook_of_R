# 生成数列的函数seq()
a <- seq(1, 10)
b <- seq(0, 1, by = 0.1)
d <- seq(from = 5, to = 25, length.out = 5)

# NA和NULL的区别
# NA是缺失一个值，但位置保留；NULL是连位置都没有保留，相当于不存在
a1 <- c(1,2,3,NA,NA,NULL,4,5)
length(a1)
sum(a1)
sum(a1, na.rm = TRUE)

# substring()截取字符串
substring('12345', 2)
substring('12345',3,5)

# strsplit()分隔符拆分字符串
strsplit('2023-7-20', '-')

# gsub()替换字符串
gsub('/', '-', '2023/7/20')
gsub(' ', '+', 'a b c')
