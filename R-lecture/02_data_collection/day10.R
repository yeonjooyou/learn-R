library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , 
                      port = 4445, browserName = "chrome")
remDr$open()
# [ 네이버 북 페이지 이번주 베스트북정보 크롤링 ]

site <- "https://book.naver.com/"
remDr$navigate(site)

#bestseller_tab

booksitenodes <- remDr$findElements(using='css selector', '#bestseller_tab > ul.tab_cp_spt > li > a')
# 7개의 <a>태그에 대해 class 속성 값을 꺼냄
booksites <- sapply(booksitenodes, function(x) {x$getElementAttribute("class")})
booksites <- unlist(booksites) # unlist : 벡터로 만들기
booksites <- unlist(strsplit(booksites, ' ')) # strsplit() : 앞부분만 꺼내기
size <- length(booksites)
booksites <- booksites[seq(1, size, 2)]

for (booksite in booksites) {
  booksitenode <- remDr$findElement(using='css selector', paste0('#tab_cp_spt_',booksite))
  booksitenode$clickElement()
  Sys.sleep(2)
  # 썸네일 이미지 URL
  bookthumbenodes <- remDr$findElements(using='css selector', '#bestseller_list dl>dt:nth-child(1) img')
  bookthumburl <- sapply(bookthumbenodes, function(x) {x$getElementAttribute("src")}) # 특정 속성의 값을 꺼낼 때 :getElementAttribute()
  bookthumburl <- unlist(bookthumburl)
  # 책이름
  booktitlenodes <- remDr$findElements(using='css selector', '#bestseller_list dl>dt:nth-child(2)>a')
  booktitle <- sapply(booktitlenodes, function(x) {x$getElementText()})
  booktitle <- gsub("[[:cntrl:]]", "", booktitle)
  
  df <- data.frame(bookthumburl, booktitle)
  # 새로운 디렉터리 만들기
  if (!dir.exists('output/book')) 
    dir.create('output/book')
  print(df)
  write.csv(df, file=paste0('output/book/', booksite, '.csv'))
}

# [ gs25 1+1 상품 정보 수집 ]

site <- 'http://gs25.gsretail.com/gscvs/ko/products/event-goods'
remDr$navigate(site)

# 상품 이름
eventgoodsnodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(3) > ul > li > div > p.tit')
eventgoodsname <- sapply(eventgoodsnodes, function(x) {x$getElementText()})
# 상품 가격
eventgoodsnodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(3) > ul > li > div > p.price > span')
eventgoodsprice <- sapply(eventgoodsnodes, function(x) {x$getElementText()})

data.frame(egn = unlist(eventgoodsname), egp = unlist(eventgoodsprice))


# [ YES24의 명견만리 댓글 읽어오기 ] : scroll down 이벤트 처리 -> JavaScript 이용 / fullContent -> 펼쳐보기

library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4445, browserName = "chrome")
remDr$open()
remDr$navigate("http://www.yes24.com/24/goods/40936880")


webElem <- remDr$findElement("css selector", "body")
remDr$executeScript("scrollTo(0, 0)", args = list(webElem)) # scrollTo(0, 0) :최상위 위치 반환
Sys.sleep(1)
remDr$executeScript("scrollBy(0, 3200)", args = list(webElem)) # scrollBy(x축, y축) : px단위
Sys.sleep(1)
remDr$executeScript("scrollBy(0, 3200)", args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0, 3200)", args = list(webElem))
Sys.sleep(3)
repl_v = NULL
endFlag <- FALSE
page <- 3

repeat {
  for(index in 3:7) {
    fullContentLinkcss <- paste("#infoset_reviewContentList > div:nth-child(",index,") > div.reviewInfoBot.crop > a", sep='')
    fullContentLink<-remDr$findElements(using='css selector',  fullContentLinkcss)
    if (length(fullContentLink) == 0) {
      cat("종료\n")
      endFlag <- TRUE
      break
    }
    remDr$executeScript("arguments[0].click();",fullContentLink);
    Sys.sleep(1)
    fullContentcss <- paste("#infoset_reviewContentList > div:nth-child(",index,") > div.reviewInfoBot.origin > div.review_cont > p", sep='')
    fullContent<-remDr$findElements(using='css selector', fullContentcss)
    repl <-sapply(fullContent,function(x){x$getElementText()})    
    print(repl)
    cat("---------------------\n")
    repl_v <- c(repl_v, unlist(repl))
  }
  if(endFlag)
    break;  
  
  if(page == 10){
    page <- 3
    nextPagecss <- "#infoset_reviewContentList > div.review_sort.sortTop > div.review_sortLft > div > a.bgYUI.next"
  }
  else{
    page <- page+1;
    nextPagecss <- paste("#infoset_reviewContentList > div.review_sort.sortBot > div.review_sortLft > div > a:nth-child(",page,")",sep="")
  }
  remDr$executeScript("scrollTo(0, 0)", args = list(webElem))
  nextPageLink<-remDr$findElements(using='css selector',nextPagecss) 
  remDr$executeScript("arguments[0].click();",nextPageLink);
  #sapply(nextPageLink,function(x){x$clickElement()})  
  Sys.sleep(3)
  print(page)
}
write(repl_v, "output/yes24.txt")



# [스타벅스 서울 전체 매장 정보 크롤링&스크래핑]

library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
remDr$open()

site <- paste("https://www.istarbucks.co.kr/store/store_map.do?disp=locale")
remDr$navigate(site)

Sys.sleep(3)

#서울 클릭
btn1css <- "#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step1 > div.loca_step1_cont > ul > li:nth-child(1) > a"
btn1Page <- remDr$findElements(using='css selector',btn1css)
sapply(btn1Page,function(x){x$clickElement()})
Sys.sleep(3)

#전체 클릭
btn2css <- "#mCSB_2_container > ul > li:nth-child(1) > a"
btn2Page <- remDr$findElements(using='css selector',btn2css)
sapply(btn2Page,function(x){x$clickElement()})
Sys.sleep(3)

index <- 0
starbucks <- NULL
total <- sapply(remDr$findElements(using='css selector',"#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step3 > div.result_num_wrap > span"),function(x){x$getElementText()})

repeat{
  index <- index + 1
  print(index)
  
  storecss <- paste0("#mCSB_3_container > ul > li:nth-child(",index,")")
  storePage <- remDr$findElements(using='css selector',storecss)
  if(length(storePage) == 0) 
    break
  storeContent <- sapply(storePage,function(x){x$getElementText()})
  
  #스타벅스 정보 추출
  #strsplit(storeContent, split="\n")
  storeList <- strsplit(unlist(storeContent), split="\n")
  shopname <- storeList[[1]][1]
  addr <- storeList[[1]][2]
  addr <- gsub(",", "", addr)
  telephone <- storeList[[1]][3]
  
  #스타벅스 위도 경도 추출
  lat <- sapply(storePage,function(x){x$getElementAttribute("data-lat")})
  lng <- sapply(storePage,function(x){x$getElementAttribute("data-long")})
  
  #병합
  starbucks <- rbind(starbucks ,cbind(shopname, addr, telephone, lat, lng)) # 2차원 형식의 데이터 셋
  
  #스크롤 다운
  if(index %% 3 == 0 && index != total)
    # dom.scrollIntoView() : 해당 DOM 객체에서의 scrollIntoView
    remDr$executeScript("var dom=document.querySelectorAll('#mCSB_3_container > ul > li')[arguments[0]]; dom.scrollIntoView();", list(index))
}
write.csv(starbucks, "output/starbucks.csv")






