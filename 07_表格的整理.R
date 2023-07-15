# 表格的整理
# (1) 表格拼接
df1 <- data.frame(x=c("a",'b','c'), y = c(1,2,3))
df2 <- data.frame(z=c("d",'e','f'), q = c(4,5,6))
df3 <- data.frame(x=c("a",'b','c'), y = c(7,8,9))
library(dplyr)
df_c <- bind_cols(df1,df2)
df_c
df_r <- bind_rows(df1,df3)
df_r
# 横向合并时若变量名相同，则自动更改变量名
df_c2 <- bind_cols(df1,df_c)
df_c2

# (2) 表格融合
library(dplyr)
df_1 <- data.frame(x=c("a",'b','c'), y=c(1,2,3))
df_1
df_2 <- data.frame(x=c('a','b','d'), q=c(3,4,7))
df_2
df_l <- dplyr::left_join(df_1, df_2, by='x')
df_l
df_r <- dplyr::right_join(df_1, df_2, by='x')
df_r
df_i <- dplyr::inner_join(df_1, df_2, by='x')
df_i
df_f <- dplyr::full_join(df_1, df_2, by='x')
df_f

# (3) 表格分组操作

# 1) 分组汇总，R内置的aggregate()函数
# 构建一个数据集
df <- data.frame(x=c("A","B","C"), '2020'=c(1,3,4), '2021'=c(3,5,4), '2022'=c(8,2,1), check.names = FALSE)
df
# 宽数据转为长数据
library(tidyr)
df_0 <- tidyr::gather(df, year, value, -x)
df_0
# 根据year分组操作
df_y <- aggregate(value~year, df_0, mean)
df_y
# 同时根据year和x两个变量分组
df_yx <- aggregate(value~year+x, df_0, mean)
df_yx
# 只根据x的分组求year和value的均值
df_0$year <- as.numeric(df_0$year)
df_yv <- aggregate(cbind(year,value)~x, df_0, mean)
df_yv

# 2) 分组运算操作，使用dplyr包的group_by()函数进行分组
# 根据year进行分组求value的均值
library(dplyr)
df_y2 <- df_0 %>%
  dplyr::group_by(year) %>%
  dplyr::summarise(avg=mean(value))
df_y2
# 根据year和x两个变量进行分组求value的均值
df_yx2 <- df_0 %>%
  dplyr::group_by(year, x) %>%
  dplyr::summarise(avg=mean(value))
df_yx2
# 根据x分组求year和value的均值
df_0$year <- as.numeric(df_0$year)
df_yv2 <- df_0 %>%
  dplyr::group_by(x) %>%
  dplyr::summarise(avg1=mean(year), avg2=mean(value))
df_yv2
