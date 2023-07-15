library(ggplot2)
library(reshape2)
library(RColorBrewer)

mydata <- read.csv(file.choose(), sep = ",", na.strings = "NA", stringsAsFactors = FALSE)
mydata

sum <- sort(rowSums(mydata[,2:ncol(mydata)]), index.return=TRUE)
sum

col_sum <- sort(colSums(mydata[,2:ncol(mydata)]), index.return=TRUE, decreasing = TRUE)
col_sum

mydata <- mydata[,c(1, col_sum$ix+1)]
mydata

mydata$site_name <- factor(mydata$site_name, levels = mydata$site_name[order(sum$ix)])
mydata

mydata <- melt(mydata, id.vars='site_name')
mydata

ggplot(data = mydata, aes(variable, value, fill = site_name))+
  geom_bar(stat="identity", position="stack", color="black", width=0.7, size=0.25)+
  scale_fill_manual(values=brewer.pal(9,"Greens")[c(7:2)])+
  ylim(0, 1000)+
  labs(title = 'water parameters of 6 sites', 
       x = 'water parameters',
       y = 'mg/L')+
  theme(
    plot.title = element_text(face = "plain", size = 18, hjust = 0.5, vjust = 0.5),
    axis.title = element_text(size = 15, face = "plain", color = "black"),
    axis.text = element_text(size = 12, face = "plain", color = "black"),
    legend.title = element_text(size = 13, face = "plain", color = "black"),
    legend.background  = element_blank(),
    legend.position = c(0.85,0.75)
  )