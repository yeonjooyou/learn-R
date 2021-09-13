# 문제7
library(KoNLP)
file <- read.csv("output/movie_reviews3.csv")

content <- gsub("[[:punct:]]", "", file$vreview)
content <- gsub("[0-9A-Za-zㄱ-ㅎㅏ-ㅣ]", "", content)

word_data <- extractNoun(content)
#word_data

undata <- unlist(word_data)
undata <- Filter(function(x) {nchar(x) >= 2}, undata)
#wname
data_table <- head(sort(table(undata), decreasing=T), 10)

word_df <- data.frame(data_table)
names(word_df) <- c("wname", "wcount")
word_df

write.csv(word_df, file="output/movie_top_word.csv",row.names = TRUE)

# case 2
movie <- read.csv("./output/movie_reviews3.csv")
head(movie)
movie <- movie$vreview
movie[135]
movie <- gsub("[[:digit:][:punct:][:cntrl:]]", "", movie)
movie[135]
movie <- gsub("[A-zㄱ-ㅎㅏ-ㅣ]", "", movie)
movie[135]
movie <- gsub("(고만하자){2,}", "", movie)
movie <- movie[nchar(movie) > 0]
movie_word <- extractNoun(movie)
movie_word <- unlist(movie_word)
movie_word <- Filter(function(x) {nchar(x) >= 2}, movie_word)
movie_word <- table(movie_word) 
movie_top_word <- head(sort(movie_word, decreasing=T),10)
movie_top_word <- data.frame(movie_top_word)
write.csv(movie_top_word, file = "movie_top_word.csv")

# case 3
review <- read.csv("output/movie_reviews3.csv")
review <- review[,"vreview"]
word_data <- gsub("[[:punct:][:cntrl:][:digit:]]|[A-Za-zㄱ-ㅎㅏ-ㅣ]", "", review)
word_data <- gsub(" ( )+", " ", word_data)

# word_data[624]; 길이가 너무 길면 extractNoun을 할 수 없습니다.
word_data <- strsplit(word_data, split = " ")
word_data <- unlist(word_data)
word_data <- Filter(function(x) {nchar(x) < 10}, word_data)

words <- extractNoun(word_data)
undata <- unlist(words)
undata <- Filter(function(x) {nchar(x) >= 2}, undata)

top <- sort(table(undata), decreasing = T)[1:10]
top <- as.data.frame(top)
colnames(top) <- c("wname", "wcount")
top
write.csv(top, "output/movie_top_word.csv", row.names = F)




# 문제8
library(wordcloud2)
yes24 <- readLines("output/yes24.txt")


# (2) 텍스트 전처리 - 한글이 아닌 것은 모두 제거한다.
yes24_data <- gsub("[^가-힣]", "", yes24)

# (1) yes24.txt 파일을 읽고 명사만을 추출한다.
word <- extractNoun(yes24)
#word

# (3) 단어의 길이가 2자이상이고 4자 이하인 단어만을 필터링한다.
data <- unlist(word)
fdata <- Filter(function(x) {nchar(x) <= 4 & nchar(x) >= 2}, data)

# (4) 각 단어의 개수를 센다.
wordcount <- table(fdata)

# (5) 많은 순으로 정렬한다.
wordsort <- sort(wordcount, decreasing=T)

# (6) 데이터프레임으로 만든다.
worddf <- data.frame(wordsort)

# (7) 워드크라우드2로 시각화한다. 
result <- wordcloud2(worddf, fontFamily = "THE개이득", size=0.5,
                     color="random-dark")
result

# (8) 시각화 한 것을 htmltools::save_html () 함수를 사용하여 yes24.html 로 저장한다.
htmltools::save_html(result,"output/yes24.html")


# case 2
library(wordcloud2)
yes24 <- readLines("./output/yes24.txt")
yes24_word <- extractNoun(yes24)
yes24_word <- unlist(yes24_word)
yes24_word <- gsub("[^가-힣]","",yes24_word)
yes24_word <- Filter(function(x) {nchar(x) >= 2 & nchar(x) <=4}, yes24_word)
yes24_word <- table(yes24_word)
yes24_word <- sort(yes24_word, decreasing=T)
yes24_word <- data.frame(yes24_word)
result <- wordcloud2(data = yes24_word, shape = 'diamond')
htmltools::save_html(result,"output/yes24_1.html")

# case 3
yes24 <- readLines("data/yes24.txt")
yes24 <- extractNoun(gsub("[^가-힣[:space:]]","", yes24))
yes24 <- Filter(function(x) {nchar(x) >= 2 && nchar(x) <= 4}, unlist(yes24))
tb<-sort(table(yes24), decreasing = T)
dfyes24<-wordcloud2(data.frame(tb))
htmltools::save_html(dfyes24,"output/yes24_2.html")


