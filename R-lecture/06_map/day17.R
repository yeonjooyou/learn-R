install.packages("rvest")
library(XML)
library(rvest)
url = "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"
read1 <- read_html(url)
read2 <- htmlParse(read1)
first_table <- getNodeSet(read2,"//table")[[1]]
xt <- readHTMLTable(first_table)
str(xt)
head(xt)


# http://www.airkorea.or.kr/ : 한국환경공단 실시간 자료 조회
# 테이블을 한방에 읽어오자 : 동적페이지
install.packages("RSelenium")
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
url <- "http://www.airkorea.or.kr/web/pmRelay?itemCode=11008&pMENU_NO=109"
remDr$navigate(url)

webElem <- remDr$findElement(using = "css", "#dateDiv_1 > img")
webElem$clickElement()
Sys.sleep(1)
webElem <- remDr$findElement(using = "css", "#ui-datepicker-div > table > tbody > tr:nth-child(2) > td:nth-child(6) > a")
webElem$clickElement()
Sys.sleep(1)
webElem <- remDr$findElement(using = "css", "#cont_body > form > div > div > a:nth-child(1)")
webElem$clickElement()
Sys.sleep(3)

library(XML)
elem <- remDr$findElement(using="css", value=".st_1")
elemtxt <- elem$getElementAttribute("outerHTML")
elem_html <- htmlTreeParse(elemtxt, asText = TRUE, useInternalNodes = T, encoding="UTF-8")
Sys.setlocale("LC_ALL", "English")
games_table <- readHTMLTable(elem_html, header = T, stringsAsFactors = FALSE)[[1]]
Sys.setlocale()
Encoding(names(games_table)) <- "UTF-8"
head(games_table)
str(games_table)
View(games_table)
tail(games_table)
Sys.getlocale()


# 지도 시각화

install.packages("ggmap")
library(ggmap)
register_google(key='')

lon <- 126.9221322
lat <- 37.5268831
cen <- c(lon,lat)
mk <- data.frame(lon=lon, lat=lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=1, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=5, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=10, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=15, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="satellite",zoom=16, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="terrain",zoom=8, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="terrain",zoom=12, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="hybrid",zoom=16, marker=mk)
Sys.sleep(1)
ggmap(map)+labs(title="테스트임", x="경도", y="위도")+
  theme(plot.title=element_text(family="maple", color="blue"))

map <- get_map(location=cen, maptype="toner",zoom=12, marker=mk, source="google")
ggmap(map)
map <- get_map(location=cen, maptype="watercolor",zoom=12, marker=mk, source="stamen")
ggmap(map)
map <- get_map(location=cen, maptype="terrain-background",zoom=12, marker=mk, source="stamen")
ggmap(map)
map <- get_map(location=cen, maptype="toner-lite",zoom=12, marker=mk, source="stamen")
ggmap(map)
map <- get_map(location=cen, maptype="terrain",zoom=12, marker=mk, source="stamen")
ggmap(map)



mk <- geocode("seoul", source = "google")
print(mk)
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=11, marker=mk)
ggmap(map)

mk <- geocode(enc2utf8("부산"), source = "google")
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=11, marker=mk)
ggmap(map)

multi_lonlat <- geocode(enc2utf8("강남구 삼성동 151-7"), source = "google")
mk <- multi_lonlat
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=16)

ggmap(map) + 
  geom_point(aes(x=mk$lon, y=mk$lat), alpha=0.4, size=5, color="pink") +
  geom_text(aes(x=mk$lon, y=mk$lat, label="우리가 공부하는 곳", 
                color="red", vjust=0, hjust=0))


# 제주도
names <- c("용두암","성산일출봉","정방폭포",
           "중문관광단지","한라산1100고지","차귀도")
addr <- c("제주시 용두암길 15",
          "서귀포시 성산읍 성산리",
          "서귀포시 동홍동 299-3",
          "서귀포시 중문동 2624-1",
          "서귀포시 색달동 산1-2",
          "제주시 한경면 고산리 125")
gc <- geocode(enc2utf8(addr))
gc
#save(gc, file="jeju.rda")
#load("jeju.rda")
df <- data.frame(name=names,
                 lon=gc$lon,
                 lat=gc$lat)
cen <- c(mean(df$lon),mean(df$lat)) # 중요
map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     zoom=10,
                     size=c(640,640),
                     marker=gc)
Sys.sleep(2)
ggmap(map) 

ggmap(map) + geom_text(data=df,               
                       aes(x=lon,y=lat,colour="green",
                           family="maple",vjust=1.2,               
                           size=3,label=name)) + guides(color=F)



# 공공 DB 활용 

library(XML)
API_key  <- ""
bus_No <- "360"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc) ; top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList[1]")); df
busRouteId <- df$busRouteId
busRouteId
url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc); top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList")); df
# 구글 맵에 버스 위치 출력
df$gpsX <- as.numeric(as.character(df$gpsX))
df$gpsY <- as.numeric(as.character(df$gpsY))
gc <- data.frame(lon=df$gpsX, lat=df$gpsY);gc
cen <- c(mean(gc$lon), mean(gc$lat))
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12, marker=gc)
Sys.sleep(2)
ggmap(map)


library(dplyr)
library(ggmap)
library(ggplot2)

geocode('Seoul', source = 'google')
geocode('Seoul', source = 'google', output = 'latlona')
geocode(enc2utf8('서울'), source = 'google')
geocode(enc2utf8('서울'), source = 'google', output = 'latlona')
geocode(enc2utf8('서울&language=ko'), source = 'google', output = 'latlona')

station_list = c('시청역', '을지로입구역', '을지로3가역', '을지로4가역', 
                 '동대문역사문화공원역', '신당역', '상왕십리역', '왕십리역', '한양대역', 
                 '뚝섬역', '성수역', '건대입구역', '구의역', '강변역', '잠실나루역', 
                 '잠실역', '신천역', '종합운동장역', '삼성역', '선릉역', '역삼역', 
                 '강남역', '2호선 교대역', '서초역', '방배역', '사당역', '낙성대역', 
                 '서울대입구역', '봉천역', '신림역', '신대방역', '구로디지털단지역', 
                 '대림역', '신도림역', '문래역', '영등포구청역', '당산역', '합정역', 
                 '홍대입구역', '신촌역', '이대역', '아현역', '충정로역')
station_df = data.frame(station_list)
station_df$station_list = enc2utf8(station_df$station_list)
# 다음 행은 한번만 수행시켜 주셔영(^^)- 과금때문에 ㅎㅎㅎ
station_lonlat = mutate_geocode(station_df, station_list, source = 'google')
station_lonlat
save(station_lonlat, file="data/station_lonlat.rda") # 두 번째 테스트부터는 저장했다가 읽자구요
#load("data/station_lonlat.rda")

seoul_lonlat = unlist(geocode('seoul', source = 'google'))
?qmap

qmap('seoul', zoom = 11)
qmap(seoul_lonlat, zoom = 11, source = 'stamen', maptype = 'toner')
seoul_map <- qmap('Seoul', zoom = 11, source = 'stamen', maptype = 'toner')
seoul_map + geom_point(data = station_lonlat, aes(x = lon, y = lat), colour = 'green',
                       size = 4)



# 지도 응용
df <- read.csv("data/전국전기차충전소표준데이터.csv")       
str(df) 
head(df); View(df)
df_add <- df[,c(13, 17, 18)]
names(df_add) <- c("address", "lat", "lon")
df_add$lat <- as.double(df_add$lat)
df_add$lon <- as.double(df_add$lon)
str(df_add)
View(df_add)

map_korea <- get_map(location="southKorea", zoom=7, maptype="roadmap") 
ggmap(map_korea)+geom_point(data=df_add, aes(x=lon, y=lat), alpha=0.5, size=2, color="red")

map_seoul <- get_map(location="seoul", zoom=11, maptype="roadmap")       
ggmap(map_seoul)+geom_point(data=df_add, aes(x=lon, y=lat), alpha=0.5, size=5, color="blue")



#leaflet 그리기

install.packages("leaflet")
library(leaflet)
library(dplyr)
library(ggmap)

seoul_lonlat<-geocode("seoul")

# 지도 배경 그리기 
leaflet()

# 지도 배경에 타일깔기
leaflet() %>% addTiles() 

# 지도 배경에 센터 설정하기
map0 <- leaflet() %>% setView(lng = seoul_lonlat$lon, lat = seoul_lonlat$lat, zoom = 16)  
map0

# 지도 배경에 센터 설정하고 타일깔기
map1 <- map0 %>% addTiles() 
map1

mk <- multi_lonlat
lon <- mk$lon
lat <- mk$lat
msg <- '<strong><a href="http://www.multicampus.co.kr" style="text-decoration:none" >멀티캠퍼스</a></strong><hr>우리가 공부하는 곳 ㅎㅎ'
map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 16) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 18) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 5) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 1) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2


content1 <- paste(sep = '<br/>',"<b><a href='https://www.seoul.go.kr/main/index.jsp'>서울시청</a></b>",'아름다운 서울','코로나 이겨냅시다!!')
map3 <- leaflet() %>% addTiles() %>%  addPopups(126.97797, 37.56654, content1)
map3

content2 <- paste(sep = '<br/>',"<b><a href='http://www.snmb.mil.kr/mbshome/mbs/snmb/'>국립서울현충원</a></b>",'1955년에 개장', '2013년 ‘서울 미래유산’으로 등재')
map4 <- leaflet() %>% addTiles() %>%  addPopups(c(126.97797, 126.97797),  c(37.56654, 37.50124) , c(content1, content2), options = popupOptions(closeButton = FALSE) )
map4

wifi_data = read.csv('data/wifi_data.csv', encoding = 'utf-8')
#View(wifi_data)
leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], 
          lat = seoul_lonlat[2], 
          zoom = 11) %>% 
  addTiles() %>% 
  addCircles(lng = ~lon, lat = ~lat)


leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat = ~lat)


leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  addCircles(lng = ~lon, lat = ~lat)

leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat = ~lat, popup = ~div)

?colorFactor
telecom_color = colorFactor('Set1', wifi_data$div)
telecom_color(wifi_data$div)
str(telecom_color)
mode(telecom_color)
leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat=~lat, popup = ~div, color = ~telecom_color(div)) -> mymap

leaflet() %>%
  addTiles() %>%
  setView( lng=lon, lat=lat, zoom = 16) %>%
  addProviderTiles("Esri.WorldImagery")


leaflet() %>%
  addTiles() %>%
  setView( lng=lon, lat=lat, zoom = 6) %>%
  addProviderTiles("NASAGIBS.ViirsEarthAtNight2012")




# 미국 주별 강력 범죄율 단계 구분도 만들기
# 패키지 준비하기
install.packages("ggiraphExtra")
library(ggiraphExtra)
library(tibble)

# 행 이름을 state 변수로 바꿔 데이터 프레임 생성
crime <- rownames_to_column(USArrests, var = "state")
head(crime)
# 지도 데이터와 동일하게 맞추기 위해 state의 값을 소문자로 수정
crime$state <- tolower(crime$state)

str(crime)

library(ggplot2)
states_map <- map_data("state")
str(states_map)

ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map)     # 지도 데이터

ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map,     # 지도 데이터
             interactive = T)      # 인터랙티브

# 한국 단계구분도

#install.packages("stringi")
#install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)
library(dplyr)

# 시도
class(korpop1)
head(korpop1)
head(kormap1)

# 시군구
class(korpop2)
head(korpop2)
head(kormap2)

# 읍면동
class(korpop3)
head(korpop3)
head(kormap3)

rm(korpop1, korpop2, korpop3)

korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)
korpop1$name <- iconv(korpop1$name, "UTF-8","CP949")


korpop2 <- rename(korpop2,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)
korpop2$name <- iconv(korpop2$name, "UTF-8","CP949")


korpop3 <- rename(korpop3,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)
korpop3$name <- iconv(korpop3$name, "UTF-8","CP949")


# https://rstudio-pubs-static.s3.amazonaws.com/222145_fdcc8a5cb9584950ae7e8097304bf398.html

ggplot(korpop1,aes(map_id=code, fill=pop))+
  geom_map(map = kormap1, colour="black",size=0.1)+
  expand_limits(x= kormap1$long,y = kormap1$lat)+
  scale_fill_gradientn(colours = c('white','orange','red'))+
  ggtitle('2014년도 시도별 인구분포도')

ggplot(korpop2,aes(map_id=code, fill=pop))+
  geom_map(map = kormap2, colour="black",size=0.1)+
  expand_limits(x= kormap2$long,y = kormap2$lat)+
  scale_fill_gradientn(colours = c('white','skyblue','blue', 'darkblue'))+
  ggtitle('2014년도 시군구별 인구분포도')


ggplot(korpop3,aes(map_id=code, fill=pop))+
  geom_map(map = kormap3, colour="black",size=0.1)+
  expand_limits(x= kormap3$long,y = kormap3$lat)+
  scale_fill_gradientn(colours = c('white','orange','red'))+
  ggtitle('2014년도 읍면동별 인구분포도')


seoulmap <- kormap2 %>% filter(startsWith(as.character(code), '11'))
seoulpop <- korpop2 %>% filter(startsWith(as.character(code), '11'))

ggplot(seoulpop,aes(map_id=code, fill=pop))+
  geom_map(map = seoulmap, colour="black",size=0.1)+
  expand_limits(x= seoulmap$long,y = seoulmap$lat)+
  scale_fill_gradientn(colours = rainbow(7))+
  ggtitle('2014년도 서울시 구별 인구분포도')


ggChoropleth(data = korpop1,       # 지도에 표현할 데이터
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도 데이터
             palette="RdBu",       # 칼라 팔레트
             interactive = T)      # 인터랙티브


ggChoropleth(data = korpop2,       # 지도에 표현할 데이터
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap2,        # 지도 데이터
             palette="Set3",       # 칼라 팔레트
             interactive = T)      # 인터랙티브


ggChoropleth(data = korpop3,       # 지도에 표현할 데이터
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap3,        # 지도 데이터
             palette="YlOrRd",     # 칼라 팔레트
             interactive = T)      # 인터랙티브


# 실습18
### 통계분석과 기본 그래프
## 김 대표의 양계장에는 7개의 부화장이 있고 부화장마다 최대 30개의 알을 부화시킬 수 있다.
## 병아리는 부화하는데 걸리는 기간이 약 21일이다.
## 어제까지 딱 21일이 지났다. 총 몇마리의 병아리가 부화했는지 알아보자.
## (1) 어제까지 몇 마리의 병아리가 부화했을까? (기초통계량)

# 데이터 파일 읽어오기
hat <- read.csv("data/data1.csv")
hat

# 데이터 확인하기, head는 가장 위 6행만 보여줌
head(hat)

# 데이터 확인하기, tail은 가장 아래 6행만 보여줌
tail(hat)

# head는 아래와 같이 df옆에 숫자를 입력하면 해당 숫자만큼 행이 출력됨
head(hat,3)

# 합계 구하기
sum(hat$chick)

# 평균 구하기
mean(hat$chick)

# 표준편차 구하기
sd(hat$chick)

# 중앙값 구하기
median(hat$chick)

# 최소값 구하기
min(hat$chick)

# 최대값 구하기
max(hat$chick)

# 데이터 정렬하기
hat_asc <- hat[order(hat$chick),] # chick 열을 기준으로 오름차순 정렬
hat_asc

# 간단한 그래프를 그려서 보자
# 막대그래프
barplot(hat$chick)

# 다양한 옵션을 통해 막대그래프 정보를 추가하자
barplot(hat$chick, names.arg = hat$hatchery,
        col = c("red","orange","yellow","green", "blue", "navy", "violet"), 
        main = "부화장별 병아리 부화현황", xlab = "부화장", ylab = "병아리수",
        ylim = c(0,35))

?barplot

install.packages("RColorBrewer") # RColorBrewer 이라는 색상 팔레트 패키지 설치
library(RColorBrewer) # RColorBrewer 패키지 현재 작업 환경으로 불러오기
display.brewer.all()

col7 <- brewer.pal(7, "Pastel2")  # col7이라는 변수에 "Pastel2"라는 팔레트에서 7개의 색상을 집어넣음
col7

barplot(hat$chick, names.arg = hat$hatchery,
        col = col7, 
        main = "부화장별 병아리 부화현황", xlab = "부화장", ylab = "병아리수",
        ylim = c(0,35))


bar_x <- barplot(hat$chick)  # bar_x 변수에 barplot의 x좌표 집어넣음

# 위에 bar_x 라는 변수를 만들어주는 이유는 x좌표를 알아내기 위함임
bar_x

# 다시 예쁜 그래프 기리기
barplot(hat$chick, names.arg = hat$hatchery,
        col = col7, 
        main = "부화장별 병아리 부화현황", xlab = "부화장", ylab = "병아리수",
        ylim = c(0,35))

# 막대그래프에 text 추가, pos는 라벨의 위치
text(x = bar_x, y = hat$chick, labels = hat$chick, pos = 3)

# 막대그래프에 30기준으로 빨간색 점선 추가
abline(h = max(hat$chick), col = "red", lty = 2, lwd = 1)

# 파이차트 그리기

# 파이차트 그리기에 앞서 Percentage 열 만들어줌
hat$pct <- round(hat$chick/sum(hat$chick)*100, 1)
hat

# 파이차트 그리기
?pie
pie(hat$chick, labels = paste(hat$hatchery, hat$pct, "%"), 
    col = col7, clockwise = TRUE, 
    main = "부화장별 병아리 부화 비율")

## 체계적인 사육을 위해 김대표는 부화된 병아리 모두에 GPS 위치추적기가 탑재된 Tag를 부착해
## 병아리 개별 데이터를 수집하기로 했다. 먼저 병아리들의 몸무게를 측정한다.

## 정규분포 : 평균값과 표준편차에 의해 모양이 결정되는 연속확률분포
##            주변에서 흔히 볼 수 있는 데이터들의 분포는 대부분 정규분포
## 중심극한정리 : 데이터가 적당히 많을 경우(일반적으로 30이상) 정규분포에 가까워 진다.
##                평균값과 표준편차만 알아도 대략적인 데이터의 분포를 알아낼 수 있다.

## (2) 부화한 병아리들의 체중은 얼마일까? (정규분포와 중심극한정리)

# 샘플 병아리 데이터를 불러오기
b <- read.csv("data/data2.csv")

# 데이터가 정상적으로 불러와졌는지 확인하기, head는 가장 위 6행만 보여줌
head(b)

# 데이터의 형태와 변수 개수, 데이터 길이 확인 함수
str(b)

# 대략적인 데이터의 분포 확인
summary(b)

# B 부화장 병아리 무게 표준편차
sd(b$weight)

## (참고)정규분포 그래프 설명용 그리기
x <- seq(-5, 5, length = 500)
y1 <- dnorm(x, mean = 0, sd = 1)
y2 <- dnorm(x, mean = 0, sd = 2)

plot(x, y1, type = "l", col = "blue", ylabel = NULL, xlabel = NULL, main = "표준편차(1, 2)에 따른 정규분포 비교")
lines(x, y2, type = "l", col = "red")
legend("topright", c("X~N(0,1)","X~N(0,4)"), text.col = c("blue", "red"))
##########################################################################

# Histogram으로 분포 확인
hist(b$weight, col = "sky blue", xlab = "병아리 무게(g)", main = "B 부화장 병아리 무게 분포 현황")

# Box-Plot으로 분포 확인
boxplot(b$weight, col = "sky blue", main = "B 부화장 병아리 무게 상자그림")

# 히스토그램과 Box-Plot을 같이 그리기
par(mfrow=c(2,1))  # 행 2개, 열 1개
hist(b$weight, col = "sky blue", xlab = "병아리 무게(g)", , main = "B 부화장 병아리 무게 분포 현황")
boxplot(b$weight, horizontal = TRUE, col = "sky blue")
par(mfrow=c(1,1)) 

## 히스토그램과 상자그림을 통해 병아리의 몸무게가 어느 정도인지 확인한 결과 30마리의 체중이
## 30~45g 사이에 분포하며 그중 절반은 36.25(1사분위 수)~40.75(3사분위 수) 사이에 분포한다는
## 것을 파악할 수 있다.

## 병아리가 부화한지 5일이 지났다. 그런데 이상한 점을 발견했다. 부화장 A에서 태어난 병아리 
## 대비 부화장 B에서 태어난 병아리의 덩치가 더 작아 보인다. 서로 다른 사료를 먹이고 있기는
## 한데 기분 탓인지, 아니면 정말 작인지 검정해 보자.

## (3) 사료 제조사별 성능차이가 있을까? (가설검정)

# 파일의 데이터 불러오기
test <- read.csv("data/data3.csv")
test

# 상자그림을 2개 그려서 비교해봄
boxplot(weight ~ hatchery, data = test, 
        horizontal = TRUE, col = c("light green", "sky blue"),
        ylab= "부화장", xlab = "몸무게 분포",
        main = "부화장 A vs. B 몸무게 분포 비교")

## 통계적으로 두 집단의 몸무게가 같은지 다른지는 어떻게 설명할 수 있을까?
## 이럴 때 사용하는 것이 바로 가설검정이다.
## 가설검정이란 통계추론의 영역으로 "비교하는 값과 차이가 없다"는 가정의 귀무가설과
## 반대인 대립가설을 설정해서 검정 통계량으로 가설의 진위를 판단하는 방법이다.

## 두 집단의 몸무게 평균이 같은지 다른지 가설검정의 방법론인 t-test를 통해 진행한다.
## t-test는 데이터가 정규분포를 한다는 가정하에 평균의 데이터의 대푯값을 한다고 전제한다.
## 따라서 t-test를 수행하기 전에 데이터가 정규분포를 따르는지 검정한다.
## 데이터의 정규성 검정 : 샤피로 월크 검정 
##    귀무가설 : 정규 분포한다. 대립가설 : 정규분포하지 않는다.
##    95% 신뢰수준을 적용하여 계산되는 유의확률(p값)이 0.05 보다 작으면 귀무가설을 기각하고
##    0.05 보다 크면 귀무가설을 채택한다. 유의확률(p값)이란 귀무가설을 지지하는 정도이다.
# 두 집단이 우선 정규분포를 따르고 있는지 샤피로 월크 검정 실시한다.

a <- subset(test$weight, test$hatchery == 'A')
b <- subset(test$weight, test$hatchery == 'B')
shapiro.test(a)
shapiro.test(b)

## 부화 후 일주일 뒤 각각 다른 사료를 먹고 키운 병아리의 성장에 차이가 있을까?
## 두 집단의 평균이 다르다고 할 수 있을까? -> t-test 를 통해서 검정 - 계산되는 유의확률 p 값으로 결정
##    귀무가설 :두 집단의 평균에 차이가 없다.  대립가설 :두 집단의 평균에 차이가 있다.                             

t.test(data = test, weight ~ hatchery) 

# 결과해석 : p값이 0.01094로 0.05보다 작으므로 대립가설을 채택함, 즉 두 집단의 평균은 다름


## 상관분석과 회귀분석
## 상관분석과 회귀분석은 데이터 분석 모델을 만들기 위한 가장 기초적인 관문이다. 
## 상관분석은 변수와 변수의 관계가 서로 비례 또는 반비례 관계인지 +와 - 부호로 표현하고
## 회귀분석은 서로 상관관계가 있는 연속형 변수들의 관계를 수식으로 나타낸다.

## 병아리의 성장(체중)에 영향을 미치는 인자는 무엇일까? (상관분석)
## 유전적인 요소? 사료의 양?

# 데이터 불러오기
w <- read.csv("data/data4.csv")

head(w)
tail(w)
str(w)

# w 데이터 셋에서 2~5열 데이터만 가져오기(첫열은 factor이므로)
w_n <- w[,2:5]
head(w_n)

# 위와 동일
w_n <- subset(w, select = -c(chick_nm))

head(w_n)

## 상관분석을 실시하면 두 변수 간의 관계를 상관 계수로 나타낸다.
## 상관계수는 두 변수 간에 연관된 정도만 나타낼 뿐 인과관계(원인-결과)를 설명하는 것은 아니다.
## 상관계수는 -1~1사이의 값을 갖는다. 

w_cor <- cor(w_n)  # w_n 데이터 셋으로 상관분석한 결과를 w_cor변수에 넣음
w_cor  # w_cor 상관분석 결과 확인

## 상관분석을 통하여 얻은 상관계수가 과연 통계적으로도 유의한가?
## 유의성 검정의 귀무가설 : 두 변수는 선형관계가 없어 상관계수가 0이다. 
## 유의성 검정의 연구가설 : 두 변수 간에는 선형관계가 존재하여 상관계수가 0이 아니다.
cor.test(w_n$weight, w_n$egg_weight)
cor.test(w_n$weight, w_n$movement)
cor.test(w_n$weight, w_n$food)

plot(w_n)  # w_n 데이터 셋 산점도로 표현

# 상관분석을 보다 잘 표현할 수 있는 상관분석 관련 시각화 패키지들 소개
install.packages("corrplot")   # 패키지 설치
library(corrplot)  # corrplot 패키지 불러오기

# 그냥 한번 실행해보기(주의할 점은 데이터셋이 아닌 상관분석결과를 넣어야함)
corrplot(w_cor)  # 상관분석 결과인 w_cor을 corrplot 패키지로 실행해보기

# 원을 타원으로 표시하고, 하단에만 표시하고, 상관계수 표시
corrplot(w_cor, method = "ellipse", 
         type = "lower", addCoef.col = "white")


car_cor <- cor(mtcars)
round(car_cor,2)
corrplot(car_cor)
corrplot(car_cor, type="lower", order="hclust", tl.srt=45)
corrplot(car_cor, method="ellipse", type="lower", order="hclust", tl.srt=45, diag=F)
corrplot(car_cor, method="number", type="lower", order="hclust", tl.srt=45, diag=F)
corrplot(car_cor, method="shade", type="lower", order="hclust", tl.srt=45, diag=F)
corrplot(car_cor, method="color", type="lower", order="hclust", tl.srt=45, diag=F)
corrplot(car_cor, method="pie", type="lower", order="hclust", tl.srt=45, diag=F)
corrplot(car_cor, method="color", type="lower", order="hclust", tl.srt=45)
corrplot(car_cor, method="color", addCoef.col="black", type="lower", order="hclust", tl.srt=45)
corrplot(car_cor, method="color", addCoef.col="black", type="lower", diag=F, tl.srt=45)

install.packages("psych") 
library(psych)
pairs.panels(state.x77, bg="red", pch=21, hist.col="gold", 
             main="Correlation Plot of US States Data")


install.packages("corrgram")
library(corrgram)
corrgram(state.x77, order=TRUE, lower.panel=panel.shade, 
         upper.panel=panel.pie, text.panel=panel.txt,
         main="Corrgram of US States Data")


cols <- colorRampPalette(c("darkgoldenrod4", "burlywood1", 
                           "darkkhaki", "darkgreen"))
corrgram(state.x77, order=FALSE, col.regions=cols,
         lower.panel=panel.pie, upper.panel=panel.conf, 
         text.panel=panel.txt, main="Corrgram of US States Data")

