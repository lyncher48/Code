install.packages("XML")
library("XML")
library("methods")
library(reshape)

READ_XML <- function(date) {
  # date: eight digit ex) 20171103
  robot <- c()
  path <- list.dirs(path = "//150.150.247.138/d/ISA/2.Agent/DOSING/archives/FL/", full.names = TRUE, recursive = FALSE)
  dir <- list.files(path = paste(path, "/", date, sep=""), full.names = TRUE, recursive = TRUE)
  for(i in 1:length(dir)) {
    temp <- read.table(dir[i], sep = ",", header= TRUE)
    robot <- rbind(robot, temp[2])  
  }
  robot$Time <- strptime(substr(robot$Time, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
  
  # name <- paste(unique(robot$Name))
  # variable <- paste(unique(robot$Variable))
  # n <- length(unique(robot$Name))
  #temp <- robot[which(robot$Variable == variable[j]),]
  #print(ggplot(temp, aes(Time, Value, color = Name)) + geom_line() + ggtitle(variable[j]) + scale_x_datetime(date_minor_breaks = "1 hour", date_breaks = "1 hour", , date_labels = "%H") + theme(axis.text.x = element_text(angle=30, hjust =1)))
  read_Injectiondata <- robot
}

dir <- list.files(path = "//150.150.247.138/d/ISA/2.Agent/DOSING/archives/FL/20171107", full.names = TRUE, recursive = TRUE)
dir
FL <- c()
for(i in 1:length(dir)) {
  temp <- read.csv(dir[i], sep = ",", header= FALSE)
  FL <- rbind(FL, as.character(temp[,2]))
  cat(i, "\n")
}
warnings()
pattern <- "<.*>$"

result <- c()
length(FL)
FL[1]
result <- regexpr("<.*>$", FL)
finalXML <- regmatches(FL, result)
cat(finalXML[1])
write.table(finalXML, file ="D:/data/Share/xmlcode.xml", sep="", row.names = FALSE, col.names = FALSE, quote=FALSE)  

head(temp)
for(i in 1:length(name)) {
  fname = paste("D:/data/Share/", name[i], ".xml", sep="")
  write.csv(sensors[which(sensors$Name == name[i]),], file = fname)
}


xmlToDataFrame(temp[2,2])
temp[2,2]
xmldataframe <- xmlToDataFrame(xml(finalXML[2]))
xmldataframe[,1] <- xmldataframe[1,1]
xmldataframe$Value <- as.numeric(xmldataframe$Value)
testxmldata <- cast(xmldataframe[-1,], formula = ID ~ Parameter, fun.aggregate = mean, value = "Value")

xmllist$Group$Parameter
xml(finalXML[2])
# Convert the input xml file to a data frame.
xmldataframe <- xmlToDataFrame(xml(finalXML[2]))
xmldataframe <- xmlToDataFrame("D:/data/Share/xmlcode.xml")
print(xmldataframe)
