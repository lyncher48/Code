# 참고 서적
# ISLR: http://www-bcf.usc.edu/~gareth/ISL/
# ESL: http://statweb.stanford.edu/~tibs/ElemStatLearn/
# 강아지책(Doing Bayesian Data Analysis): http://www.indiana.edu/~kruschke/DoingBayesianDataAnalysis/
# Gelman(Bayesian Data Analysis): http://www.stat.columbia.edu/~gelman/book/

# 추가 패키지
# SOAR: https://cran.r-project.org/web/packages/SOAR/vignettes/SOAR.pdf


# 4개 줄 건너뛰고 데이터 불러오기
initiative.1 <- read.csv("~/data/initiatives/20161006-initiatives.csv", header = T, stringsAsFactors = F, skip = 4)

# 데이터 눈으로 탐색해보기
View(initiative.1)

# 예외값 제거
idx <- which(initiative.1$공동발의자 == "정부" | initiative.1$공동발의자 == "기타" | initiative.1$공동발의자 == "" | initiative.1$공동발의자 == "의장" | 
               initiative.1$공동발의자 == "위원장")

initiative.2 <- initiative.1[-idx, ]

# 불러온 데이터에서 공동발의자 텍스트 분할
list.split.joint.init.2 <- strsplit(initiative.2$공동발의자, " ", fixed = TRUE)

# bipartite matrix 생성
vec.split.joint.init.2 <- unlist(list.split.joint.init.2)
name.unique <- unique(vec.split.joint.init.2)
bi.mat <- matrix(0, nrow = 566, ncol = length(name.unique))
colnames(bi.mat) <- name.unique

for (i in 1:length(list.split.joint.init.2)) {
  for (j in 1:length(name.unique)) {
    if (colnames(bi.mat)[j] %in% list.split.joint.init.2[[i]]) {
      bi.mat[i, j] <- 1  
    }
  }
}

n.row <- nrow(bi.mat)
n.col <- ncol(bi.mat)
B <- rbind(cbind(matrix(0, n.col, n.col), t(bi.mat)), cbind(bi.mat, matrix(0, n.row, n.row)))

# network analysis

library(sna)

R.degree <- degree(B, cmode = "indegree")[1:n.col]
R.closeness.1 <- closeness(B)[1:n.col]
R.closeness.2 <- closeness(B, cmode = "suminvundir")[1:n.col]
R.betweenness <- betweenness(B)[1:n.col]

round.R.closeness.1 <- round(R.closeness.1, 2)
round.R.closeness.2 <- round(R.closeness.2, 2)
round.R.betweenness <- round(R.betweenness, 0)

C.degree <- degree(B, cmode = "indegree")[(n.col + 1):(n.col + n.row)]
C.closeness.1 <- closeness(B)[(n.col + 1):(n.col + n.row)]
C.closeness.2 <- closeness(B, cmode = "suminvundir")[(n.col + 1):(n.col + n.row)]
C.betweenness <- betweenness(B)[(n.col + 1):(n.col + n.row)]

round.C.closeness.1 <- round(C.closeness.1, 2)
round.C.closeness.2 <- round(C.closeness.2, 2)
round.C.betweenness <- round(C.betweenness, 0)

vertex.col.1 <- c(rep("red", n.col), rep("blue", n.row))
vertex.cex.1 <- c(rep(1, n.col), rep(2, n.row))

gplot(B, mode = "kamadakawai", displaylabels = F, boxed.labels = F,
      vertex.col = vertex.col.1, vertex.cex = vertex.cex.1,
      label.col = vertex.col.1, label.cex = 1.2, usearrows = F)

library(rgl)

gplot3d(B, vertex.col = "red", vertex.alpha = 0.5, edge.col = "grey", edge.lwd = 0.2)

# save.image("results/init.RData")

