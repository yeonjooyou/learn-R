# 문제 1
library(fmsb)
stats <- read.csv("data/picher_stats_2017.csv", encoding = "UTF-8")
#View(stats)
stats_kelly <- subset(stats, 선수명=="켈리")
stats_kelly <- data.frame(subset(stats_kelly, select=c("삼진.9", "볼넷.9", "홈런.9")))
max.score <- rep(100,5)          # 100을 5회 반복
min.score <- rep(0,5)            # 0을 5회 반복
ds <- rbind(max.score,min.score, stats_kelly*10)
colnames(ds) <- c("삼진", "볼넷", "홈런")

radarchart(ds,                           # 데이터프레임
           pcol='red',                   # 다각형 선의 색 
           pfcol=rgb(0.2,0.5,0.5,0.5),   # 다각형 내부 색
           plwd=3,                       # 다각형 선의 두께
           cglcol='grey',                # 거미줄의 색
           cglty=1,                      # 거미줄의 타입
           cglwd=0.8,                    # 거미줄의 두께
           axistype=1,                   # 축의 레이블 타입
           seg=4,                        # 축의 눈금 분할                         
           axislabcol='grey',            # 축의 레이블 색
           caxislabels=seq(0,100,25),    # 축의 레이블 값
           title = '켈리 선수의 성적'
           )

dev.copy(png, "output/lab19.png")
dev.off()


# 문제 2
library(leaflet)
library(dplyr)
library(ggmap)
register_google(key='')

mk <- geocode(enc2utf8(""), source = "google")
lon <- mk$lon
lat <- mk$lat
msg <- '<b>집</b>'
map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 16) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='hotpink', popup = msg )
map2


# 문제 3
library(dplyr)
# (1)
iris %>%
  summarise(mean(Sepal.Width),
            sd(Sepal.Width),
            quantile(Sepal.Width, 0.75))

# (2)
ggplot(iris, aes(x=Sepal.Width, fill=Species, color=Species)) +
  geom_histogram(binwidth = 0.5, position='dodge') +
  theme(legend.position='top')

# (3)
boxplot(Sepal.Width ~ Species, data=iris)
# versicolor

# (4)
#iris %>% filter(Species=='setosa') %>% select(Sepal.Width) -> s
#iris %>% filter(Species=='versicolor') %>% select(Sepal.Width) -> v

s <- filter(iris, Species=="setosa")$Sepal.Width
v <- filter(iris, Species=="versicolor")$Sepal.Width


# (5)
shapiro.test(s)
# p-value = 0.2715이므로 정규성을 갖지 않는다.
shapiro.test(v)
#p-value = 0.338이므로 정규성을 갖지 않는다.


# (6)
t.test(s, v)
# p-value = 2.484e-15이므로 두 그룹 간 평균에 유의미한 차이가 있다.


# (7)
test <- filter(iris, Species=="virginica")[1:4]


# (8)
cor.test(test$Sepal.Length, test$Sepal.Width)
cor.test(test$Sepal.Length, test$Petal.Length)
cor.test(test$Sepal.Length, test$Petal.Width)

cor(test[,1:4])
# Petal.Length와 상관계수가 가장 높다.



# [ 문제 1번 ]
# CASE 1
library(fmsb)
data <- read.csv("data/picher_stats_2017.csv", fileEncoding = "utf-8")
data <- data[3,]
data <- c(data$삼진.9, data$볼넷.9, data$홈런.9)
max.data <- rep(10,3)
min.data <- rep(0,3)
data <- rbind(max.data, min.data, data)
data <- data.frame(data)
colnames(data) <- c("삼진","볼넷","홈런")

radarchart(data,title="양현종 선수의 성적",pcol="dark blue", pfcol=rgb(0.2,0.2,0.5,0.5), 
           plwd=3,cglty=1,
           cglcol="grey", cglwd=0.8, axistype=1, axislabcol="grey")

# CASE 2
library(fmsb)
baseball <- read.csv("data/picher_stats_2017.csv", encoding = "UTF-8")

양현종 <- baseball[3,]
stat <- c(양현종$승, 양현종$패, 양현종$삼진, 양현종$볼넷, 양현종$홈런)
max.stat <- rep(100,5)
min.stat <- rep(0,5)
ps <- rbind(max.stat, min.stat, stat)
ps <- data.frame(ps)
colnames(ps) <- c('승', '패', '삼진', '볼넷', '홈런')

radarchart(ps,                          
           pcol='red',             
           pfcol='#ffe6e6',   
           plwd=3,                       
           cglcol='pink',               
           cglty=1,                     
           cglwd=0.8,                    
           axistype=1,                  
           seg=5,                                                 
           axislabcol='green',           
           caxislabels=seq(0,100,20), 
           title = '양현종 선수의 성적'
)

# CASE 3
library(dplyr)
library(fmsb)
pro <- read.csv("data/picher_stats_2017.csv", encoding="UTF-8")
person_no <- sample(1:nrow(pro), 1)
person <- pro[person_no,] %>%
  select(선수명, 삼진.9, 볼넷.9, 홈런.9) %>%
  rename(삼진 = 삼진.9, 볼넷 = 볼넷.9, 홈런 = 홈런.9)
max <- c(max(pro["삼진.9"]), max(pro["볼넷.9"]), max(pro["홈런.9"]))
min <- c(min(pro["삼진.9"]), min(pro["볼넷.9"]), min(pro["홈런.9"]))
df <- rbind(max, min, person[2:4])
#png(filename="output/lab19.png")
radarchart(df, title=paste(person$선수명, "선수의 성적"),
           cglty=1,
           cglcol="grey",
           #axistype=1,    
           pcol="red",
           pfcol=rgb(1,0,0,0.3))
#dev.off()

# [ 문제 2번 ]
# CASE 1
library(leaflet)
library(ggmap)
library(dplyr)
register_google(key='')

house_lonlat <- geocode(enc2utf8("대전"), source = "google")

house <- house_lonlat
lon <- house$lon
lat <- house$lat
msg <- '<strong>나의 집</strong>'
map_house <- leaflet() %>% setView(lng = house$lon, lat = house$lat, zoom = 16) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='blue', popup = msg )
map_house

# CASE 2

library(leaflet)
library(ggmap)
register_google(key='')
home_lonlat <- geocode(enc2utf8("서울 강북구 월계로 173"), source = "google")
lon <- home_lonlat$lon
lat <- home_lonlat$lat
msg <- '<strong>우리집 근처 북서울 꿈의 숲</strong>'
map <- leaflet() %>% setView(lng = home_lonlat$lon, lat = home_lonlat$lat, zoom = 16) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='hotpink', popup = msg )
map

# [ 문제 3번 ]
# CASE 1
# (1) Sepal.Width(꽃받침 너비)열의 데이터 평균과 표준편차 그리고 3분위수를 구한다.
mean(iris$Sepal.Width)
sd(iris$Sepal.Width)
summary(iris$Sepal.Width)[5]
# (2) Sepal.Width열의 데이터 히스토그램을 그린다.
hist(iris$Sepal.Width, xlab = "Sepal.Width", main = "꽃받침 너비")
# (3) 상자그림을 이용해 붓꽃품종(Species), Sepal.Width의 분포를 나타내 본다.
# Sepal.Width가 가장 넓은 품종은 어떤 종인가?
boxplot(Sepal.Width ~ Species, data=iris)
print("Sepal.Width는 setosa가 제일 크다")
aggregate(iris$Sepal.Width, by=list(iris$Species), summary)
aggregate(iris$Sepal.Width, by=list(iris$Species), range)
# (4) setosa 품종의 Sepal.Width만 필터링하여 s 라는 데이터셋을 만들고 versicolor
# 품종의 Sepal.Width를 필터링해 v라는 데이터셋을 만든다.
s <- subset(iris$Sepal.Width, iris$Species == 'setosa')
v <- subset(iris$Sepal.Width, iris$Species == 'versicolor')
# (5) 데이터셋 s와 v가 정규분포를 따르는지 검정한다.
s.p <- shapiro.test(s)
v.p <- shapiro.test(v)
cat("s는 p-value :", s.p$p.value, "로 정규분포한다.\n")
cat("v는 p-value :", v.p$p.value, "로 정규분포한다.\n")
# (6) 데이터셋 s와 v의 평균이 같다고 볼 수 있는지 t-test를 통해 검정한다.
t <- t.test(s,v)
cat("s와 v에 대한 t-test의 p-value :", t$p.value, "로 s와 v의 평균은 다르다\n")
# (7) iris 데이터셋에서 Species가 virginica 인 수치형 데이터(1열~4열)만을 
# 필터링하여 test라는 데이터셋을 만든다.
test <- iris[iris$Species == 'virginica',][,1:4]
# (8) test의 Sepal.Length(꽃받침 길이)와 나머지 변수들이 어떤 상관관계가 있는지 
# 상관분석을 해보고 그중 상관계수가 가장 높은 변수가 무엇인지 알아본다.
cor <- cor(test)["Sepal.Length", -1]
cat("Sepal.Length와 상관계수가 가장 높은 변수는 ", names(cor[cor == max(cor)]), "입니다.\n")


# CASE 2
library(dplyr)
# (1)
iris %>%
  summarise(mean(Sepal.Width),
            sd(Sepal.Width),
            quantile(Sepal.Width, 0.75))

# (2)
ggplot(iris, aes(x=Sepal.Width, fill=Species, color=Species)) +
  geom_histogram(binwidth = 0.5, position='dodge') +
  theme(legend.position='top')

# (3)
boxplot(Sepal.Width ~ Species, data=iris)
# versicolor

# (4)
#iris %>% filter(Species=='setosa') %>% select(Sepal.Width) -> s
#iris %>% filter(Species=='versicolor') %>% select(Sepal.Width) -> v

s <- filter(iris, Species=="setosa")$Sepal.Width
v <- filter(iris, Species=="versicolor")$Sepal.Width


# (5)
shapiro.test(s)
# p-value = 0.2715이므로 정규성을 갖는다.
shapiro.test(v)
#p-value = 0.338이므로 정규성을 갖는다.


# (6)
t.test(s, v)
# p-value = 2.484e-15이므로 두 그룹 간 평균에 유의미한 차이가 있다.


# (7)
test <- filter(iris, Species=="virginica")[1:4]


# (8)
cor.test(test$Sepal.Length, test$Sepal.Width)
cor.test(test$Sepal.Length, test$Petal.Length)
cor.test(test$Sepal.Length, test$Petal.Width)

cor(test[,1:4])
# Petal.Length와 상관계수가 가장 높다.



