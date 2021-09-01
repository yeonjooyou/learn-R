# 제어문
# 문제1
grade <- sample(1:6, 1)
if (grade <= 3){
  cat(grade, "학년은 저학년입니다.", "\n")
}else{
  cat(grade, "학년은 고학년입니다.", "\n")
}
# case2
if (grade == 4 || grade == 5 || grade == 6) {
  cat(grade," 학년은 고학년입니다.","\n")
} else {
  cat(grade," 학년은 저학년입니다.","\n")
}

# 문제2
(choice <- sample(1:5, 1))
if (choice == 1) {
  result <- 300 + 50
}else if (choice == 2){
  result <- 300 - 50
}else if (choice == 3){
  result <- 300 * 50
}else if (choice == 4){
  result <- 300 / 50
}else{
  result <- 300 %% 50
}
cat("결과값 :", result, "\n")

# 문제3
count <- sample(3:10, 1); count
deco <- sample(1:3, 1); deco
if (deco == 1){
  rep("*", count)
}else if (deco == 2){
  rep("$", count)
}else{
  rep("#", count)
}
# case2
(count <- sample(3:10, 1))
(deco <- sample(1:3, 1))
if (deco == 1){
  for (i in 1:count)
    cat("*")
}else if (deco == 2){
  for (i in 1:count)
    cat("$")
}else {
  for (i in 1:count)
    cat("#")
}

# 문제4
score <- sample(0:100, 1)
grade <- ifelse(score >= 90, 1,
                ifelse(score >= 80, 2,
                       ifelse(score >= 70, 3,
                              ifelse(score >= 60, 4, 5))))
level <- switch(EXPR=grade, "A 등급", "B 등급", "C 등급", "D 등급", "F 등급")
cat(score,"점은 ", level, "입니다\n", sep="")
# case2
score <- sample(0:100, 1)
score <- as.character(score) 
level <- switch(EXPR=score,
                "90"=,"91"=,"92"=,"93"=,"94"=,"95"=,"96"=,"97"=,"98"=,"99"=,"100"="A 등급",
                "80"=,"81"=,"82"=,"83"=,"84"=,"85"=,"86"=,"87"=,"88"=,"89"="B 등급",
                "70"=,"71"=,"72"=,"73"=,"74"=,"75"=,"76"=,"77"=,"78"=,"79"="C 등급",
                "60"=,"61"=,"62"=,"63"=,"64"=,"65"=,"66"=,"67"=,"68"=,"69"="D 등급",
                "F 등급")
cat(score, "점은",level, "등급입니다.")
# case3
(score <- sample(0:100, 1))
(sharescore <- score %/% 10)
(sharescore <- as.character(sharescore) )
level <- switch(EXPR=sharescore,
                "9"=,"10"="A 등급",
                "8"="B 등급",
                "7"="C 등급",
                "6"="D 등급",
                "F 등급")
cat(score, "점은",level, "등급입니다.")

# 문제5
for (i in 1:26) {
  cat('"', LETTERS[i], letters[i],'"', sep="")
}
# case2
(alpha <- paste0(LETTERS, letters))

