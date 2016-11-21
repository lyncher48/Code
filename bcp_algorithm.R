
library(bcp)

data("coriell")

chrom11<-as.vector(na.omit(coriell$Coriell.05296[coriell$Chromosome==11]))

bcp.11<-bcp(chrom11)

summary(bcp.11)

plot(bcp.11)


CtrlOxMA <- read.csv("D://업무자료//27. 솔라셀FEMS//99. 문서//08. 에너지모니터링데이터//CtrlOx_MA.csv", header = T)
CtrlOxMA_I1 <- as.vector(na.omit(CtrlOxMA$I1))
bcp_I1 <- bcp(CtrlOxMA_I1)
plot(bcp_I1)
names(CtrlOxMA)
