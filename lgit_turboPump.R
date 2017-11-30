list.of.packages <- c("plotly") #라이브러리 명칭 공유
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(plotly)


#########################################################
############이노텍 터보펌프 텍스트파일 읽기##############
#########################################################
directory <- "/home/mooyeob.lee/Code/LGIT"

data <- c()
path <- list.dirs(path = paste(directory, sep = ''), full.names = TRUE, recursive = FALSE)
MachineName <- substr(path, sapply(path, function(x) { tail(gregexpr("/", path)[[1]], 1) + 1 }), stringi::stri_length(path))
for(i in 1:length(path)) {
  dir <- list.files(path = path[i], full.names = TRUE, recursive = TRUE)
  robot <- c()
  size <- length(dir)
  for(j in 1:size) {
    cat("\r", MachineName[i], " is ", ceiling(j/(size+1)*100), "% complete.\r", sep = '')
    temp <- read.csv(dir[j], skip=5, header = TRUE)
    robot <- rbind(robot, temp)  
  }
  cat(MachineName[i], " is 100% complete.\r\n", sep = '')
  assign(paste0(MachineName[i]), robot)
  remove(robot, temp)
}  
#head(MESA_ICP_1)
#head(MESA_ICP_2)
#head(MESA_ICP_4)

###########################################
############ 로그데이터 분할 ##############
###########################################
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


########################################################
############ 일자 + 시간 결합 및 형식변환 ##############
########################################################
MESA_ICP_1_date <- MESA_ICP_1;MESA_ICP_2_date <- MESA_ICP_2;MESA_ICP_4_date <- MESA_ICP_4;

DateFormat <- function(Data) {
  Date <- paste0(Data$"Date" , " " , Data$"Time")
  strptime(Date, "%Y-%m-%d %H:%M:%S", tz = "GMT")
}

MESA_ICP_1_date$Time <- DateFormat(MESA_ICP_1)
MESA_ICP_2_date$Time <- DateFormat(MESA_ICP_2)
MESA_ICP_4_date$Time <- DateFormat(MESA_ICP_4)


MESA_ICP_1_date$Time <- as.POSIXct(MESA_ICP_1_date$Time)
MESA_ICP_2_date$Time <- as.POSIXct(MESA_ICP_2_date$Time)
MESA_ICP_4_date$Time <- as.POSIXct(MESA_ICP_4_date$Time)

for(i in 1:length(dir)) {
  #hampel(Laser[,2], 5, t0 = 3)
  Data1 <- OverlapSplit(MESA_ICP_1[1:3000,14], size=100, overlap=1, TRUE)
  Data2 <- OverlapSplit(MESA_ICP_2[1:3000,14], size=100, overlap=1, TRUE)
  Data3 <- OverlapSplit(MESA_ICP_2[1:3000,14], size=100, overlap=1, TRUE)
}
library(plotly)

names(MESA_ICP_1)
# [1] "Date"              "Time"              "Op..Mode"          "WarningNum"        "WarningCode"       "FailureNum"        "FailureCode"      
# [8] "SpeedPulse.rpm."   "DC.LinkVoltage.V." "MotorCurrent.A."   "MotorTemp.deg.C."  "CtrlTemp.deg.C."   "TmsTemp.deg.C."    "PosXh.um."        
# [15] "PosYh.um."         "PosXb.um."         "PosYb.um."         "PosZ.um."          "VibH.um.p.p."      "VibB.um.p.p."      "CXh..A."          
# [22] "CXh..A..1"         "CYh..A."           "CYh..A..1"         "CXb..A."           "CXb..A..1"         "CYb..A."           "CYb..A..1"        
# [29] "CZ..A."            "CZ..A..1"          "PumpHour"          "PumpMin"           "CtrlHour"          "CtrlMin"           "TimeInfo"  

plot_ly(MESA_ICP_1_date, x = ~Time, y =~MotorCurrent.A. , mode = 'lines')
plot_ly(MESA_ICP_2_date, x = ~Time, y =~MotorCurrent.A. , mode = 'lines')
plot_ly(MESA_ICP_4_date, x = ~Time, y =~MotorCurrent.A. , mode = 'lines')


as.POSIXct(paste0(MESA_ICP_1$"Date" , " " , MESA_ICP_1$"Time"))
as.numeric(MESA_ICP_1$"MotorCurrent.A.")
size = 7
overlap = 3
noOverlap <- size-overlap
x <- MESA_ICP_1[1:30,2]
start <- seq(1, (floor(length(x)/noOverlap)-1)*noOverlap+overlap, by= noOverlap)

size = 6; overlap = 3
noOverlap <- size-overlap

#nperdf <- ceiling( (nrows + overlap*nsplit) / (nsplit+1) )
#start <- seq(1, floor(length(x)/size + 1)*(size-overlap)+1, by= size)
start <- seq(1, (floor(length(x)/noOverlap)-1)*noOverlap+overlap, by= size)
data.frame(t(sapply(start, function(i) x[c(i:(i+size-1))])))

library(dplyr)
subdata %<% MESA_ICP_2_date

subdata <- head(MESA_ICP_2_date[which(as.Date(MESA_ICP_2_date$Time) == "2017-11-19"),]) %>% 
  group_by(as.Date(MESA_ICP_2_date$Time)) %>% 
  summarise(Current = mean(MotorCurrent.A.))
head(MESA_ICP_2_date[which(as.Date(MESA_ICP_2_date$Time) == "2017-11-19"),])
as.Date(MESA_ICP_2_date$Time)
#===================================================================================
library(plyr)



mean(MESA_ICP_2_date[which(as.Date(MESA_ICP_2_date$Time) == "2017-11-19"),][,"MotorCurrent.A."], na.rm = TRUE)

data_mean <- ddply(MESA_ICP_2_date, c("Date"), summarise, Current = mean(MotorCurrent.A., na.rm = TRUE))
data_sd <- ddply(MESA_ICP_2_date, c("Date"), summarise, Current = sd(MotorCurrent.A., na.rm = TRUE))
data <- data.frame(data_mean, data_sd$Current)[-1,]
data <- rename(data, c("data_sd.Current" = "sd"))
data$Date <- as.factor(data$Date)

p <- plot_ly(data = data, x = ~Date, y = ~Current, type = 'scatter', mode = 'lines+markers',
             error_y = ~list(value = data_sd.Current,
                             color = '#000000'))

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
chart_link = api_create(p, filename="error/bar")
