# 绘制底图
library(ggplot2)
library(dplyr)

# 从map_data里加载世界地图
world <- map_data("world")

# 通过限制经纬度大小来截取中国海的地图数据
china_sea <- subset(world, world$long>105 & world$long<130 & world$lat>15 & world$lat<40)

# 用geom_map绘制中国海底图
gp <- ggplot() +
  geom_map(
    data = china_sea, map = world,
    aes(long, lat, map_id = region),
    color = "black", fill = "#f0f0f0", size = 0.3
  ) 
# gp


# 解除下载时间限制
# options(timeout=1000)

# 获取水深数据
# library(marmap)
# Bathy <- getNOAA.bathy(lon1 = 100, lon2 = 150, lat1 = 0, lat2 = 50)
# Bathy_df <- fortify.bathy(Bathy)
# write.csv(Bathy_df, "F:/厦大/研一/上/综述/data/Bathy_df_chinasea.csv")
Bathy_df <- read.csv("F:/厦大/研一/上/综述/data/Bathy_df_chinasea.csv")

Bathy_50 <- subset(Bathy_df,Bathy_df$z>-50)
Bathy_50$z2 <- '<50'

Bathy_100 <- subset(Bathy_df,Bathy_df$z>-100 & Bathy_df$z <= -50)
Bathy_100$z2 <- '50-100'

Bathy_200 <- subset(Bathy_df,Bathy_df$z>-200 & Bathy_df$z <= -100)
Bathy_200$z2 <- '100-200'

Bathy_500 <- subset(Bathy_df,Bathy_df$z>-500 & Bathy_df$z <= -200)
Bathy_500$z2 <- '200-500'

Bathy_3000 <- subset(Bathy_df,Bathy_df$z>-3000 & Bathy_df$z <= -500)
Bathy_3000$z2 <- '500-3000'

Bathy_5000 <- subset(Bathy_df,Bathy_df$z>-5000 & Bathy_df$z <= -3000)
Bathy_5000$z2 <- '3000-5000'

Bathy_more <- subset(Bathy_df,Bathy_df$z <= -5000)
Bathy_more$z2 <- '>5000'

Bathy_sum <- rbind(Bathy_50, Bathy_100, Bathy_200, Bathy_500, 
                  Bathy_3000, Bathy_5000, Bathy_more)

Bathy_sum$z2 <- factor(Bathy_sum$z2, levels=c('<50', '50-100', '100-200', 
                                              '200-500', '500-3000', 
                                              '3000-5000', '>5000'))

# 底图加水深
gp_depth <- gp+ 
  geom_raster(data=Bathy_sum[Bathy_sum$z<=0,], #筛选深度⼩于等于0的数据
              aes(x, y, fill=z2))+
  scale_fill_manual(values = c('>5000'="#2171b5", 
                               '3000-5000'="#4292c6", 
                               '500-3000'="#6baed6",
                               '200-500'="#9ecae1",
                               '100-200'="#c6dbef", 
                               '50-100'="#deebf7",
                               '<50'="#f7fbff"))
gp_depth

# 载入站位数据
oceandata <- read.csv('F:/厦大/研一/上/综述/data/ocean/oceandata.csv')
oceandata$season <- factor(oceandata$season, levels = c('spring', 'summer', 'autumn', 'winter'))
oceandata$Region <- factor(oceandata$Region, levels = c('BS', 'YS', 'ECS', 'TS', 'SCS'))
scs <- subset(oceandata, oceandata$Region=='SCS')
scs <- subset(scs, scs$Lat<25)
ecs <- subset(oceandata, oceandata$Region=='ECS'& oceandata$Lat<33)
bs <- subset(oceandata, oceandata$Region=='BS')
ys <- subset(oceandata, oceandata$Region=='YS')
ts <- subset(oceandata, oceandata$Region=='TS')

# 在水深底图上添加站位
stationmap <- gp_depth+
  geom_point(data=scs, aes(x=Lon, y=Lat, shape=season, color=Region), size=4, stroke=0.73)+
  geom_point(data=ecs, aes(x=Lon, y=Lat, shape=season, color=Region), size=4, stroke=0.73)+
  geom_point(data=bs, aes(x=Lon, y=Lat, shape=season, color=Region), size=4, stroke=0.73)+
  geom_point(data=ys, aes(x=Lon, y=Lat, shape=season, color=Region), size=4, stroke=0.73)+
  geom_point(data=ts, aes(x=Lon, y=Lat, shape=season, color=Region), size=4, stroke=0.73)+
  scale_shape_manual(values=c(2,4,3,9))+
  scale_color_manual(breaks = c('BS', 'YS', 'ECS', 'TS', 'SCS'),
                     labels=c('BS', 'YS', 'ECS', 'TS', 'SCS'),
                     values=c("#E64B35CC", "#00A087FF", "#F39B7FCC", "#3C5488FF", "#7E6148FF"))+
  annotate("text", x = 112, y = 32, label = "China", size=7, color='black')+ 
  scale_x_continuous(expand = c(0,0),limits = c(105,130))+
  scale_y_continuous(expand = c(0,0),limits = c(4,41.5))+
  coord_quickmap()+
  labs(color='Regions', shape='Seasons', fill='Depth(m)',
       x="Longitude(°)", y="Latitude(°)")+
  # 修改三个图例顺序
  guides(color = guide_legend(order = 1), shape = guide_legend(order = 2), fill = guide_legend(order = 3))+
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),
        axis.line = element_line(linetype = "solid"),
        axis.ticks = element_line(colour = "black"),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        panel.background = element_rect(linetype='solid', color='black',size=1,fill = NA)) 
stationmap
