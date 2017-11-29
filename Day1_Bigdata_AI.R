list.of.packages <- c("networkD3", "ggmap", "rmarkdown",
                      "knitr", "jsonlite", "base64enc",
                      "rprojroot") #라이브러리 명칭 공유
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

install.packages("rmarkdown")
install.packages("knitr", repos = getOption("repos"), dependencies = TRUE)
library(rmarkdown)
library(networkD3)

MyLinks <- read.csv()
MyNodes <- read.csv()

data(MisLinks)
data(MisNodes)

forceNetwork(Links = MisLinks, Nodes=MisNodes,
             Source = "source", Target = "target",
             Value = "value", NodeID = "name",
             Group = "group", opacity = 0.8)

install.packages("ggmap")
library(ggmap)
qmap('Seoul')

install.packages("reshape2")
library(reshape2)
x <- paste("X_", seq(1, 10, by=1), sep = "")

# 35부터 10단위 구간으로 Binning한 데이터 셋을 만든다 
x <- c(11, 12, 13, 16, 17, 19, 33, 32)
cut(x, breaks = 10 + 5 * (0:7))

dfr <- data.frame(
  V1 = c(0.1, 0.2, 0.3),
  V2 = c(0.2, 0.3, 0.2),
  V3 = c(0.3, 0.6, 0.5),
  V4 = c(0.5, 0.1, 0.7),
  row.names = LETTERS[1:3]
)


mdfr <- melt(iris, id.vars = "Species")

acast(mdfr, value ~ variable + Species)

spread()
names(iris)
write.csv()
install.packages("ggplot2")
library(ggplot2)
data(iris)
value <- colnames(iris)
value
install.packages("Rcpp", dependencies = TRUE)
library(Rcpp)
remove.packages("reshape2")
remove.packages("Rcpp")
install.packages("tidyr")
library(tidyr)
df <- gather(iris, variable, value, -Species)

ggplot(mdfr, aes(Species, value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity")


