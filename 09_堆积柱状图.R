#-------------------------------堆积柱形图-------------------------------------------------------
library(ggplot2)
library(reshape2)
library(RColorBrewer)
#mydata<-read.csv("StackedColumn_Data.csv",sep=",",na.strings="NA",stringsAsFactors=FALSE)
mydata<-read.csv(file.choose(),sep=",",na.strings="NA",stringsAsFactors=FALSE)
mydata

sum<-sort(rowSums(mydata[,2:ncol(mydata)]),index.return=TRUE)
sum

colsum<-sort(colSums(mydata[,2:ncol(mydata)]),index.return=TRUE,decreasing = TRUE)
colsum

mydata<-mydata[,c(1,colsum$ix+1)]


mydata$Clarity <- factor(mydata$Clarity, levels = mydata$Clarity[order(sum$ix)])
mydata

mydata<-melt(mydata,id.vars='Clarity')
mydata

ggplot(data=mydata,aes(variable,value,fill=Clarity))+
  geom_bar(stat="identity",position="stack", color="black", width=0.7,size=0.25)+
  scale_fill_manual(values=brewer.pal(9,"Greens")[c(6:2)])+
  ylim(0, 15000)+
  theme(
    axis.title=element_text(size=15,face="plain",color="black"),
    axis.text = element_text(size=12,face="plain",color="black"),
    legend.title=element_text(size=14,face="plain",color="black"),
    legend.background  =element_blank(),
    legend.position = c(0.85,0.82)
  )
