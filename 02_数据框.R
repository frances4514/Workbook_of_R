#数据框要求其中的每个向量长度相同（观测数一致）
#创建数据框
x <- c("a","b","c")
y <- c(4,9,6)
z <- c(7,8,12)
df <- data.frame(x, y, z)
df
#提取其中某列,df[2]好像还保留了前面的序号，所以不行
df[,2]
df$y
df[[2]]
#提取其中多列
df[,2:3]
df[c("y","z")]
#提取其中某行
df[2,]
#提取其中多行
df[2:3,]
#提取某个元素
df[2,3]

#创建空白数据框,下列语句创建了有x、y和z三个变量的空白框
df_empty <- data.frame(x = numeric(), y=character(), z=numeric(), stringsAsFactors = FALSE)
df_empty
