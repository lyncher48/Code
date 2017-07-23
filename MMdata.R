
robot <- c()

dir <- list.files(path = "D:/업무자료/35. MM법인사출성형기/1.MM 정보화/사출기 인터페이스/데이터/message/", full.names = TRUE, recursive = TRUE)

for(i in c(1:length(dir))) {
  temp <- read.table(dir[i], sep = ",", header= TRUE)
  robot <- rbind(robot, temp)  
}
robot$Time <- strptime(substr(robot$Time, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
temp$Time
name <- paste(unique(robot$Name))
variable <- paste(unique(robot$Variable))
n <- length(unique(robot$Name))
robot <- robot[which(robot$Variable == variable[1]),]

for(i in c(1:n)) {
  temp <- robot[which(robot$Name == name[i]),]
  summary(temp)
  
  plot(temp$Time, temp$Value, type="p", xlab = "Time", ylab = "Weight(g)", sub =unique(robot$Variable)[i])  
}
    
    


