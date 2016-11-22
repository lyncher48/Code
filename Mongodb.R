#라이브러리 설치
list.of.packages <- c("rmongodb", "ff", "reshape", "bcp") #라이브러리 명칭 공유
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#라이브러리 로드
library(rmongodb)
library(ff)
library(reshape)

#몽고DB접속
mongo <- mongo.create(host = "165.244.244.53:10010", username = "emulususer", password = "!lge321", db = "emulus")

#접속여부 확인
mongo.is.connected(mongo)
#if (mongo.is.connected(mongo))
#mongo.add.user(mongo, "mooyeob", "12345lge", db = "phmv2")
#mongo.authenticate(mongo, username = "phmuser", password = "1234lge", db = "phmv2")
  
#????DB Table ��ȸ
mongo.get.database.collections(mongo, db = "emulus")

#201510080906440393 = 2015/10/08 09:06:44.0393
#Table ��ȸ ��?? ??��

mongo.disconnect(mongo) #몽고DB 커넥션 종료

readmongo <- function(collectionnm) {
  buf <- mongo.bson.buffer.create()
  mongo.bson.buffer.start.object(buf, 'this_month')
  mongo.bson.buffer.append(buf, '$regex', '20160902.*')
  mongo.bson.buffer.finish.object(buf)
  query <- mongo.bson.from.buffer(buf)
  cursor <- mongo.find.all(mongo, collectionnm, query, sort = mongo.bson.empty(),
                           fields = mongo.bson.empty(), limit = 5000L)
  DATA <- matrix(unlist(cursor),byrow=TRUE,ncol=length(cursor[[1]]))
  colnames(DATA) <- names(cursor[[1]])
  DATA  <- as.data.frame(DATA)
  DATA$data_value <- as.numeric(format(DATA$data_value, trim = TRUE))
  DATA$time_value <- strptime(substr(DATA$time_value, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
  Result <- cast(DATA, formula = time_value ~ variablenm, fun.aggregate = mean,value = "data_value")
  write.csv(Result, file = paste("D://R_study/", collectionnm, ".csv", sep=""))
}

max(DATA$data_value) - min(DATA$data_value)
readmongo <- function(collectionnm, date) {
  buf <- mongo.bson.buffer.create()
  mongo.bson.buffer.start.object(buf, 'time_value')
  mongo.bson.buffer.append(buf, '$regex', paste(date, ".*", sep=""))
  mongo.bson.buffer.finish.object(buf)
  query <- mongo.bson.from.buffer(buf)
  cursor <- mongo.find.all(mongo, collectionnm, query, sort = mongo.bson.empty(),
                           fields = mongo.bson.empty(), limit = -1L)
  DATA <- matrix(unlist(cursor),byrow=TRUE,ncol=length(cursor[[1]]))
  colnames(DATA) <- names(cursor[[1]])
  DATA  <- as.data.frame(DATA)
  DATA$data_value <- as.numeric(format(DATA$data_value, trim = TRUE))
  DATA$time_value <- strptime(substr(DATA$time_value, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
  Result <- cast(DATA, formula = time_value ~ variablenm, fun.aggregate = mean,value = "data_value")
  write.csv(Result, file = paste("D://R_study/", collectionnm, ".csv", sep=""))
}

readmongo("emulus.EGB0046", "20160817") #main

#Control Oxide 1
readmongo("emulus.EGB_201") #main
readmongo("emulus.EGB0001") #tube1
readmongo("emulus.EGB0002") #tube2
readmongo("emulus.EGB0003") #tube3
readmongo("emulus.EGB0004") #tube4
readmongo("emulus.EGB0005") #tube5
readmongo("emulus.EGB0006") #tube6

#Control Oxide 2
readmongo("emulus.EGB_202") #main
readmongo("emulus.EGB0007") #tube1
readmongo("emulus.EGB0008") #tube2
readmongo("emulus.EGB0009") #tube3
readmongo("emulus.EGB00010") #tube4
readmongo("emulus.EGB00011") #tube5
readmongo("emulus.EGB00012") #tube6

#Control Oxide 2
readmongo("emulus.EGB_202") #main
readmongo("emulus.EGB0007") #tube1
readmongo("emulus.EGB0008") #tube2
readmongo("emulus.EGB0009") #tube3
readmongo("emulus.EGB00010") #tube4
readmongo("emulus.EGB00011") #tube5
readmongo("emulus.EGB00012") #tube6

CT_list <- c("EGB_201", "EGB0001", "EGB0002", "EGB0003","EGB0004", "EGB0005", "EGB0006", "EGB_202", "EGB0007",
             "EGB0008", "EGB0009", "EGB0010", "EGB0011", "EGB0012", "EGB_203", "EGB0013", "EGB0014", "EGB0015", "EGB0016", "EGB0017", "EGB0018", "EGB_204", "EGB0019", "EGB0020", "EGB0021", "EGB0022", "EGB0023", "EGB0024", "EGB_301", "EGB0025", "EGB0026", "EGB0027", "EGB0028", "EGB0029", "EGB0030",
             "EGB_302", "EGB0031", "EGB0032", "EGB0033", "EGB0034", "EGB0035", "EGB0036", "EGB0037", "EGB0038", "EGB0039", "EGB0040", "EGB0041", "EGB0042", "EGB0043", "EGB0044", "EGB_303", "EGB0045", "EGB0046", "EGB_304", "EGB0047", "EGB0048", "EGB0049", "EGB0050", "EGB0051", "EGB0052", "EGB0053", "EGB0054", "EGB0055",
             "EGB0056", "EGB0057", "EGB0058", "EGB0059", "EGB0060", "EGB_305", "EGB0061", "EGB0062", "EGB0063", "EGB0064", "EGB0065", "EGB0066", "EGB_306", "EGB0067", "EGB0068", "EGB0069", "EGB0070", "EGB0071", "EGB0072", "EGB0073", "EGB0074", "EGB0075", "EGB0076", "EGB0077", "EGB0078", "EGB0079",
             "EGB0080", "EGB_307", "EGB0081", "EGB0082", "EGB_308", "EGB0083", "EGB0084", "EGB_309", "EGB0085", "EGB0086", "EGB_206", "EGB0087", "EGB0088", "EGB0089", "EGB0090", "EGB0091", "EGB_207", "EGB0092", "EGB0093", "EGB0094", "EGB0095", "EGB0096", "EGB_208", "EGB0097", "EGB0098", "EGB0099", "EGB0100", "EGB0101", "EGB_209",
             "EGB0102", "EGB0103", "EGB0104", "EGB0105", "EGB0106")

for(i in CT_list)
{
  readmongo(paste("emulus.", CT_list, sep =  ""))
}


collectionnm = "emulus.EGB0046"
date = "20160817"
  buf <- mongo.bson.buffer.create()
  mongo.bson.buffer.start.object(buf, 'time_value')
  mongo.bson.buffer.append(buf, '$regex', paste(date, ".*", sep=""))
  mongo.bson.buffer.finish.object(buf)
  mongo.bson.buffer.start.object(buf, 'variablenm')
  mongo.bson.buffer.append(buf, 'W_total')
  mongo.bson.buffer.finish.object(buf)
  query <- mongo.bson.from.buffer(buf)
  cursor <- mongo.find.all(mongo, collectionnm, query, sort = mongo.bson.empty(),
                           fields = mongo.bson.empty(), limit = -1L)
  DATA <- matrix(unlist(cursor),byrow=TRUE,ncol=length(cursor[[1]]))
  colnames(DATA) <- names(cursor[[1]])
  DATA  <- as.data.frame(DATA)
  DATA$data_value <- as.numeric(format(DATA$data_value, trim = TRUE))
  DATA$time_value <- strptime(substr(DATA$time_value, 1, 14), "%Y%m%d%H%M%S", tz = "GMT")
  Result <- cast(DATA, formula = time_value ~ variablenm, fun.aggregate = mean,value = "data_value")
  write.csv(Result, file = paste("D://R_study/", collectionnm, ".csv", sep=""))


  
  readmongo
  variablenm <- c("gap_latch_top", "gap_latch_top","gap_latch_top","gap_latch_top", "gap_latch_top", "gap_latch_mid", "gap_latch_mid", "gap_latch_mid", "gap_latch_mid")
  variable_data_float <- c(5, 6, 7, 8, 9, 6, 7, 8, 9)
    data<- data.frame(variablenm, variable_data_float)
  
which(c(1,1,1) == 1)
length(unique(c(1,1,2)))
newdata <- list()
for(i in (1:length(unique(data$variablenm)))) {
    newdata[length(newdata) + 1] <- list(data$variable_data_float[which(data$variablenm == unique(data$variablenm)[i])])
}
data.frame(newdata)
  

newdata <- c()
for(i in (1:length(unique(data$variablenm)))) {
  newdata <- cbind(newdata, data$variable_data_float[which(data$variablenm == unique(data$variablenm)[i])])
}
newdata <- data.frame(newdata)
colnames(newdata) <- unique(data$variablenm)

dwt
library(rJava)
jinit(parameters=c("-Dfile.encoding=UTF-8"))
