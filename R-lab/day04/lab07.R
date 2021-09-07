# 문제1
countEvenOdd <- function(nums){
  even <- 0
  odd <- 0
  for(n in nums){
    ifelse(n %% 2 == 0, even <- even + 1, odd <- odd + 1)
  }
  return(list(even=even, odd=odd))
}
# case2
countEvenOdd <- function(x){
  even <- 0
  odd <- 0
  if(is.vector(x) && !is.list(x) && is.numeric(x)){
    for(i in x){
      if(i%%2 == 0){
        even <- even+1
      }else{
        odd <- odd+1
      }
    }
    return(list(even=even, odd=odd))
  }else{
    return()
  }
}

countEvenOdd(c(2,3,4,5,6))
countEvenOdd(1:15)
countEvenOdd(matrix(1:9))
countEvenOdd(list(10,20))
countEvenOdd(LETTERS)

# 문제2
vmSum <- function(x){
  sum <- 0
  if(is.vector(x)){
    if(is.numeric(x)){
      sum <- sum(x)
    }
    else{
      print("숫자 벡터를 전달하숑!")
    }
  }
  else{
    print("벡터만 전달하숑!")
  }
  return(sum)
}
# case2 -> 벡터처리
vmSum <- function(x){
  result <- NULL
  if(is.vector(x) && !is.list(x) && is.numeric(x)){
    result <- sum(x)
  }else if(is.list(x)){
    return("벡터만 전달하숑!")
  }else{
    cat("숫자 벡터를 전달하숑!\n")
    return(0)
  }
  return(result)
}
# case3
vmSum <- function(x){
  if(!is.vector(x) || is.list(x)){
    return("벡터만 전달하숑!")
  }else if(!is.numeric(x)){
    cat("숫자 벡터를 전달하숑!\n")
    return(0)
  }else{
    return(sum(X))
  }
}

vmSum(matrix(1,2,3))
vmSum("1")
vmSum(c("1",2,NA))
vmSum(c(1,2,3,4,5))

# 문제3
vmSum2 <- function(x){
  sum <- 0
  if(is.vector(x)){
    if(is.numeric(x)){
      sum <- sum(x)
    }else{
      warning("숫자 벡터를 전달하숑!")
    }
  }else{
    stop("벡터만 전달하숑!")
  }
  return(sum)
}
# case2
vmSum2 <- function(x){
  if(!is.vector(x) || is.list(X)){
    stop("벡터만 전달하숑!")
  }else if(!is.numeric(x)){
    warning("숫자 벡터를 전달하숑!\n")
    return(0)
  }else{
    return(sum(x))
  }
}

vmSum2(matrix(1,2,3))
vmSum2("1")
vmSum2(c("1",2,NA))
vmSum2(c(1,2,3,4,5))

# 문제4
mySum <- function(nums){
  if(is.null(nums)){
    return()
  }else if(is.vector(nums)){
    evenSum <- 0
    oddSum <- 0
    for(i in 1:length(nums)){
      if(i%%2 == 0){
        if(is.na(nums[i])){
          evenSum <- evenSum + min(nums, na.rm=T)
          warning("NA를 최저값으로 변경하여 처리함!!")
        }else{
          evenSum <- evenSum + nums[i]
        }
      }else{
        if(is.na(nums[i])){
          oddSum <- oddSum + min(nums, na.rm=T)
          warning("NA를 최저값으로 변경하여 처리함!!")
        }else{
          oddSum <- oddSum + nums[i]
        }
      }
    }
    return(list(evenSum=evenSum, oddSum=oddSum))
  }else{
    stop("벡터만 처리 가능!!")
  }
}
# case2
mySum <- function(v){
  if(is.null(v)){
    return()
  }else if(is.vector(v) && !is.list(v)){
    if(any(is.na(V))){
      warning("NA값을 최저값으로 변경하여 처리함!!")
      v[is.na(v)] <- min(v, na.rm = T)
    }
    evenSum <- 0
    oddSum <- 0
    for(d in v){
      if(d %% 2 == 0){
        evenSum <- evenSum + d
      }else{
        oddSum <- oddSum + d
      }
    }
    return(list(evenSum=evenSum, oddSum=oddSum))
  }else{
    stop("벡터만 처리 가능!!")
  }
}
# case3 - na.omit() 함수 사용

mySum(matrix(1,2,3))
mySum(c(1,2,NA,4,5,NA))
mySum(c(1,2,3,4,5))
mySum(NULL)

# 문제5
myExpr <- function(func){
  if(!is.function(func)){
    stop("수행 안할꺼임!!")
  }
  else{
    lotto <- sample(1:45, 6, replace = FALSE)
    return(lotto)
    # return(func(sample(1:45, 6, replace=F)))
  }
}
myExpr(list())
myExpr(exam1)
myExpr(myExpr)

# 문제6
createVector1 <- function(...){
  new_vector1 <- c(...)
  if(is.null(new_vector1)){
    return()
  }else if(any(is.na(new_vecto1r))){
    return(NA)
  }else{
    return(new_vector1)
  }
}
# case2
createVector1 <- function(...){
  vec <- c(...)
  if(!length(vec)){
    return()
  }else if(any(is.na(vec))){
    return(NA)
  }else{
    return(vec)
  }
}

createVector1(1,2,3)
createVector1(1,2,3,"a","b","c")
createVector1(1,2,3,TRUE)
createVector1(1,2,NA,"a","b","c")
createVector1()

# 문제7
createVector2 <- function(...){
  new_vector2 <- c(...)
  if(is.null(new_vector2)){
    return()
  }else{
    data <- list(...)
    num <- c()
    char <- c()
    vec <- c()
    for(d in data){
      if(is.numeric(d)){
        num <- append(num, d)
      }else if(is.character(d)){
        char <- append(char, d)
      }else if(is.vector(d)){
        vec <- append(vec, d)
      }
    }
    return(list(numeric=num, character=char, vector=vec))
  }
}

createVector2()
createVector2(1,2,3)
createVector2(1,2,3,"a","b","c",1)
createVector2(1,2,NA,"a",3)


# case2
createVector2 <- function(...){
  lst <- list(...)
  num <- c()
  char <- c()
  logic <- c()
  if (!length(lst)){
    return()
  }else{
    for (i in lst){
      if (is.numeric(i)){
        num[length(num)+1] <- i
      }else if (is.character(i)){
        char[length(char)+1] <- i
      }else{
        logic[length(logic)+1] <- i
      }
    }
    return(list(num, char, logic))
  }
}

createVector2()
createVector2(1, 2, 3, 4, 5, "a", "b", TRUE, FALSE)
createVector2(1, "a", 3, 4, 5, "b", TRUE, 2, FALSE)

# case3
createVector2 <- function(...){
  lst <- list(...)
  num <- c()
  char <- c()
  logic <- c()
  if (!length(lst)){
    return()
  }else{
    for (i in lst){
      if (is.numeric(i)){
        num <- c(num, i)
      }else if (is.character(i)){
        char <- c(char, i)
      }else{
        logic <- c(logic, i)
      }
    }
    return(list(num, char, logic))
  }
}

createVector2()
createVector2(1, 2, 3, 4, 5, "a", "b", TRUE, FALSE)

# case4
createVector2 <- function(...){
  lst <- list(...)
  num <- c()
  char <- c()
  logic <- c()
  if (!length(lst)){
    return()
  }else{
    for (i in lst){
      if (is.numeric(i)){
        num <- append(num, i)
      }else if (is.character(i)){
        char <- append(char, i)
      }else{
        logic <- append(logic, i)
      }
    }
    return(list(num, char, logic))
  }
}

createVector2()
createVector2(1, 2, 3, 4, 5, "a", "b", TRUE, FALSE)



