# R 기본 시각화 (1)
library(showtext)
showtext_auto() 
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")


# 문제 1
file <- readLines("data/product_click.log")
product_id <- substr(file, 14, 17)
id_table <- table(product_id)

barplot(id_table, family="dog", main="세로바 그래프 실습", xlab="상품ID", ylab="클릭수",
        col=terrain.colors(nrow(id_table)), col.main="red", axes=T, cex.axis=0.8, cex.names=0.8)

dev.copy(png, "output/clicklog1.png") 
dev.off()


# 문제 2
#file <- readLines("data/product_click.log")
click_hour <- substr(file, 9, 10)
hour_table <- table(click_hour)

pie(hour_table, main="파이그래프 실습", family="maple",
    labels=paste(as.integer(names(hour_table)), "~", as.integer(names(hour_table))+1),
    col=rainbow(nrow(hour_table)), col.main="blue")

dev.copy(png, "output/clicklog2.png") 
dev.off()


# 문제 3
grade <- read.table("data/성적.txt", header=TRUE)
grade2 <- grade[3:5]

# 학생의 각 과목에 대한 합계 점수에 대한 그래프
xname <- c("길동", "둘리", "또치", "도우너", "희동", "듀크", "턱시", "토토로", "울라프", "우디") #grade$성명    #  x축 레이블용 벡터
par(xpd=T, mar=c(3,3,3,3))   # 우측에 범례가 들어갈 여백을 확보
barplot(t(grade2), family="dog", main="학생별 점수", axes=T, col=cm.colors(3), col.main="hotpink",
        space=0.1, cex.main=2, cex.axis=0.8, names.arg=xname, cex=0.8)
legend(9.5, 29, names(grade2), cex=0.8, fill=cm.colors(3))

dev.copy(png, "output/clicklog3.png") 
dev.off()



# case 2 ~ 3
# 문제 1
log <- read.table('data/product_click.log')
product <- log[,2]
(prod <- table(product))
#png(filename="output/clicklog1.png", height=400, width=700, bg="white")
barplot(prod, main='세로바 그래프 실습', col.main='red', cex.main=2, ylab='클릭수', 
        col=terrain.colors(10), 
        family='dog', cex.names=1, xlab="상품ID") 
#dev.copy(png, 'output/clicklog1.png')
#dev.off()


# 문제 2
time <- log[,1]
time <- substr(time, start=9, stop=10)
(time_tb <- table(time))
names(time_tb) <- c('0-1', '1-2', '2-3', '3-4', '4-5', '5-6', '8-9', '9-10', '10-11', '11-12', '12-13', '13-14', '14-15', '15-16', '16-17', '17-18', '18-19')
#png(filename="output/clicklog2.png", height=700, width=700, bg="white")
pie(time_tb, main='파이그래프 실습', col.main='blue', cex.main=2,
    col=rainbow(17),
    family='maple')
#dev.copy(png, 'output/clicklog2.png')
#dev.off()

# 문제 3
grade <- read.table("data/성적.txt", header=TRUE)
grade <- grade[3:5]
pcol <- c('orange', 'skyblue', 'pink')
xname <- c('길동', '둘리', '또치', '도우너', '희동', '듀크', '턱시', '토토로', '올라프', '우디')
#png(filename="output/clicklog3.png", height=500, width=700, bg="white")
barplot(t(as.matrix(grade)), main='학생별 점수', col.main='magenta', cex.main=2, family='dog',
        col = pcol, cex.axis=0.8,
        names.arg=xname, cex=0.7)
legend(10, 28, names(grade), fill=pcol)
#dev.copy(png, 'output/clicklog3.png')
#dev.off()


###########################################
txt <- readLines("data/product_click.log")

# 문제1
product <- substr(txt, 14, 17)
product_table <- table(product)
xname <- names(product_table)
barplot(product_table, main="세로바 그래프 실습", xlab="상품ID", col.main="red", 
        ylab="클릭수", col=terrain.colors(10), names.arg=xname, family="dog",
        cex.names=0.8)
#dev.copy(png, "output/clicklog1.png") 
#dev.off()

# 문제2
times <- substr(txt, 9, 10)
(times_table <- table(times))
pie(times_table, labels=paste(as.numeric(names(times_table)), "-",  
                              as.numeric(names(times_table)) + 1),col=rainbow(10), family="dog",
    cex=1, radius=1, main="파이그래프 실습", col.main="blue", cex.main=2)
#dev.copy(png, "output/clicklog2.png") 
#dev.off()


# 문제3
성적 <- read.table("data/성적.txt", header=TRUE)
성적1<- 성적[3:5]
(xname <- 성적$성명)
#png("output/clicklog3.png", 500, 400)
par(xpd=T, mar=c(5,5,5,5), family="dog")
barplot(t(성적1), main="학생별 점수", cex.main=2, col.main="pink2",
        col=heat.colors(3), space=0.1, cex.axis=0.8, names.arg=xname, cex=0.8)
legend(11,30, names(성적1), cex=0.8, fill=heat.colors(3))
#dev.off()
