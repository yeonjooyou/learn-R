# tm 패키지와 유사도 분석 실습
library(tm)
library(proxy)
d1 <- c("사과 포도 망고") # 듀크
d2 <- c("포도 자몽 자두") # 둘리
d3 <- c("복숭아 사과 포도") # 또치
d4 <- c("오렌지 바나나 복숭아") # 도우너
d5 <- c("포도 바나나 망고") # 길동
d6 <- c("포도 귤 오렌지") # 희동
dd <- c(d1, d2, d3, d4, d5, d6)

cps <- VCorpus(VectorSource(dd))
dtm <- DocumentTermMatrix(cps,control=list(wordLengths = c(1, Inf)))
#inspect(dtm)
m <- as.matrix(dtm)
com <- m %*% t(m)
com

# (1) 좋아하는 과일이 가장 유사한 친구들을 찾아본다.
dist(com, method = "cosine") # (0~1사이의 값 중) 값이 작을수록 유사도가 높다
min(dist(com, method = "cosine")) #  0.1097362
# d1과 d3 / d1과 d5


# (2) 학생들에게 가장 많이 선택된 과일을 찾아본다.
# (3) 학생들에게 가장 적게 선택된 과일을 찾아본다.
tdm <- TermDocumentMatrix(cps, control=list(wordLengths = c(1, Inf)))
#inspect(tdm)
(m2 <- as.matrix(tdm))
(v2 <- sort(rowSums(m2), decreasing=T))
# (2) 포도
# (3) 귤 자두 자몽




# CASE 1
library(tm)
library(proxy)
듀크 <-c("사과 포도 망고")
둘리 <- c("포도 자몽 자두")
또치 <- c("복숭아 사과 포도")
도우너 <- c("오렌지 바나나 복숭아")
길동 <- c("포도 바나나 망고")
희동 <- c("포도 귤 오렌지") 
data <- NULL
data <- c(듀크, 둘리, 또치, 도우너, 길동, 희동)
cps <- VCorpus(VectorSource(data))
dtm <- DocumentTermMatrix(cps, control=list(wordLengths = c(1, Inf)))
#inspect(dtm)
m <- as.matrix(dtm)
com <- m %*% t(m)
com

# 1번 문제
dist(com, method = "cosine")
min(dist(com, method = "cosine")) # 0.1097362
## => 1번과 3번이 가장 유사함
## => 1번과 5번이 가장 유사함

# 2,3번 문제
(v <- sort(colSums(m), decreasing=T))  
## 포도가 가장 많이 선택된 과일
## 귤,자두,자몽이 가장 적게 선택된 과일


# CASE 2

library(tm)
library(proxy)

fruits <- NULL
듀크 <- c("사과 포도 망고")
둘리 <- c("포도 자몽 자두")
또치 <- c("복숭아 사과 포도")
도우너 <- c("오렌지 바나나 복숭아")
길동 <- c("포도 바나나 망고")
희동 <- c("포도 귤 오렌지")
fruits <- c(듀크, 둘리, 또치, 도우너, 길동, 희동)

cps <- VCorpus(VectorSource(fruits))
dtm <- DocumentTermMatrix(cps, control=list(wordLengths = c(1, Inf)))
m <- as.matrix(dtm)


# (1) 좋아하는 과일이 가장 유사한 친구들을 찾아본다.
com <- m %*% t(m)
dist(com, method = "cosine")
# 듀크와 또치, 듀크와 길동이 동등하게 유사하다.



# (2) 학생들에게 가장 많이 선택된 과일을 찾아본다.
sort(colSums(m), decreasing=T)
# 포도가 5회로 가장 많이 선택되었다.


# (3) 학생들에게 가장 적게 선택된 과일을 찾아본다.
sort(colSums(m))
# 귤, 자두, 자몽이 각각 1회로 가장 적게 선택되었다.

# CASE 3
fruit <- NULL

듀크 <- c('사과 포도 망고')
둘리 <- c('포도 자몽 자두')
또치 <- c('복숭아 사과 포도')
도우너 <- c('오렌지 바나나 복숭아')
길동 <- c('포도 바나나 망고')
희동 <- c('포도 귤 오렌지')
fruit <- c(듀크, 둘리, 또치, 도우너, 길동, 희동)

cps <- VCorpus(VectorSource(fruit))
dtm <- DocumentTermMatrix(cps,
                          control=list(wordLengths = c(1, Inf)))

m <- as.matrix(dtm)
m
com <- m %*% t(m)
com

dist(com, method = 'cosine')
colSums(m)
#좋아하는 과일이 가장 유사한 친구 : 듀크랑 또치, 듀크랑 길동
#가장 많이 선택된 과일 : 포도
#가장 적게 선택된 과일 : 귤, 자두, 자몽  


# CASE 4

library(tm)
library(proxy)

duke <- c("사과 포도 망고")
dooly <- c("포도 자몽 자두")
ddochi <- c("복숭아 사과 포도")
douner <- c("오렌지 바나나 복숭아")
gildong <- c("포도 바나나 망고")
heedong <- c("포도 귤 오렌지")

fruit <- c(duke,dooly,ddochi,douner,gildong,heedong)

# (1) 좋아하는 과일이 가장 유사한 친구
cps <- VCorpus(VectorSource(fruit))
dtm <- DocumentTermMatrix(cps, control=list(wordLengths = c(1, Inf)))
str(dtm)
(m <- as.matrix(dtm))
(rownames(m) <- c("듀크", "둘리", "또치", "도우너", "길동", "희동"))
com <- m %*% t(m)
com

## 코사인
(r <- dist(com, method = "cosine", diag=T, upper=T))
(r <- dist(com, method = "cosine"))
(s <- as.matrix(r))

## 유클리드
dist(com, method = "Euclidean")
cat("duke와 ddochi/ duke와 gildong학생이 가장 유사하다")


# (2) 학생들에게 가장 많이 선택된 과일
cps <- VCorpus(VectorSource(fruit))
tdm <- TermDocumentMatrix(cps,control=list(wordLengths = c(1, Inf)))
tdm
summary <- as.matrix(tdm)
(most <- sort(rowSums(summary), decreasing=T))

names(which.max(most))
names(which(most==max(most)))
cat("학생들이 좋아하는 과일은 ", paste(names(which(most==max(most))), collapse=", "), "입니다", sep="")

# (3) 학생들에게 가장 적게 선택된 과일
names(which.min(most))   
names(which(most==min(most)))
cat("학생들이 좋아하는 과일은 ", paste(names(which(most==min(most))), collapse=", "), "입니다", sep="")

# 추가
library(qgraph)

qgraph(com, labels=rownames(com), diag=F, 
       layout='spring',  edge.color='blue', 
       vsize=log(diag(com)*800))


