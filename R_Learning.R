#install.packages("SOAR")
#install.packages("data.table")
#install.packages("KoNLP")

# library(SOAR) 캐시로 데이터를 보냄.(메모리 사용량 효율화)
# library(data.table) 읽고, 쓰고 검색하는데 속도 단축함.
# library(KoNLP)
# -------------------------------- 책 소개 ---------------------------------------
# An Introduction to Statistical Learning; The Elements of Statistical Learning
# Advanced R - http://adv-r.had.co.nz/Introduction.html
# Beyesian data analysis; Doing Bayesian Data Analysis
# Use R!, Springer - http://rd.springer.com/bookseries/6991
# --------------------------------------------------------------------------------
# ●simplifying Vs. preserving
#   vector x[[1]]  -  x[1]
#   list x[[1]]  -  x[1]
#   factor x[1:2, drop=T]  -  x[1:2]
#   array x[1, ]  -  x[1,,drop=F]
#   data frame x[,1] or x[[1]]  -  x[,1,drop=F] or x[1]
#
#
# Store() - 메모리에 올라온 데이터 내려줌.?
# str(), attributes() 데이터 살펴봄. table - frequency 보여
# 텍스트 객체 함수 - sub(찾을문자, 바꿀문자, 대상데이터) 첫번째 문자를 변경, gsub() 모든 문자 변경
# Ctrl + L : 콘솔창 지우기
# Use R! Series - Springer
# 

compelete.cases

install.packages("e1071")
library(e1071)
install.packages("caret")
library(caret)
??confusionMatrix
ls()
Ls()
x
Store(x)
x[[1]]
x[1]
x <- c(1, 2, 3)
y <- c(2, 3, 4)
z <- c("만두", "고시우기", NA)
data <- data.frame(x, y, z)

library(stats)
is.na
complete.cases(data)
ix <- data$x
View(ix)
x.simplifying <- x[[1]]
x.simplifying <- x[1]
grep("기$|^만", z)
grep("^고.*기$", z)
which(z %in% c("만", "고"))
attributes(cbind(x, y, z))
str(data)
