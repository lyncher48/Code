#Package installation
list.of.packages <- c("pracma") #라이브러리 명칭 공유
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Library Loading
#library(CCA)
library(plotly)
library(reshape2)
library(pracma)
Sys.setenv(HOME="/home/mooyeob.lee")


#########################################################
##                Text File Reading                    ##
#########################################################
#From Directory
#directory <- paste0(Sys.getenv("HOME"), '/Code/LGC/Lami')

data <- c()
path <- list.dirs(path = paste(directory, sep = ''), full.names = TRUE, recursive = FALSE)
#path <- directory
MachineName <- substr(path, sapply(path, function(x) { tail(gregexpr("/", path)[[1]], 1) + 1 }), stringi::stri_length(path))
for(i in 1:length(path)) {
  dir <- list.files(path = path[i], full.names = TRUE, recursive = TRUE)
  robot <- c()
  size <- length(dir)
  for(j in 1:size) {
    cat("\r", MachineName[i], " is ", ceiling(j/(size+1)*100), "% complete.\r", sep = '')
    temp <- read.csv(dir[j], skip=0, header = TRUE)
    robot <- rbind(robot, temp)  
  }
  cat(MachineName[i], " is 100% complete.\r\n", sep = '')
  #Directory Name is Assigned to Data Obj.
  assign(paste0(MachineName[i]), robot)
  remove(robot, temp)
}
MachineName
head(LGC)

#########################################################
##                  Data Munging                       ##
#########################################################
#Data Interpolation
#...Skipped...

#Zero Value Removal
try (mLGC <- subset(No1, select = -X))
#head(mLGC)
Temp <- apply(mLGC[-c(1:3)], 2, function(x) { if (is.numeric(x)) { which(x == 0) }})
UnionList <- Reduce(union, Temp)
m1LGC <- mLGC[-UnionList,]
length(UnionList) / length(mLGC[,1])
#Datetime formating
m2LGC <- m1LGC
m2LGC$YY.MM.DD.HH.MM.SS <- as.POSIXct(strptime(m1LGC$YY.MM.DD.HH.MM.SS, "%Y%m%d %H%M%S", tz = "GMT"))

names(m2LGC)

m2LGC_ori <- mLGC
m2LGC_ori$YY.MM.DD.HH.MM.SS <- as.POSIXct(strptime(mLGC$YY.MM.DD.HH.MM.SS, "%Y%m%d %H%M%S", tz = "GMT"))
m3LGC_ori <- melt(m2LGC_ori, id.vars = c("YY.MM.DD.HH.MM.SS", "LOT.ID", "GOOD.BAD"))

m3LGC <- melt(m2LGC, id.vars = c("YY.MM.DD.HH.MM.SS", "LOT.ID", "GOOD.BAD"))
head(m3LGC)
p <- plot_ly(m3LGC, x = ~YY.MM.DD.HH.MM.SS, y = ~value, mode = 'lines', split = ~variable)
filter
p <- plot_ly(m3LGC_ori, x = ~YY.MM.DD.HH.MM.SS, y = ~value, mode = 'lines', split = ~variable) %>% filter

#Function to Split Data Frame
OverlapSplit <- function(x,size=1,overlap=0, complete = FALSE){
  if(NCOL(x) > 1)
    stop("Data set has more than 2 rows.")
  
  nrows <- NROW(x)
  noOverlap <- size-overlap
  
  #nperdf <- ceiling( (nrows + overlap*nsplit) / (nsplit+1) )
  #start <- seq(1, floor(length(x)/size + 1)*(size-overlap)+1, by= size)
  start <- seq(1, (floor(length(x)/noOverlap))*noOverlap+overlap, by= noOverlap)
  
  if(complete)
    start <- start[-which((length(x) - size + 1) < start)]
  
  if( size-overlap < 0 )
    stop("Size must be larger than overlap.")
  
  if( tail(start, 1) + size != nrows & !complete)
    warning("Returning an incomplete dataframe.")
  
  data.frame(t(sapply(start, function(i) x[c(i:(i+size-1))])))
}

