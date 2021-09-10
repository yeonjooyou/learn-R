# case1
(v <- sample(1:26,10))
sapply(v, function(x) return(LETTERS[x]))

# case2
(v <- sample(1:26,10))
convert <- function(x){
  char <- LETTERS[x]
  return(char)
  #사용자 정의 함수 생성 시, 가급적이면 명시적으로 return()을 사용할 것  
}
sapply(v, convert)

