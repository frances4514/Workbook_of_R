library(ComplexHeatmap)
library(circlize)
library(dendextend)

df<-scale(mtcars) #使用scale()方法对mtcars数据进行标准化，以消除量纲对数据结构的影响(消除不同变量之间的量纲差异)
                  
row_dend = hclust(dist(df))   # 这一行使用hclust()方法对标准化后的数据进行层次聚类分析，生成行的系统性聚类结果。
                              # dist()方法计算了标准化数据之间的距离。

col_dend = hclust(dist(t(df)))  # 根据列对数据进行系统性聚类

mycol <-rev(brewer.pal(n = 7, name = "RdYlBu"))       #构造颜色映射方案，使用了RColorBrewer包中的brewer.pal()方法生成7种颜色，
                                                      #并通过rev()函数将颜色顺序反转


Heatmap(df,                                         #df是要绘制的数据集
        col = mycol,                                #col参数指定了颜色映射方案mycol
        name = "mtcars",                            #name参数设置了图形的名称
        rect_gp = gpar(col = "black"),              #rect_gp参数设置了矩形的边框颜色为黑色
        column_dend_height = unit(4, "cm"),                            #设定列聚类显示部分的高度
        row_dend_width = unit(4, "cm"),                                #设定行聚类显示部分的宽度
        cluster_rows = color_branches(row_dend, k = 4),                #设定行聚类成4类
        cluster_columns = color_branches(col_dend, k = 2))             #设定列聚类成2类