PlcLogger <- function(csv, writefile) {
  data <- read.csv(csv, header = T, sep = ",")
  data <- as.data.frame(data)
  functionCode <- c("Coils (bool)","Discrete Inuts (bool)","Holding Registers (word)","Input Registers (word)")
  write("", file = writefile, append = FALSE)
  for(i in 1:length(data$address)){
    write(paste("  <readOrders>", sep = ""), file = writefile, append = TRUE)
    write(paste("    <functionCode>",data$functionCode[i],"</functionCode>",sep = ""), file = writefile, append = TRUE)
    write(paste("    <adress>",data$address[i], "</adress>", sep = ""), file = writefile, append = TRUE)
    if(substr(as.character(data$datatype[i]), nchar(as.character(data$datatype[i])) - 1, nchar(as.character(data$datatype[i]))) == "32") 
    {
      write(paste("    <symbolName>", functionCode[data$functionCode[i]]," - ", data$address[i]," - ", as.character(data$datatype[i])," - ", "LSW | MSW", "</symbolName>", sep = ""), file = writefile, append = TRUE)
      write(paste("    <dataType WordOrder=\"LSW_MSW\">", as.character(data$datatype[i]), "</dataType>", sep=""), file = writefile, append = TRUE)
    }
    else {
      write(paste("    <symbolName>", functionCode[data$functionCode[i]]," - ", data$address[i]," - ", as.character(data$datatype[i]), "</symbolName>", sep = ""), file = writefile, append = TRUE)
      write(paste("    <dataType>", as.character(data$datatype[i]), "</dataType>", sep=""), file = writefile, append = TRUE)
    } 
    write(paste("  </readOrders>", sep="")  , file = writefile, append = TRUE)
  }
}

##PlcLogger(소스파일경로, 아웃풋파일경로)
PlcLogger("C://datalist.csv", "C://datalist.txt")
