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

for(i in 1:length(dir)) {
  #hampel(Laser[,2], 5, t0 = 3)
  Data <- OverlapSplit(MESA_ICP_1[1:30,], size=6, overlap=1, TRUE)
}

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
