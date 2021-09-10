# 메가박스 웹 사이트에 올려진 모가디슈라는 영화의 실관람평 페이지의 정보를 추출하는 기능
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4445, browserName = "chrome")
remDr$open()

remDr$navigate("https://www.megabox.co.kr/movie-detail/comment?rpstMovieNo=21049700")
score <- remDr$findElements(using = 'css selector', 'div.story-area > div.story-box > div > div.story-cont > div.story-point > span')
score2 <- sapply(score, function(x){x$getElementText()})
genre <- remDr$findElements(using = 'css selector', 'div.story-area > div.story-box > div > div.story-cont > div.story-recommend')
genre2 <- sapply(genre, function(x){x$getElementText()})
review <- remDr$findElements(using = 'css selector', 'div.story-area > div.story-box > div > div.story-cont > div.story-txt')
review2 <- sapply(review, function(x){x$getElementText()})

#text <- data.frame(score=score_v, genre=genre_v, review=review_v)
text <- data.frame(score=unlist(score2), genre=unlist(genre2), review=unlist(review2))
#View(text)

for (i in 2:10) {
  nextCss <- paste("#contentData > div > div.movie-idv-story > nav > a:nth-child(",i,")", sep="")                
  #Sys.sleep(1)
  try(nextListLink<-remDr$findElement(using='css selector',nextCss))
  if(length(nextListLink) == 0)   break;
  nextListLink$clickElement()
  Sys.sleep(1)
  # 해당 페이지 내용 읽어오기
  score <- remDr$findElements(using = 'css selector', 'div.story-area > div.story-box > div > div.story-cont > div.story-point > span')
  score2 <- sapply(score, function(x){x$getElementText()})
  genre <- remDr$findElements(using = 'css selector', 'div.story-area > div.story-box > div > div.story-cont > div.story-recommend')
  genre2 <- sapply(genre, function(x){x$getElementText()})
  review <- remDr$findElements(using = 'css selector', 'div.story-area > div.story-box > div > div.story-cont > div.story-txt')
  review2 <- sapply(review, function(x){x$getElementText()})
  
  text1 <- data.frame(score=unlist(score2), genre=unlist(genre2), review=unlist(review2))
  text <- rbind(text, text1)
}
View(text)

write.csv(text, "output/movie.csv")



