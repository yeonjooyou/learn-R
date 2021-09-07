# 함수의 정의와 활용
# 문제1
exam1 <- function(){
  (alpha <- paste0(LETTERS, letters))
  return(alpha)
}
exam1()

# 문제2
exam2 <- function(num){
  sum <- 0
  for(n in 1:num){
    sum <- sum + n
  }
  return(sum)
}
cat("함수 호출 결과 :", exam2(10))

# 문제3
exam3 <- function(x,y){
  result <- ifelse(x>=y, x-y, y-x)
  return(result)
}
# case2
exam3 <- function(n1, n2){
  diff <- abs(n1-n2)
  return(diff)
}
print(paste("함수 호출 결과 :", exam3(10,20)))
print(paste("함수 호출 결과 :", exam3(20,5)))
print(paste("함수 호출 결과 :", exam3(5,30)))
print(paste("함수 호출 결과 :", exam3(6,3)))
print(paste("함수 호출 결과 :", exam3(3,3)))

# 문제4
exam4 <- function(x, op, y){
  if(op == '+'){
    result <- x+y
  }else if(op == '-'){
    result <- x-y
  }else if(op == '*'){
    result <- x*y
  }else if(op == '%/%'|op == '%%'){
    if(x == 0){
      result <- "오류1"
    }
    else if(y == 0){
      result <- "오류2"
    }
    else{
      result <- ifelse(op == '%/%', x%/%y, x%%y)
    }
  }else{
    result <- "규격의 연산자만 전달하세요"
  }
  return(result)
}
# case2
exam4 <- function(n1, op, n2){
  if(op == "%/%" || op == "%%"){
    if(n1 == 0){
      return("오류1")
    }else if(n2 == 0){
      return("오류2")
    }else{
      return(switch(EXPR=op, "%/%"=n1%/%n2, "%%"=n1%%n2))
    }
  }else if(op == "+" || op == "-" || op == "*"){
    return(switch(EXPR=op, "+"=n1+n2, "-"=n1-n2, "*"=n1*n2))
  }else{
    return("규격의 연산자만 전달하세요")
  }
}
# case3
exam4 <- function(n1, op, n2){
  if(op %in% c("+","-","*","%/%","%%")){
    if(op == "%/%" || op == "%%"){
      if(n1 == 0){
        return("오류1")
      }else if(n2 == 0){
        return("오류2")
      }else{
        return(switch(EXPR=op, "%/%"=n1%/%n2, "%%"=n1%%n2))
      }
    }else{
      return(switch(EXPR=op, "+"=n1+n2, "-"=n1-n2, "*"=n1*n2))
    }
  }else{
      return("규격의 연산자만 전달하세요")
    }
}
exam4(6, '+', 4)
exam4(6, '-', 4)
exam4(6, '*', 4)
exam4(6, '%/%', 4)
exam4(6, '%%', 4)
exam4(0, '%/%', 4)
exam4(6, '%%', 0)
exam4(6, '$', 4)

# 문제5
exam5 <- function(num, deco="#"){
  if(num >= 0){
    for(n in 1:num){
      cat(deco)
    }
  }
  return()
}
exam5(-5)
exam5(5)
exam5(5, "$")

# 문제6
exam6 <- function(score){
  for(i in score){
    if(is.na(i)){
      cat("NA는 처리불가\n")
    }else if(85 <= i){
      cat(i, "점은 상등급입니다.\n")
    }else if(70 <= i){
      cat(i, "점은 중등급입니다.\n")
    }else if(0 <= i){
      cat(i, "점은 하등급입니다.\n")
    }
  }
  return()
}
exam6(c(80, 50, 70, 66, NA, 35))


