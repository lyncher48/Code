######---------------------------------------------------------------------
#machineCode <- c("6-3", "6-4", "6-8", "6-9", "8-4")
data <- c()
MachineName <- substr(path, 15, 24)
path <- list.dirs(path = paste("D:/logs/LGIT/", sep = ''), full.names = TRUE, recursive = FALSE)
#for(j in 1:length(machineCode)) {
for(i in 1:length(path)) {
  cat(rep(" ", 50), "\r\n", sep = '')
  #dir <- list.files(path = paste("D:/logs/HIMM", machineCode[j], "/", sep = ''), full.names = TRUE, recursive = TRUE)
  dir <- list.files(path = path[i], full.names = TRUE, recursive = TRUE)
  robot <- c()
  size <- length(dir)
  for(j in 1:size) {
    cat(path[i], " is ", ceiling(j/(size+1)*100), "% complete.\r", sep = '')
    temp <- read.csv(dir[j], skip=5, header = TRUE)
    robot <- rbind(robot, temp)  
  }
  
  #robot$Time <- strptime(substr(robot$Time, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
  cat(MachineName[i], " is 100% complete.\r", sep = '')
  assign(paste0(MachineName[i]), robot)
  #write.csv(robot, file = paste(path[i], ".csv", sep = ""))
}
head(MESA_ICP_1)
head(MESA_ICP_2)
head(MESA_ICP_4)





