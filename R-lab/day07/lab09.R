# 다음뉴스 랭킹페이지에서 뉴스 정보 추출(뉴스의 제목, 신문사명)
site<- "http://media.daum.net/ranking/popular/"
itnews <- NULL
for (i in 1:50) {
  nodes <- NULL
  doc <- read_html(site, encoding="UTF-8")
  
  # 뉴스 제목
  node <- html_node(doc, paste0("#mArticle > div.rank_news > ul.list_news2 > li:nth-child(", i, ") > div.cont_thumb > strong > a"))
  newstitle <- html_text(node)
  
  # 신문사명
  node <- html_node(doc, paste0("#mArticle > div.rank_news > ul.list_news2 > li:nth-child(", i, ") > div.cont_thumb > strong > span"))
  newspapername <- html_text(node)
  
  page <- data.frame(newstitle, newspapername)
  itnews <- rbind(itnews, page)
}
#View(itnews)
write.csv(itnews, "output/daumnews.csv") # fileEncoding = "UTF-8"



# case 1
text <- NULL; title <- NULL; newstitle <- NULL; newspapername <- NULL

url <- "https://news.daum.net/ranking/popular/"
text <- read_html(url)

for (index in 1:50){
  node <- html_node(text, paste0("#mArticle > div.rank_news > ul.list_news2 > li:nth-child(",index,") > div.cont_thumb > strong > a"))
  title <- html_text(node)
  newstitle[index] <- title
  
  node <- html_node(text, paste0("#mArticle > div.rank_news > ul.list_news2 > li:nth-child(",index,") > div.cont_thumb > strong > span"))
  title <- html_text(node)
  newspapername[index] <- title
} 
news <- data.frame(newstitle, newspapername)
write.csv(news, "output/daumnews1.csv")

# case 2
site <- "https://news.daum.net/ranking/popular"
url <- read_html(site)
newstitle <- html_text(html_nodes(url, "#mArticle > div.rank_news > ul.list_news2> li > div.cont_thumb > strong > a"))
newspapername <- html_text(html_nodes(url, "#mArticle > div.rank_news > ul.list_news2 > li > div.cont_thumb > strong > span"))
daum_news <- data.frame(newstitle,newspapername)
#View(daum_news)
write.csv(daum_news, "output/daumnews2.csv", fileEncoding = "utf8")


# case 3
url <- read_html("http://media.daum.net/ranking/popular/")

newstitle <- html_text(html_nodes(url, "ul.list_news2 a.link_txt"))
#newstitle
newspapername <- html_text(html_nodes(url, ".cont_thumb span.info_news"))
#newspapername

daumnews <- data.frame(newstitle,newspapername)
#View(daumnews)
write.csv(daumnews, "output/daumnews3.csv", fileEncoding = "UTF-8")

# case 4
htxt <- read_html("http://media.daum.net/ranking/popular/")
text <- html_nodes(htxt, 'ul.list_news2')
newstitle <- html_text(html_nodes(text, "[class$=tit_thumb] > a"))
newspapername <- html_text(html_nodes(text, "[class$=info_news]"))
mynews <- data.frame(newstitle,newspapername)
View(mynews)
write.csv(mynews,file="output/daumnews4.csv",row.names = TRUE)

