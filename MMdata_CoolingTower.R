library(reshape)
library(scales)
library(plotly)
######---------------------------------------------------------------------
#machineCode <- c("6-3", "6-4", "6-8", "6-9", "8-4")
data <- c()
MachineName <- substr(path, 9, 15)
path <- list.dirs(path = paste("D:/logs/CTOWER3", sep = ''), full.names = TRUE, recursive = FALSE)
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
  assign("CTower", robot)
  #write.csv(robot, file = paste(path[i], ".csv", sep = ""))
}


CTower[gerp]

grepl("ne", CTower$Variable)

head(CTower)
subdata <- CTower %>% 
  summarise(통화건수 = sum(통화건수))


head(MESA_ICP_1)
