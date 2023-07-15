#字符型转日期型
a <- "2023-07-03"
class(a)
a <- as.Date(a)
class(a)
a

#向量
#向量排序、降序
b <- c(1,4,3,5,2)
#index.return=TRUE表示输出排序的索引
order <- sort(b, index.return = TRUE, decreasing = TRUE)
order

#向量的索引
v <- c(1,3,5,6,8,12)
v[2]
v[3:5]
v[c(3:5)]
v[-2]
v[-4]
v[v>4]


#因子
#因子简单来说就是向量+水平(level)

#对于字符型向量来说，因子的水平默认依字母顺序创建
cut <- c("B","F","A","P","G","O")
#cut_facter1就是默认按字母排序，无视了原本cut的顺序
cut_facter1 <- as.factor(cut)
cut_facter1
#加了ordered=TRUE后出现大小排序，也就是字母顺序等价为大小顺序
cut_facter2 <- factor(x=cut, ordered=TRUE)
cut_facter2
#再加上facter()函数可指定level
#同时加上ordered=TRUE和levels=，可将大小顺序设为指定的level顺序
cut_facter3 <- factor(x=cut,
                         levels=c("B","F","O","P","G","A"), 
                         ordered=TRUE)
cut_facter3

#将因子重新转换为数值向量
num_facter <- factor(x=c(1,5,6,4), levels = c(1,6,5,4), ordered = TRUE)
num_facter
num_vector1 <- as.numeric(num_facter)
#先将因子转换为字符型，再转换为数值型才能保留原来的顺序
num_vector2 <- as.numeric(as.character(num_facter))
num_vector1
num_vector2