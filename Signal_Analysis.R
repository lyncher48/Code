install.packages("wavelets")
library(wavelets)
??wavelets
X1 <- c(.2,-.4,-.6,-.5,-.8,-.4,-.9,0,-.2,.1,-.1,.1,.7,.9,0,.3)
X2 <- c(.2,-.4,-.6,-.5,-.8,-.4,-.9,0,-.2,.1,-.1,.1,-.7,.9,0,.3)
plot(X1)
plot(X2)
# combine them and compute DWT
newX <- cbind(X1,X2)
wt <- dwt(newX, n.levels=3, boundary="periodic", fast=FALSE)
# align
wt.aligned <- align(wt)
plot(wt.aligned)
help(wt.filter)

####------------------------------------------------------------------------------------------------####
install.packages("wavethresh")
library(wavethresh)

a<-read.table("d:/t1.csv",header=TRUE,sep=",")
#a$DP.Current
a1<-a[a$X==2,]
a1<-as.data.frame(a1$DP.Current)
r1=1
r2=32
out1=NULL
out2=NULL
out11=NULL
out12=NULL
out21=NULL
out22=NULL
for(i in 1:as.integer((nrow(a1)/32)))
{
  a2<-a1[r1:r2,]
  r1=r2+1
  r2=r2+32
  awdS <- wd(a2, filter.number=10, family="DaubLeAsymm", type="wavelet")  #station")
  out1<-append(out1,awdS$D[65:96])
  out2<-append(out2,awdS$C[65:96])
  out11<-append(out11,mean(awdS$D[65:96]))
  out12<-append(out12,sd(awdS$D[65:96]))
  out21<-append(out21,mean(awdS$C[65:96]))
  out22<-append(out22,sd(awdS$C[65:96]))
}
plot(out1,type="l")
plot(out2,type="l")
plot(out11,type="l")
plot(out12,type="l")



