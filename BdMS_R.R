#패키지 설치
install.packages("ggplot2")

#라이브러리 불러오기
library(ggplot2)

#데이터 읽기
BdMS <- read.table("D:/업무자료/18. BdMS/01. 데이터/150409/전체통합DATA_15분단위_0424_절대습도삭제.csv", sep = ",", header= TRUE)

#컬럼명 추출
names(BdMS)
#colnames(BdMS_TRANS)
#[1] "pointDate"                  "DH_02.외기.엔탈피"          "DH_02.외기.절대습도"        "DH_02.외기.온도"           
#[5] "DH_02.외기.습도"            "DH_02.제습전.엔탈피변동"    "DH_02.제습전.엔탈피"        "DH_02.제습전.절대습도"     
#[9] "DH_02.제습전.온도"          "DH_02.제습전.습도"          "DH_02.재생기.급기.온도"     "DH_02.제습후.1차엔탈피변동"
#[13] "DH_02.제습후.1차.엔탈피"    "DH_02.제습후.1차.절대습도"  "DH_02.제습후.1차.온도"      "DH_02.제습후.1차.습도"     
#[17] "DH_02.재생기.배기.온도"     "DH_02.제습후.2차엔탈피변동" "DH_02.제습후.2차.엔탈피"    "DH_02.제습후.2차.절대습도" 
#[21] "DH_02.제습후.2차.온도"      "DH_02.제습후.2차.습도"      "DH_02.냉각코일_1.온도"      "DH_02.냉각코일_2.온도"     
#[25] "DH_02.냉각코일_3.온도"      "DH_02.외기팬.지령"          "DH_02.가압팬.지령"          "DH_02.재생팬.지령"         
#[29] "DH_02.재생기.배기.습도"     "DH_02.재생기.BYPASS.온도"   "DH_02.재생팬.경보"          "DH_02.SRS.차압.MV"         
#[33] "DH_02.SRS.차압.PV"          "DH_02.SRS.차압.SP"          "DH_02.SRS.차압.가열MV"      "DH_02.SRS.차압.냉각MV"     
#[37] "DH_02.재생온도.MV"          "DH_02.재생온도.PV"          "DH_02.재생온도.SP"          "DH_02.재생온도.가열MV"     
#[41] "DH_02.재생온도.냉각MV"      "DH_02.전온도.MV"            "DH_02.전온도.PV"            "DH_02.전온도.SP"           
#[45] "DH_02.전온도.가열MV"        "DH_02.전온도.냉각MV"        "DH_02.후온도.MV"            "DH_02.후온도.PV"           
#[49] "DH_02.후온도.SP"            "DH_02.후온도.가열MV"        "DH_02.후온도.냉각MV"        "DH_02.재생난방밸브"        
#[53] "DH_02.가압팬.상태"          "DH_02.외기팬.상태"          "DH_02.재생팬.상태"          "AHU_24.급기.엔탈피변동"    
#[57] "AHU_24.급기.엔탈피"         "AHU_24.급기.절대습도"       "AHU_24.급기.온도"           "AHU_24.급기.습도"          
#[61] "AHU_24.냉각코일.온도"       "AHU_24.환기.엔탈피"         "AHU_24.환기.절대습도"       "AHU_24.환기.온도"          
#[65] "AHU_24.환기.습도"           "AHU_24.급기팬.지령"         "AHU_24.필터.차압.경보"      "AHU_24.급기팬.경보"        
#[69] "AHU_24.습도.PV"             "AHU_24.습도.SP"             "AHU_24.습도.가열MV"         "AHU_24.습도.냉각MV"        
#[73] "AHU_24.온도.PV"             "AHU_24.온도.SP"             "AHU_24.온도.가열MV"         "AHU_24.온도.냉각MV"        
#[77] "AHU_24.냉방밸브"            "AHU_24.급기팬.상태" 

idx.1 <- BdMS$DH_02.외기.절대습도
idx.2 <- BdMS[,3]
idx.2.preserve <- BdMS[,3, drop=F]
View(idx.1)
View(idx.2)
View(idx.2.preserve)
  
  
#날짜 데이터 삭제
BdMS_TRANS <- BdMS[,-(1:1)]

#값이 변하지 않는 Column 삭제
varzero <- c()
for (i in 1:length(BdMS_TRANS)) {
    if(var(BdMS_TRANS[,i]) == 0) {
      varzero <- c(varzero, i)
    }
}

BdMS_TRANS <- BdMS_TRANS[,-varzero]
#제습전 엔탈피 변동과 상관관계 확인
Result_Corr1 <- cor(BdMS_TRANS2, y = BdMS_TRANS2$"DH_02.제습전.엔탈피변동")

#외기 상대습도가 70 이하인 데이터 삭제 
BdMS_TRANS2 <- BdMS_TRANS[-which(BdMS_TRANS$"DH_02.외기.습도" < 80),]
#제습전 엔탈피 변동과 상관관계 확인(삭제데이터 활용)
Result_Corr2 <- cor(BdMS_TRANS2, y = BdMS_TRANS2$"DH_02.제습전.엔탈피변동")

#양의 상관관계가 높은 순으로 변수 정렬 
SORT_Corr <- sort(Result_Corr, decreasing = TRUE, index.return = TRUE)
Dataframe_Corr <- data.frame(SORT_Corr)
list <- rownames(Result_Corr)
index <- Dataframe_Corr[,2]
for (i in 1:length(index)) {
  Dataframe_Corr[i,2] <- list[index[i]]
}

plot(x = BdMS_TRANS$"DH_02.외기.엔탈피", y = BdMS_TRANS$"DH_02.제습전.엔탈피변동")
plot(x = BdMS_TRANS2$"DH_02.외기.습도", y = BdMS_TRANS2$"DH_02.제습전.엔탈피변동")
#그래프 화면에 분할하여 뿌리기(행, 열)
#제습전 엔탈피 변동과 나머지 변수간의 산점도 그리기
par(mfrow = c(2,2))
for (i in 0:((nrow(BdMS_TRANS)-1)/4)) {
  plot(x = BdMS_TRANS[,list[i*4+1]], y = BdMS_TRANS$"DH_02.제습전.엔탈피변동", xlab=list[i*4+1])
  plot(x = BdMS_TRANS[,list[i*4+2]] , y = BdMS_TRANS$"DH_02.제습전.엔탈피변동", xlab=list[i*4+2])
  plot(x = BdMS_TRANS[,list[i*4+3]], y = BdMS_TRANS$"DH_02.제습전.엔탈피변동", xlab=list[i*4+3])
  plot(x = BdMS_TRANS[,list[i*4+4]], y = BdMS_TRANS$"DH_02.제습전.엔탈피변동", xlab=list[i*4+4])
}
#제습전 엔탈피 변동과 나머지 변수간의 산점도 그리기(삭제된 데이터)
for (i in 0:((nrow(BdMS_TRANS)-1)/4)) {
  plot(x = BdMS_TRANS2[,list[i*4+1]], y = BdMS_TRANS2$"DH_02.제습전.엔탈피변동", xlab=list[i*4+1])
  plot(x = BdMS_TRANS2[,list[i*4+2]] , y = BdMS_TRANS2$"DH_02.제습전.엔탈피변동", xlab=list[i*4+2])
  plot(x = BdMS_TRANS2[,list[i*4+3]], y = BdMS_TRANS2$"DH_02.제습전.엔탈피변동", xlab=list[i*4+3])
  plot(x = BdMS_TRANS2[,list[i*4+4]], y = BdMS_TRANS2$"DH_02.제습전.엔탈피변동", xlab=list[i*4+4])
}

BdMS_TRANS[,list[1]]
plot(x = BdMS_TRANS$"AHU.24._DBsa_7", y = BdMS_TRANS$"총합...엔탈피.")

SCATTERED_PLOT_Data <- BdMS_TRANS[,SCATTERED_PLOT_List]
colnames(SCATTERED_PLOT_Data) <- SCATTERED_PLOT_List 
par(mfrow = c(1,1))
plot(SCATTERED_PLOT_Data, SCATTERED_PLOT_Data)
title(xlab = SCATTERED_PLOT_List)

Y <- summary(glm(총합...엔탈피. ~ 절대습도_RHxa_3 + AHU.24._RHxa_4, data = BdMS_TRANS))


square <- function() {
  square <- scan(sep = ' ', what = "int", n = 4)
}
x <- square()
2 1 4 e

library(GA)
install.packages("scatterplot3d")
library("scatterplot3d")
par(mfrow = c(1, 1))
 scatterplot3d(BdMS_TRANS$"AHU.24._DBoa_1", BdMS_TRANS$"절대습도_RHoa_1", BdMS_TRANS$"총합...엔탈피.", col.axis="blue",
              col.grid="lightblue", main="scatterplot3d - 1", pch=20, angle = 0)














