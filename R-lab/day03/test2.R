iotest2 <- scan("data/iotest2.txt", what="")
iotest2_df <- data.frame(table(iotest2))
max_word <- iotest2_df[which.max(iotest2_df$iotest2),]
cat("가장 많이 등장한 단어는 ", as.character(max_word$iotest2), "입니다.", sep="")

# case2
text <- scan("data/iotest2.txt",what="")
sort(table(text), decreasing = T)[1]
cat("가장 많이 등장한 단어는", names(sort(table(text), decreasing = T)[1]) ,"입니다.\n")

# case3
iotest2<- scan("data/iotest2.txt", what="",encoding="UTF-8")
iotest2 <- table(iotest2);iotest2
name <- names(iotest2[which.max(iotest2)])
cat("가장 많이 등장한 단어는", name, "입니다.")