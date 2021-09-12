# 문제 1
v1 <- c('Happy', 'Birthday', 'to', 'You')
# 벡터의 길이
length(v1)
# 각 원소들의 문자 개수
nchar(v1)
# 모든 문자들의 합
sum(nchar(v1))


# 문제 2
v2 <- paste(v1, collapse = " "); v2
length(v2)
nchar(v2)


# 문제 3
paste(LETTERS[1:10], 1:10)
paste0(LETTERS[1:10], 1:10)


# 문제 4
a <- unlist(strsplit("Good Morning", split = " "))
list(a[1], a[2])


# 문제 5
text <- c("Yesterday is history, tomorrow is a mystery, today is a gift!", 
          "That's why we call it the present - from kung fu Panda")
text <- gsub("[,-]", "", text)
strsplit(gsub("  ", " ", text), split = " ")


# 문제 6
s1 <- "@^^@Have a nice day!! 좋은 하루!! 오늘도 100점 하루...."
r1 <- gsub("[가-힣]", "", s1); r1
r2 <- gsub("[[:punct:]]", "", s1); r2
r3 <- gsub("[[:punct:]]", "", r1); r3 # 정규표현식이랑 [가-힣]랑 같이 사용 못함
#r3 <- gsub("[가-힣]|[@^!.]", "", s1)
r4 <- gsub("100", "백", s1); r4


# 문제 7-제외
library(KoNLP)
word_data <- readLines("data/hotel.txt")
word_data1 <- extractNoun(word_data)

table()
sort(x, decreasing = T)
head()


# 문제 8
weekdays(as.POSIXct("2021-10-02"))
weekdays(as.POSIXlt("2021-10-02"))
weekdays(as.Date("2021-10-02"))


# 문제 9
file <- readLines("data/product_click.log")
date <- as.Date(substr(file, 1, 8),format='%Y%m%d')
weekday_table <- sort(table(weekdays(date)), decreasing = T)
#weekday_table[1]
cat("클릭수가 가장 많은 요일은", names(weekday_table)[1], "입니다.")

# case 2
log <- readLines("data/product_click.log")
date <- substr(log, 1, 8)
date <- as.Date(date,format='%Y%m%d')
weekdays <- weekdays(as.POSIXlt(date))
weekdays <- table(weekdays)
kr_weekdays <- c("금", "월", "토", "목", "화", "수")
cat("클릭수가 가장 많은 요일은 ", kr_weekdays[which.max(weekdays)], "요일 입니다", sep="")
cat("클릭수가 가장 많은 요일은 ", names(sort(weekdays, decreasing = T)[1]), "입니다", sep="")




