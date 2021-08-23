v1 <- 10:14
v2 <-c(5,3,1,10,4)
print(v1)
v2


# R 공부를 열심히 하자
v1 <- 1:10
v1 = 1:10
1:10 -> v1
print(v1)
v1
1:100
100:1
v2 <- v1 + 100; v2
v3 <- v1 * 10; v3
(v2 <- v1 + 100)
ls()
v4 <- c(10, 5, 7, 4, 15, 1)
v5 <- c(100, 200, 300, '사백')
seq(1, 10)
seq(1, 10, 2)
seq(0, 100, 5)

rep(1, 100)
rep(1:3, 5)
rep(1:3, times=5) # 키워드 파라미터
rep(1:3, each=5)
?rep  #help()

LETTERS
letters
month.name
month.abb
pi

LETTERS;letters;month.name;month.abb;pi

LETTERS[1]; LETTERS[c(3,4,5)]
LETTERS[3:5]; LETTERS[5:3]
LETTERS[-1]; LETTERS[c(-2,-4)]

length(LETTERS)
length(month.name)
length(pi)


x <- c(10,2,7,4,15)
x
print(x)
class(x)
rev(x)
range(x)
sort(x)
sort(x, decreasing = TRUE)
sort(x, decreasing = T)
#x <- sort(x)
order(x)



x[3] <- 20
x
x + 1
x <- x + 1
max(x);min(x);mean(x);sum(x)
summary(x)