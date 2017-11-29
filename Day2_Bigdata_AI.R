list.of.packages <- c("networkD3", "ggmap", "dplyr", "DT", "data.table") #라이브러리 명칭 공유
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#install.packages("RInside")
library(dplyr)
library(DT)
delivery = read.csv('D:/R_study/RLecture/Data/SKT_DELIVERY.csv')
dim(delivery)
str(delivery)
head(delivery)
data <-  delivery
data$일자 <- as.factor(data$일자)
data$시간대 <- as.factor(data$시간대)
str(data)
nData <- nrow(data)
nData
nVar <- ncol(data)
nVar

for (i in 1:nVar) {
  
  if (!is.numeric( data[, i]) ) {
    cat( colnames(data)[i] , "----------------------------------------------------------------------------------\n\n")
    print(unique(data[, i]))
    cat( "\n\n")
  }
}

subdata <- data %>% 
  group_by(시군구) %>% 
  summarise(통화건수 = sum(통화건수))
class(subdata)
library(data.table)
class(data.table(subdata))

library(ggplot2)

Var.Names <- c("일자", "요일", "시간대", "업종", "시군구")
#aes_string이 key구나!!
for (v.name in Var.Names) {
  
  out <- data %>% 
    group_by_(v.name) %>%             # 텍스트 변수명 사용위해, group_by_ 사용에 유의 (not group_by)
    summarise(통화건수 = sum(통화건수)) 
  
  print(out)
  
  gpt <- ggplot(out, aes_string(x = v.name, y = "통화건수")) + geom_bar(stat = "identity")
  print(gpt)
  
}

#data.table의 경우 Key지정이 되어있으면 검색속도 향상
#data.table 사용하는 경우 데이터 수가 많을 때 data.frame보다 효율적임.
