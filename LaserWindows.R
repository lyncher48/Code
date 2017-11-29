#Package installation
list.of.packages <- c("pracma") #라이브러리 명칭 공유
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Library Loading
#library(CCA)
library(pracma)

####Laser Overlap Windows Moving Handler####

####Methods, Good to Know 
#Hampel filter
#OverLapSplit
floor(9/2)
#Function to Split Data Frame
OverlapSplit <- function(x,size=1,overlap=0){
  if(NCOL(x) > 1)
    stop("Data set has more than 2 rows.")
  
  nrows <- NROW(x)
  #nperdf <- ceiling( (nrows + overlap*nsplit) / (nsplit+1) )
  start <- seq(1, floor(length(x)/size + 1)*(size-overlap)+1, by= size)
  
  if( size-overlap > 0 )
    stop("Size must be larger than overlap.")
  
  if( start[size+1] + size != nrows )
    warning("Returning an incomplete dataframe.")
  
  data.frame(t(sapply(start, function(i) x[c(i:(i+size-1))])))
}

#File list from folder
dir <- list.files(path = "~/code/Laser", full.names = TRUE, recursive = TRUE)
dir <- list.files(path = "D:/Rproject/code/Laser", full.names = TRUE, recursive = TRUE)

size = 10


i = 1
#csv 읽기
for(i in 1:length(dir)) {
  Laser <- read.csv(dir[i], header = TRUE, sep = "\t", skip = 0, colClasses = c("numeric", "numeric", "NULL"))[-1,]
  #hampel(Laser[,2], 5, t0 = 3)
  Data <- OverlapSplit(Laser[1:30,2], size=10, overlap=3)
}
