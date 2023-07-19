library(rgdal)   #提供readOGR()函数
library(ggplot2)
library(dplyr)

#----------------------------------(1) 陆地岛屿--------------------------------------------------------------

#dataProjected <- readOGR("Virtual_Map0.shp")
dataProjected <- readOGR(file.choose())

dataProjected@data$id <- rownames(dataProjected@data)

watershedPoints <- fortify(dataProjected) #fortify()函数是一个用于转换数据结构的工具函数，
                                          #主要用于将一些特定的对象或数据类型转换为数据框（data frame）的形式

df_Map <- merge(watershedPoints, dataProjected@data, by = "id")

ggplot()+
  geom_polygon(data=df_Map, aes(x=long, y=lat, group=group,fill=type),colour="black",linewidth=0.25)

#----------------------------------(2) 国家------------------------------------------------------------------

#dataProjected <- readOGR("Virtual_Map1.shp")
dataProjected <- readOGR(file.choose())

dataProjected@data$id <- rownames(dataProjected@data)
watershedPoints <- fortify(dataProjected)

df_Map <- merge(watershedPoints, dataProjected@data, by = "id")

ggplot()+
  geom_polygon(data=df_Map, aes(x=long, y=lat, group=group,fill=country),colour="black",linewidth=0.25)
