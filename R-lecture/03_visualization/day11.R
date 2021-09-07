
# 한국어 형태소 분석 패키지 설치
# Rtools 설치
# https://cran.r-project.org/bin/windows/Rtools/index.html
install.packages("Sejong")
install.packages("hash")
install.packages("tau")
install.packages("devtools") # 시간이 오래 걸림

# github 버전 설치
# 64bit 에서만 동작합니다.
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

library(KoNLP)
# 일부 패키지의 버전 문제로 업데이트 설치 요구함. 1번(All) 선택하고 계속 진행할 것
useSejongDic()
#Sys.getenv("JAVA_HOME")

word_data <- readLines("data/애국가(가사).txt")
word_data

word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F) # USE.NAMES = T : list의 name이 문서의 행단위로 읽힘
word_data2
word_data3 <- extractNoun(word_data)
word_data3


add_words <- c("백두산", "남산", "철갑", "가을", "달")
buildDictionary(user_dic=data.frame(add_words, rep("ncn", length(add_words))), replace_usr_dic=T) # ncn : 비서술성 명사

word_data3 <- extractNoun(word_data)
word_data3

undata <- unlist(word_data3)
undata

word_table <- table(undata)
word_table

undata2 <- Filter(function(x) {nchar(x) >= 2}, undata)
word_table2 <- table(undata2)
word_table2

final <- sort(word_table2, decreasing = T)

head(final, 10)

extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")
SimplePos22("대한민국의 영토는 한반도와 그 부속도서로 한다")
SimplePos09("대한민국의 영토는 한반도와 그 부속도서로 한다") # 9가지 품사로 나타냄



# 워드 클라우드
install.packages("wordcloud")
install.packages("wordcloud2")
library(wordcloud)
library(wordcloud2)

(words <- read.csv("data/wc.csv"))
head(words)
?windowsFonts
windowsFonts(lett=windowsFont("휴먼옛체"))
windowsFonts(dog=windowsFont("THE개이득"))
wordcloud(words$keyword, words$freq)
wordcloud(words$keyword, words$freq,family="lett")
wordcloud(words$keyword, words$freq,family="dog")
wordcloud(words$keyword, words$freq, 
          min.freq = 2, 
          random.order = F, 
          rot.per = 0.5, scale = c(4, 1), 
          colors = rainbow(7))

wordcloud(words$keyword, words$freq, 
          min.freq = 2, 
          random.order = F, 
          rot.per = 0.5, scale = c(4, 1), 
          colors = rainbow(20), family="lett")


wordcloud2(words, fontFamily = "휴먼옛체")
wordcloud2(words,rotateRatio = 1)
wordcloud2(words,rotateRatio = 0.5)
wordcloud2(words,rotateRatio = 0)
wordcloud2(words,size=0.5,col="random-dark") # col = color
wordcloud2(words,size=0.7,col="random-light",backgroundColor = "black")
wordcloud2(data = demoFreq) # str(demoFreq)
wordcloud2(data = demoFreq, shape = 'diamond')
wordcloud2(data = demoFreq, shape = 'star')
wordcloud2(data = demoFreq, shape = 'cardioid')
wordcloud2(data = demoFreq, shape = 'triangle-forward')
wordcloud2(data = demoFreq, shape = 'triangle')
result<-wordcloud2(data = demoFreq, shape = 'pentagon')
library(htmlwidgets)
saveWidget(result,"output/tmpwc1.html",selfcontained = T) #오동작
saveWidget(result,"output/tmpwc2.html",selfcontained = F)
htmltools::save_html(result,"output/tmpwc3.html") # 패키지명::함수명()


head(demoFreq)
str(demoFreq)

wordcloud(names(final),final)
wordcloud(names(final),final, min.freq = 1)
wordcloud2(final)

# 트위터 글 워드클라우드
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
  access_secret = access_token_secret,
  set_renv=F)

key <- "취업"
key <- enc2utf8(key)
result <- search_tweets(key, n=100, token = twitter_token)

content <- result$retweet_text
content <- gsub("[[:lower:][:upper:][:digit:][:punct:][:cntrl:]]", "", content)   
content <- gsub("취업", "", content)  
word <- extractNoun(content)
cdata <- unlist(word)

cdata <- Filter(function(x) {nchar(x) < 6 & nchar(x) >= 2} ,cdata)
wordcount <- table(cdata) 
wordcount <- head(sort(wordcount, decreasing=T),30)

par(mar=c(1,1,1,1))
wordcloud(names(wordcount),freq=wordcount,scale=c(3,0.5),rot.per=0.35,min.freq=1,
          random.order=F,random.color=T,colors=rainbow(20))

wordcloud2(wordcount, fontFamily = "맑은고딕", size=0.5,
           color="random-light", backgroundColor="black")

wordcloud2(wordcount, fontFamily = "THE개이득", size=0.5,
           color="random-light", backgroundColor="black")

wordcloud2(wordcount, size=0.5,
           color="random-light")


# 행렬곱

m1=matrix(1:4,2)
m1
m1 %*% m1

m2=matrix(1:6,2)
m2
m3=matrix(1:9,3)
m3
m2 %*% m3




install.packages("tm")
library(tm)

getSources()



lunch <- c("커피 파스타 치킨 샐러드 아이스크림",
           "커피 우동 소고기김밥 귤",
           "참치김밥 커피 오뎅",
           "샐러드 피자 파스타 콜라",
           "티라무슈 햄버거 콜라",
           "파스타 샐러드 커피"
           )

cps <- VCorpus(VectorSource(lunch))
tdm <- TermDocumentMatrix(cps)
tdm
as.matrix(tdm)

tdm <- TermDocumentMatrix(cps, 
                          control=list(wordLengths = c(1, Inf)))

tdm
(m <- as.matrix(tdm))

rowSums(m)
colSums(m)



m
t(m)
# Co-occurrence matrix - 동시 발생 행렬 -
# 6명이 각각 먹은 점심 메뉴에서 함께 먹은 메뉴들을 알 수 있다.
com <- m %*% t(m)  
com


A <- c('포도 바나나 딸기 맥주 비빔밥 여행 낚시 떡볶이 분홍색 듀크 귤')
B <- c('사과 와인 스테이크 배 포도 여행 등산 짜장면 냉면 삼겹살 파란색 듀크 귤 귤')
C <- c('백숙 바나나 맥주 여행 피자 콜라 햄버거 비빔밥 파란색 듀크 귤')
D <- c('귤 와인 스테이크 배 포도 햄버거 등산 갈비 냉면 삼겹살 녹색 듀크')
data <- c(A,B,C,D)
cps <- VCorpus(VectorSource(data))
tdm <- TermDocumentMatrix(cps, control=list(wordLengths = c(2, Inf)))
inspect(tdm)
(m <- as.matrix(tdm))
(v <- sort(rowSums(m), decreasing=T))

m1 <- as.matrix(weightTf(tdm))
m2 <- as.matrix(weightTfIdf(tdm))
m1;m2

# 텍스트 분석 시각화 : 네트워크 그래프

install.packages("qgraph")
library(qgraph)

qgraph(com, labels=rownames(com), diag=F, 
       layout='spring',  edge.color='blue', 
       vsize=log(diag(com)*800))
# diag : 대각선에 해당하는 값
# vsize : 인덱스 사이즈

library(httr)
library(XML)
library(jsonlite)
library(stringr)
searchUrl<- "https://openapi.naver.com/v1/search/blog.json"
Client_ID <- ""
Client_Secret <- ""

query <- URLencode(iconv("텍스트 분석","euc-kr","UTF-8")) ; 
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))
json_data <- content(doc, type = 'text', encoding = "UTF-8")
json_obj <- fromJSON(json_data)
class(json_obj)
df <- data.frame(json_obj)
#View(df)
text <- df$items.description
text <- gsub("</?b>", "", text) 
text <- gsub("&.+t;", "", text)
text <- gsub("[[:digit:][:punct:][:lower:][:upper:]]", "", text)
text <- gsub("\\s {2,}", " ", text)
pos <- paste(SimplePos09(text))
(extracted <- str_match_all(pos, '([가-힣]+)/N.?|P'))

myF <- function(d) {
  word <- d[,2]
  word <- word[!is.na(word)]
  return(paste(word, collapse = " "))
}

keyword <- sapply(extracted, myF)
keyword <- sapply(keyword, function(d) return(paste(d)))
keyword <- unlist(keyword)
keyword <- keyword[!is.na(keyword)]
is.na(keyword)
pos[100]
extracted[100]

corpus <- VCorpus(VectorSource(keyword))
stopWord <- c("텍스트", "분석")
tdm <- TermDocumentMatrix(corpus, control=list(stopwords=stopWord, wordLengths=c(2, Inf)))
(tdm.matrix <- as.matrix(tdm))

word.count <- rowSums(tdm.matrix)
word.order <- order(word.count, decreasing=TRUE)
freq.words <- tdm.matrix[word.order[1:30], ]

co.matrix <- freq.words %*% t(freq.words)

qgraph(co.matrix, labels=rownames(co.matrix),
       diag=FALSE, layout='spring', threshold=1,
       vsize=log(diag(co.matrix)) * 3)


install.packages("SnowballC")
library(SnowballC)
library(rvest)
library(XML)
html.parsed <- htmlParse("data/TextofSteveJobs.html")
text <- xpathSApply(html.parsed, path="//p", xmlValue)
text

text <- text[4:30]
text
docs <- VCorpus(VectorSource(text))
docs


toSpace <- content_transformer(function(x, pattern){return(gsub(pattern, " ", x))})
docs <- tm_map(docs, toSpace, ":")
docs <- tm_map(docs, toSpace, ";")
docs <- tm_map(docs, toSpace, "'")

docs[[17]]
docs[[19]]
docs[[17]]$content
docs[[19]]$content

docs <- tm_map(docs, removePunctuation)
text[17]
docs[[17]]$content


docs <- tm_map(docs, content_transformer(tolower))
docs[[17]]$content
docs <- tm_map(docs, removeNumbers)
docs[[17]]$content
docs <- tm_map(docs, removeWords, stopwords("english"))
docs[[17]]$content
docs <- tm_map(docs, stripWhitespace)
docs[[17]]$content
docs <- tm_map(docs, stemDocument)
docs[[17]]$content

tdm <- TermDocumentMatrix(docs)
tdm

inspect(tdm[50:60, 1:5])

termFreq <- rowSums(as.matrix(tdm))
head(termFreq)
termFreq[head(order(termFreq, decreasing=T))]

# 텍스트 분석 시각화 : 바 그래프
barplot(termFreq[termFreq >= 7], 
        horiz=T, las=1, cex.names=0.8, 
        col=rainbow(16), xlab="word Frequency", ylab="Words")



# 문서(문장)의 유사도 분석

install.packages("proxy")
library(proxy)
dd <- NULL
d1 <- c("aaa bbb ccc")
d2 <- c("aaa bbb ddd")
d3 <- c("aaa bbb ccc")
d4 <- c("xxx yyy zzz")
dd <- c(d1, d2, d3, d4)
cps <- VCorpus(VectorSource(dd))
dtm <- DocumentTermMatrix(cps)
as.matrix(dtm)
inspect(dtm)
m <- as.matrix(dtm)
com <- m %*% t(m)
com
dist(com, method = "cosine")
dist(com, method = "Euclidean")

?dist

?DocumentTermMatrix

?stopwords
stopwords()


# tm 패키지를 활용한 숫자, 특수문자, 불용어 삭제하기

mystopwords <- readLines("data/stopwords_ko.txt", encoding="UTF-8")
text <- readLines("data/stopwords_testdata.txt", encoding="UTF-8")
docs <- VCorpus(VectorSource(text))
inspect(docs)
docs <- tm_map(docs, removeNumbers)
inspect(docs)
docs <- tm_map(docs, removePunctuation)
inspect(docs)
docs <- tm_map(docs, removeWords, mystopwords)
inspect(docs)
docs[[6]]$content

docs2 <- VCorpus(VectorSource(text))
tdm1 <- TermDocumentMatrix(docs2, control=list(wordLengths = c(1, Inf)))
as.matrix(tdm1)
tdm2 <- TermDocumentMatrix(docs2, control=list(
  removePunctuation = T, 
  removeNumbers = T,
  wordLengths = c(1, Inf),
  stopwords=mystopwords))
as.matrix(tdm2)

# 한국어 불용어
# https://www.rdocumentation.org/packages/stopwords/versions/2.2

install.packages("stopwords")

stopwords::stopwords_getsources()
stopwords::stopwords_getlanguages("marimo")
head(stopwords::stopwords("ko", source = "marimo"), 100)

