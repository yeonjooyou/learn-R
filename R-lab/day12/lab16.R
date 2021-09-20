# R 기본 시각화 (2)
library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")


# 문제 1
file <- readLines("data/product_click.log")
date <- as.Date(substr(file, 1, 8),format='%Y%m%d')

day_levels <- c("월요일", "화요일", "수요일", "목요일", "금요일", "토요일")
# date에 저장된 날짜의 요일 순번을 확인. ordered 옵션 이용.
weekday_table <- table(factor(weekdays((date)), levels=day_levels, ordered=TRUE))

png(filename="output/clicklog4.png", height=400, width=700, bg="white")
par(mfrow=c(1,2), family="cat")
plot(weekday_table, type="o", lwd=5, main="요일별 클릭 수", cex.main=2,cex.axis=0.8,
     ylab="", ylim=c(0,300), col="orange")
barplot(weekday_table, main="요일별 클릭 수", axes=T, cex.main=2, cex.axis=0.8, cex.names=0.8,
        ylim=c(0,300), col=topo.colors(nrow(weekday_table)))
dev.off()
par(mfrow=c(1,1), mar=c(5,4,4,2)+.1)


# 문제 2
reviews <- read.csv("output/movie_reviews3.csv")

png(filename="output/clicklog5.png", height=400, width=700, bg="white")
par(mfrow=c(1,3), family="maple")
hist(reviews$vpoint, main="모가디슈 영화 평점 히스토그램(auto)", cex.main=1, xlab="평점", ylab="평가지수", 
       col=heat.colors(10), border = "black")
hist(reviews$vpoint, main="모가디슈 영화 평점 히스토그램(1~5,6~10)", cex.main=1, xlab="평점", ylab="평가지수", 
     breaks=2, col=cm.colors(2), border = "black")
hist(reviews$vpoint, main="모가디슈 영화 평점 히스토그램(1~5,6,7,8,9,10)", cex.main=1, las=1, xlab="평점", ylab="평가지수", 
     breaks=c(1,5,6,7,8,9,10), probability=F, col="gray", col.main="red", border = "black")

dev.off()
par(mfrow=c(1,1), mar=c(5,4,4,2)+.1)


# 문제 3
grade <- read.table("data/성적.txt", header=TRUE)
grade2 <- grade[3:5]

#boxplot(grade2, family="dog", main="과목별 성적 분포", col.main="orange", col=c("red", "green", "blue")) 
boxplot(grade2, axes=F, col=c("red", "green", "blue"), family="maple") #rainbow(3)
axis(1, at=1:3, lab=names(grade2), family="maple") # x축 추가
axis(2, at=seq(2, 10, 2), family="maple")
title("과목별 성적 분포", family="maple", cex.main=2, col.main="orange")
box()

dev.copy(png, "output/clicklog6.png") # dev.copy(png, "output/clicklog6.png", 400, 600) 
dev.off()


