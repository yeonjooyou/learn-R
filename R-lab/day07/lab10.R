# OPEN API 실습 1
searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- ""
Client_Secret <- ""

query <- URLencode(iconv("맛집","euc-kr","UTF-8"))
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))
# 블로그 내용에 대한 리스트 만들기		
doc2 <- htmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue)
#text <- gsub("</?b>", "", text) # </?b> --> <b> 또는 </b>
#text <- gsub("&.+t;", "", text) # &.+t; --> &at;, &abct;, &1t;, &111t; ...
write(text, "output/naverblog.txt")


# OPEN API 실습 2
library(rtweet) 
appname <- ""
api_key <- ""
api_secret <- ""
access_token <- ""
access_token_secret <- ""
twitter_token <- create_token(
  app = appname,
  consumer_key = api_key,
  consumer_secret = api_secret,
  access_token = access_token,
  access_secret = access_token_secret)

key <- "코로나"
key <- enc2utf8(key)
result <- search_tweets(key, n=100, token = twitter_token)
content <- gsub("[[:punct:]][A-Za-z]", "", result$retweet_text)
content <- na.omit(content)
content
write(content, "output/twitter.txt")

# OPEN API 실습 3
library(XML)
API_key  <- ""
bus_No <- "360"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc)
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
#str(df)
#View(df)
cat("[", df$busRouteNm, "번 버스정보 ]\n",
    "노선ID :", df$busRouteId, "\n",
    "노선길이 :", df$length, "\n",
    "기점 :", df$stStationNm, "\n",
    "종점 :", df$edStationNm, "\n",
    "배차간격 :", df$term, "\n")

# case 2
bus.360 <- df[df$busRouteNm == 360,]
cat("[", bus.360$busRouteNm, "번 버스정보 ]\n")
cat("노선ID :", bus.360$busRouteId, "\n")
cat("노선길이 :", bus.360$length, "\n")
cat("기점 :", bus.360$stStationNm, "\n")
cat("종점 :", bus.360$edStationNm, "\n")
cat("배차간격 :", bus.360$term, "\n")


# OPEN API 실습 4
library(jsonlite)
library(httr)
searchUrl<- "https://openapi.naver.com/v1/search/news.json"
Client_ID <- ""
Client_Secret <- ""
query <- URLencode(iconv("빅데이터","euc-kr","UTF-8"))
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/json",
                                 "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))
# news.json으로 요청하면 content타입은 자동으로 application/json으로 응답한다.
json_data <- content(doc, type = 'text', encoding = "UTF-8")
json_obj <- fromJSON(json_data)
df <- data.frame(json_obj)
#View(df)
df_new <- df$items.title # df_new <- df[c('items.title')] 로 하면 벡터로 변환
df_new <- gsub("</?b>", "", df_new)
df_new <- gsub("&.+t;", "", df_new)
#View(df_new)
write.table(df_new, "output/navernews.txt") # write(df_new, "output/navernews.txt")


# 추가

gsub("&.+t;", "", "AB&lt;AB")
gsub("&.+t;", "", "AB&gt;AB")
gsub("&.+t;", "", "AB&quot;AB")
gsub("&.+t;", "", "AB&amp;AB")
gsub("&.+t;", "", "AB&nbsp;AB")

gsub("&.+;", "", "AB&lt;AB")
gsub("&.+;", "", "AB&gt;AB")
gsub("&.+;", "", "AB&quot;AB")
gsub("&.+;", "", "AB&amp;AB")
gsub("&.+;", "", "AB&nbsp;AB")


gsub("&.+t;", "", "AB&lt;가나다&lt;AB")
gsub("&.+t;", "", "AB&lt;가나다&nbsp;AB")
gsub("&.+;", "", "AB&lt;가나다&nbsp;AB")
gsub("&.{2,4};", "", "AB&lt;가나다&nbsp;AB")


