# 表格的转换，包括长宽数据变换、根据原列计算生成新列、以及表格的排序

# (1) 长数据和宽数据的转换
# 构建一个数据集
df <- data.frame(x=c("A","B","C"), '2020'=c(1,3,4), '2021'=c(3,5,4), '2022'=c(8,2,1), check.names = FALSE)
df

# 利用reshape2包，将二维数据列表转换为一维数据列表，可顺便更改变量名
library(reshape2)
df_melt <- reshape2::melt(df,  # 原数据框
                          id.vars = "x",    # id.vars="标识变量构成的向量(原行名)"
                          variable.name = "年份", # variable.name="分类变量名(列名)"
                          value.name = "死亡数"  # value.name="数值变量名(新建的)"
                          )
colnames(df_melt)[1]="地区"
df_melt

# 或者用tidyr包，tidyr包的语句更简洁，使用包中的gather()函数
library(tidyr)
df_gather <- tidyr::gather(df, year, value, -x)
df_gather
# 同时可将长数据转变为原来的宽数据，tidyr包中的spread()函数
df_spread <- tidyr::spread(df_gather, year, value)
df_spread

# (2) 变量的变换，对原列进行计算并生成新列，用dplyr包里的mutate()函数
library(dplyr)
data1 <- dplyr::mutate(df_gather, value2=value*2)
data1
data2 <- dplyr::mutate(data1, 
                       value3=ifelse(year==2021, value2*2, value2) # value2*2是满足if条件的year的数值，
                       )                                           # 之后的value2是不满足if条件的其他year的数值
data2

# (3) 表格的排序，可用dplyr包中的arrange()函数
# 升序，如按照value的值排序
df_arrange1 <- dplyr::arrange(df_gather, value)
df_arrange1
# 降序，如按照year的值降序
df_arrange2 <- dplyr::arrange(df_gather, desc(year))
df_arrange2
