####Laser Overlap Windows Moving Handler####

####Methods, Good to Know 
#Hampel filter
#OverLapSplit

#Function to Split Data Frame
OverlapSplit <- function(x,nsplit=1,overlap=0){
  if(NCOL(x) > 1)
    stop("Data set has more than 2 rows.")
  
  nrows <- NROW(x)
  nperdf <- ceiling( (nrows + overlap*nsplit) / (nsplit+1) )
  start <- seq(1, nsplit*(nperdf-overlap)+1, by= nperdf-overlap )
  
  if( start[nsplit+1] + nperdf != nrows )
    warning("Returning an incomplete dataframe.")
  
  data.frame(t(sapply(start, function(i) x[c(i:(i+nperdf-1))])))
}

#라이브러리 설치
list.of.packages <- c("pracma") #라이브러리 명칭 공유
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#라이브러리 로드
#library(CCA)
library(pracma)

#csv 읽기
Laser <- read.csv("~/code/Laser/1st_Blind_normal#01.txt", header = TRUE, sep = "\t", skip = 0, colClasses = c("numeric", "numeric", "NULL"))[-1,]
hampel(Laser[,2], 5, t0 = 3)
OverlapSplit(Laser[1:30,2], nsplit=10, overlap=10)
