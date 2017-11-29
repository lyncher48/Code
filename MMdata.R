install.packages('reshape')
library(reshape)
library(scales)
library(ggplot2)

robot <- c()

dir <- list.files(path = "//150.150.247.138/d/ISA/2.Agent/HIMM/logs/output/MXMM-04EHIM009/20171102", full.names = TRUE, recursive = TRUE)

for(i in c(1:length(dir))) {
  temp <- read.table(dir[i], sep = ",", header= TRUE)
  robot <- rbind(robot, temp)
}
robot$Time <- strptime(substr(robot$Time, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")

name <- paste(unique(robot$Name))
variable <- paste(unique(robot$Variable))
n <- length(unique(robot$Name))
##robot <- robot[which(robot$Variable == variable[1]),]
sensors <- cast(robot, formula = Time + Name ~ Variable, fun.aggregate = mean,value = "Value")
head(sensors)
for(i in 1:length(name)) {
  fname = paste("D:/data/Share/", name[i], ".csv", sep="")
  write.csv(sensors[which(sensors$Name == name[i]),], file = fname)
}

i = 9
temp <- robot[which(robot$Variable == variable[i]),]
ggplot(temp, aes(Time, Value, color = Name)) +
  geom_line() + ggtitle(variable[i]) + scale_x_datetime(date_minor_breaks = "1 hour", date_breaks = "1 hour", , date_labels = "%H") + theme(axis.text.x = element_text(angle=30, hjust =1))

for(i in c(1:length(variable))) {
  cat(i, "\t")
  temp <- robot[which(robot$Variable == variable[i]),]
  ggplot(temp, aes(Time, Value, color = Name)) +
    geom_line() + ggtitle(variable[i]) + scale_x_datetime(date_minor_breaks = "1 day", date_breaks = "1 day", , date_labels = "%m%d") + theme(axis.text.x = element_text(angle=30, hjust =1))
}
ggplot(temp, aes(Time, Value, color = Name)) + geom_line() + ggtitle(variable[i])

i=3
for(i in (1:length(variable))) {
  print(Injection_plot(i))
}

Injection_plot <- function(i) {
  temp <- robot[which(robot$Variable == variable[i]),]
  ggplot(temp, aes(Time, Value, color = Name)) +
    geom_line() + ggtitle(variable[i]) + scale_x_datetime(date_minor_breaks = "1 hour", date_breaks = "1 hour", , date_labels = "%H") + theme(axis.text.x = element_text(angle=30, hjust =1))
}

for(i in (1:length(variable))) {
  print(Injection_plot(i))
}

description

#########################################################################################
#Read data from file directory
#########################################################################################

# Version1
READ_HIMM <- function(date) {
  # date: eight digit ex) 20171103
  robot <- c()
  path <- list.dirs(path = "//150.150.247.138/d/ISA/2.Agent/HIMM/logs/output/", full.names = TRUE, recursive = FALSE)
  dir <- list.files(path = paste(path, "/", date, sep=""), full.names = TRUE, recursive = TRUE)
  for(i in 1:length(dir)) {
    temp <- read.table(dir[i], sep = ",", header= TRUE)
    robot <- rbind(robot, temp)  
  }
  robot$Time <- strptime(substr(robot$Time, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
  
  # name <- paste(unique(robot$Name))
  # variable <- paste(unique(robot$Variable))
  # n <- length(unique(robot$Name))
  #temp <- robot[which(robot$Variable == variable[j]),]
  #print(ggplot(temp, aes(Time, Value, color = Name)) + geom_line() + ggtitle(variable[j]) + scale_x_datetime(date_minor_breaks = "1 hour", date_breaks = "1 hour", , date_labels = "%H") + theme(axis.text.x = element_text(angle=30, hjust =1)))
  read_Injectiondata <- robot
}
Injection_171102 <- read_Injectiondata("20171102")


# Version2
Injection_plot <- function(j) {
  robot <- c()
  path <- list.dirs(path = "//150.150.247.138/d/ISA/2.Agent/HIMM/logs/output/", full.names = TRUE, recursive = FALSE)
  dir <- list.files(path = paste(path, "/20171102", sep=""), full.names = TRUE, recursive = TRUE)
  for(i in 1:length(dir)) {
    temp <- read.table(dir[i], sep = ",", header= TRUE)
    robot <- rbind(robot, temp)  
  }
  robot$Time <- strptime(substr(robot$Time, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
  
  name <- paste(unique(robot$Name))
  variable <- paste(unique(robot$Variable))
  n <- length(unique(robot$Name))
  temp <- robot[which(robot$Variable == variable[j]),]
  print(ggplot(temp, aes(Time, Value, color = Name)) + geom_line() + ggtitle(variable[j]) + scale_x_datetime(date_minor_breaks = "1 hour", date_breaks = "1 hour", , date_labels = "%H") + theme(axis.text.x = element_text(angle=30, hjust =1)))
}


# Version3
robot <- c()
dir <- list.files(path = paste("//150.150.247.138/d/ISA/2.Agent/HIMM/logs/output/MXMM-04EHIM006/20171103", sep=""), full.names = TRUE, recursive = TRUE)
for(i in 1:length(dir)) {
  temp <- read.table(dir[i], sep = ",", header= TRUE)
  robot <- rbind(robot, temp)  
}
robot$Time <- strptime(substr(robot$Time, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
temp <- robot[which(robot$Variable == "HIM_Actual plast time injection unit 1"),]
ggplot(temp, aes(Time, Value, color = Name)) + geom_line() + ggtitle(variable[j]) + scale_x_datetime(date_minor_breaks = "1 hour", date_breaks = "1 hour", , date_labels = "%H") + theme(axis.text.x = element_text(angle=30, hjust =1))


Injection_plot(13) ####13 for the plast time(past)
Injection_plot(9) ####HIM_Last cycle time


# Version4
READ_EIMM <- function(date) {
  # date: eight digit ex) 20171103
  robot <- c()
  #//150.150.247.138/d/ISA/2.Agent/EIMM/logs/output/
  path <- list.dirs(path = "D://logs", full.names = TRUE, recursive = FALSE)
  dir <- list.files(path = path, full.names = TRUE, recursive = TRUE)
  for(i in 1:length(dir)) {
    temp <- read.table(dir[i], sep = ",", header= TRUE)
    robot <- rbind(robot, temp)  
  }
  robot$Time <- strptime(substr(robot$Time, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
  
  # name <- paste(unique(robot$Name))
  # variable <- paste(unique(robot$Variable))
  # n <- length(unique(robot$Name))
  #temp <- robot[which(robot$Variable == variable[j]),]
  #print(ggplot(temp, aes(Time, Value, color = Name)) + geom_line() + ggtitle(variable[j]) + scale_x_datetime(date_minor_breaks = "1 hour", date_breaks = "1 hour", , date_labels = "%H") + theme(axis.text.x = element_text(angle=30, hjust =1)))
  read_Injectiondata <- robot
}

READ_HIMM <- function(date) {
  # date: eight digit ex) 20171103
  robot <- c()
  num <- c("", "1", "2", "3")
  path <- list.dirs(path = paste("//150.150.247.138/d/ISA/2.Agent/HIMM",num ,"/logs/output/", sep=""), full.names = TRUE, recursive = FALSE)
  dir <- list.files(path = paste(path, "/", date, sep=""), full.names = TRUE, recursive = TRUE)
  for(i in 1:length(dir)) {
    temp <- read.table(dir[i], sep = ",", header= TRUE)
    robot <- rbind(robot, temp)  
  }
  robot$Time <- strptime(substr(robot$Time, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
  
  # name <- paste(unique(robot$Name))
  # variable <- paste(unique(robot$Variable))
  # n <- length(unique(robot$Name))
  #temp <- robot[which(robot$Variable == variable[j]),]
  #print(ggplot(temp, aes(Time, Value, color = Name)) + geom_line() + ggtitle(variable[j]) + scale_x_datetime(date_minor_breaks = "1 hour", date_breaks = "1 hour", , date_labels = "%H") + theme(axis.text.x = element_text(angle=30, hjust =1)))
  read_Injectiondata <- robot
}

HIMM_171113 <- READ_HIMM("20171113")
HIMM_171114 <- READ_HIMM("20171114")
max(HIMM_171110$Value[])
head(HIMM_171110)
data <- HIMM_171113
data$Time <- as.POSIXct(data$Time)
levels(data$Name) <- EIMM_list[match(levels(data$Name), EIMM_list[,1]), 2]
require(plotly)
temp <- data[which(data$Variable == "HIM_Actual plast time injection unit 1"),]
temp <- temp[temp$Time > "2017-11-13 00:00:00 GMT",]

head(temp$Time)
p <- plot_ly(x =  as.POSIXct(temp$Time), y = temp$Value, mode = 'lines', split = temp$Name)


subdata <- filter(data, Value < 3000 & Variable == "HIM_Shot counter")  %>% 
  group_by(Name) %>% 
  summarise(Value = max(Value))




EIMM_171102 <- READ_EIMM("20171102")
head(HIMM_171109)
temp1 <- HIMM_171109[which(HIMM_171109$Variable == "HIM_Actual plast time injection unit 1"),]
ggplot(temp1, aes(Time, Value, color = Name)) + geom_line() + ggtitle("유압식 사출기 계량시간") + scale_x_datetime(date_minor_breaks = "1 hour", date_breaks = "1 hour", , date_labels = "%H") + theme(axis.text.x = element_text(angle=30, hjust =1))



temp2 <- HIMM_171110[which(HIMM_171110$Variable == "HIM_Actual plast time injection unit 1"),]
levels(temp2$Name) <- EIMM_list[match(levels(temp2$Name), EIMM_list[,1]), 2]
injectionName <- unique(temp2$Name)
temp2$Name == injectionName[i]
p <- plot_ly(x =  as.POSIXct(temp2$Time), y = temp2$Value, mode = 'lines', split = temp2$Name)
library(plotly)




temp2 <- EIMM_171102[which(EIMM_171102$Variable == "Plasticize Time"),]
ggplot(temp2, aes(Time, Value/1000000, color = Name)) + geom_line() + ggtitle("전동식 사출기 계량시간") + scale_x_datetime(date_minor_breaks = "1 hour", date_breaks = "1 hour", , date_labels = "%H") + theme(axis.text.x = element_text(angle=30, hjust =1))

unique(EIMM_171102$Variable)
head(EIMM_171102[which(EIMM_171102$Variable == "Actual"),])
levels(temp1$Name)
EIMM_list <- data.frame(EIMM_list)
temp1$Name <- EIMM_list[i,2]


EIMM_list <- data.frame(EIMM_list) <- cbind(c('MXMM-04EHIM005',
               'MXMM-04EHIM011',
               'MXMM-04EHIM002',
               'MXMM-04EHIM001',
               'MXMM-04EHIM006',
               'MXMM-04EHIM007',
               'MXMM-04EHIM008',
               'MXMM-04EHIM004',
               'MXMM-04EHIM003',
               'MXMM-04EHIM009',
               'MXMM-04EHIM010',
               'MXMM-04EHIM012',
               'MXMM-04EHIM013',
               'MXMM-04EHIM014',
               'MXMM-04EHIM015',
               'MXMM-04EHIM016'), c('유압식 사출기 13-1',
                                    '유압식 사출기 13-2',
                                    '유압식 사출기 6-1',
                                    '유압식 사출기 6-2',
                                    '유압식 사출기 6-3',
                                    '유압식 사출기 6-4',
                                    '유압식 사출기 6-5',
                                    '유압식 사출기 8-1',
                                    '유압식 사출기 8-2',
                                    '유압식 사출기 8-3',
                                    '유압식 사출기 8-4',
                                    '유압식 사출기 6-6',
                                    '유압식 사출기 6-7',
                                    '유압식 사출기 6-8',
                                    '유압식 사출기 6-9',
                                    '유압식 사출기 8-5'))


HIMM_list <- data.frame(HIMM_list) <- cbind(c('MXMM-04EHIM005',
                                              'MXMM-04EHIM011',
                                              'MXMM-04EHIM002',
                                              'MXMM-04EHIM001',
                                              'MXMM-04EHIM006',
                                              'MXMM-04EHIM007',
                                              'MXMM-04EHIM008',
                                              'MXMM-04EHIM004',
                                              'MXMM-04EHIM003',
                                              'MXMM-04EHIM009',
                                              'MXMM-04EHIM010',
                                              'MXMM-04EHIM012',
                                              'MXMM-04EHIM013',
                                              'MXMM-04EHIM014',
                                              'MXMM-04EHIM015',
                                              'MXMM-04EHIM016'), c('유압식 사출기 13-1',
                                                                   '유압식 사출기 13-2',
                                                                   '유압식 사출기 6-1',
                                                                   '유압식 사출기 6-2',
                                                                   '유압식 사출기 6-3',
                                                                   '유압식 사출기 6-4',
                                                                   '유압식 사출기 6-5',
                                                                   '유압식 사출기 8-1',
                                                                   '유압식 사출기 8-2',
                                                                   '유압식 사출기 8-3',
                                                                   '유압식 사출기 8-4',
                                                                   '유압식 사출기 6-6',
                                                                   '유압식 사출기 6-7',
                                                                   '유압식 사출기 6-8',
                                                                   '유압식 사출기 6-9',
                                                                   '유압식 사출기 8-5'))

#####--------------------------------------------

install.packages("xlsx")
 require(xlsx)

mydata <- xlsxToR("D:/업무자료/35. MM법인사출성형기/1.MM 정보화/99. 문서/9. OOE실적/OEE_1031.xlsx")
head(mydata$`650-9`)
IMM_Rate <- function(x) {
  temp <- mydata$`650-9`[-1]
  IMM850t_3rd <- t(temp[-1])
  IMM850t_3rd <- as.data.frame(IMM850t_3rd)
  colnames(IMM850t_3rd) <- IMM_NAME
  row.names(IMM850t_3rd) <- c()
  indx <- sapply(IMM850t_3rd, is.factor)
  IMM850t_3rd[indx] <- lapply(IMM850t_3rd[indx], function(x) as.numeric(as.character(x)))
  is.na(IMM850t_3rd)
  p <- plot_ly(x =  as.numeric.factor(IMM850t_3rd$`Fecha  날짜`), y = as.numeric.factor(IMM850t_3rd$`양품율 EFICIENCIA PIEZA BUENO`), type = "bar")
  print(p)
}


as.numeric.factor(IMM850t_3rd$`Fecha  날짜`)
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}

apply(IMM850t_3rd,2, function(x) {as.numeric(levels(x))[x]})

pattern <- "\n"

result <- c()
length(FL)
FL[1]
result <- regexpr(pattern, IMM_NAME)
finalXML <- regmatches(IMM_NAME, result, invert = TRUE)
IMM_NAME <- as.character(lapply(finalXML, function(x) { x[1]}))

IMM850t_3rd <- IMM850t_3rd[1:18,]


######---------------------------------------------------------------------
#machineCode <- c("6-3", "6-4", "6-8", "6-9", "8-4")
data <- c()
MachineName <- substr(path, 9, 15)
path <- list.dirs(path = paste("D:/logs", sep = ''), full.names = TRUE, recursive = FALSE)
#for(j in 1:length(machineCode)) {
for(i in 1:length(path)) {
  cat(rep(" ", 50), "\r", sep = '')
  #dir <- list.files(path = paste("D:/logs/HIMM", machineCode[j], "/", sep = ''), full.names = TRUE, recursive = TRUE)
  dir <- list.files(path = path[i], full.names = TRUE, recursive = TRUE)
  robot <- c()
  size <- length(dir)
  for(j in 1:size) {
    cat(path[i], " is ", ceiling(j/(size+1)*100), "% complete.\r", sep = '')
    temp <- read.table(dir[j], sep = ",", header= TRUE)
    robot <- rbind(robot, temp)  
  }
  
  robot$Time <- strptime(substr(robot$Time, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
  cat(MachineName[i], " is 100% complete.\r", sep = '')
  assign(paste0(MachineName[i]), robot)
  #write.csv(robot, file = paste(path[i], ".csv", sep = ""))
}
#string 찾기
matchedLetters <- gregexpr("/", path)
stringi::stri_length(path)
unique(`HIMM6-3`$Variable)
substr(path, 9, 15)
library(plotly)
`HIMM6-3`$Time <- as.POSIXct(`HIMM6-3`$Time)
`HIMM6-4`$Time <- as.POSIXct(`HIMM6-4`$Time)
`HIMM6-8`$Time <- as.POSIXct(`HIMM6-8`$Time)
`HIMM6-9`$Time <- as.POSIXct(`HIMM6-9`$Time)
`HIMM8-4`$Time <- as.POSIXct(`HIMM8-4`$Time)
#
MMPlot <- function (datanm) {
  plot_ly(data = datanm[datanm$Variable == "HIM_Actual plast time injection unit 1",], x = ~Time, y = ~Value)
}
MMPlot(`HIMM6-3`)
MMPlot(`HIMM6-4`)
MMPlot(`HIMM6-8`)
MMPlot(`HIMM6-9`)
MMPlot(`HIMM8-4`)
plot_ly(data = `HIMM6-4`[`HIMM6-4`$Variable == "HIM_Actual plast time injection unit 1",], x = ~Time, y = ~Value, mode = 'lines')
plot_ly(data = `HIMM6-8`[`HIMM6-8`$Variable == "HIM_Actual plast time injection unit 1",], x = ~Time, y = ~Value)
plot_ly(data = `HIMM6-9`[`HIMM6-9`$Variable == "HIM_Actual plast time injection unit 1",], x = ~Time, y = ~Value)
#plot_ly(data = `HIMM6-3`, x = ~Time, y = ~Value, mode = 'lines', split = ~Variable)
head(`HIMM6-3`)
plotly()


