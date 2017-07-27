####spt analyis####

#라이브러리 설치
list.of.packages <- c("CCA") #라이브러리 명칭 공유
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#라이브러리 로드
library(CCA)
#library(reshape)

#csv 읽기
sputter <- read.csv("~/code/spt_170629_for_2nd_analysis.csv", header = TRUE, sep = ",")

#데이터필터링
sputter <- sputter[,grepl("^[(MG)(P.)].*", colnames(sputter))]

#Null & NA 삭제
sputter <- sputter[complete.cases(sputter),]

which(is.na(sputter)) 
#정준상관분석
Xs <- sputter[,grepl("^MG.*", colnames(sputter))]
Ys <- sputter[,grepl("^(P[.]).*", colnames(sputter))]
result <- matcor(Xs, Ys)
img.matcor(result, type = 2)

#Categories range
range_info <- apply(Xs, 2, unique)
summary(Xs)
