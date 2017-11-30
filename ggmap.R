list.of.packages <- c("networkD3", "ggmap", "tidyr", "dplyr") #라이브러리 명칭 공유
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(ggmap)
qmap('Seoul')
