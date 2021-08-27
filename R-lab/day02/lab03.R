# 문제1
str(iris)

# 문제2
x <- 1:5
y <- seq(2, 10, 2)
df1 <- data.frame(x, y); df1

# 문제3
df2 <- data.frame(col1 = 1:5,
                  col2 = letters[1:5],
                  col3 = 6:10); df2

# 문제4
df3 <- data.frame(제품명 = c('사과', '딸기', '수박'),
                     가격 = c(1800, 1500, 3000),
                     판매량 = c(24, 38, 13),
                     stringsAsFactors=F); df3
str(df3)

#문제5
mean(df3$가격)
mean(df3$판매량)

# 문제6
name <- c("Potter", "Elsa", "Gates", "Wendy", "Ben")
gender <- factor(c("M", "F", "M", "F", "M"))
math <- c(85, 76, 99, 88, 40)
df4 <- data.frame(name, gender, math); str(df4)
View(df4)
# (a)
df4$stat <- c(76, 73, 95, 82, 35)
# (b)
df4$score <- df4$math + df4$stat
# (c)
df4$grade <- ifelse(df4$score >= 150, 'A',
                    ifelse(df4$score >= 100, 'B',
                           ifelse(df4$score >= 70, 'C', 'D')))

# 문제7
myemp <- read.csv("data/emp.csv") # 상대경로
# myemp <- read.csv("c:/yyj/Rexam/data/emp.csv") # 절대경로
str(myemp)

# 문제8
myemp[3:5,]

# 문제9
myemp[,-4]

# 문제10
myemp$ename
# case2~3
myemp[,"ename"]
myemp["ename"]

# 문제11
data.frame(myemp$ename, myemp$sal)
# case2
myemp[,c("ename","sal")]

# 문제12
subset(myemp, job == 'SALESMAN', c("ename","sal","job"))
# case2
myemp[myemp$job=="SALESMAN", c("ename", "sal", "job")]

# 문제13
subset(myemp, sal >= 1000 & sal <= 3000, c("ename","sal","deptno"))
# case2
myemp[myemp$sal>=1000 & myemp$sal <=3000, c("ename", "sal", "deptno")]

# 문제14
subset(myemp, job != 'ANALYST', c("ename","job","sal"))
# case2
myemp[myemp$job != "ANALYST", c("ename","job", "sal")]

# 문제15
subset(myemp, job == 'SALESMAN' | job == 'ANALYST', c("ename","job"))
# case2
myemp[myemp$job == "ANALYST" | myemp$job == "SALESMAN", c("ename", "job")]

# 문제16
subset(myemp, is.na(myemp$comm), c("ename", "sal"))
# case2
myemp[is.na(myemp$comm), c("ename", "sal")]

# 문제17
myemp[order(myemp$sal),]

# 문제18
nrow(myemp); ncol(myemp)
# case2
dim(myemp)

# 문제19
data.frame(table(myemp$deptno))
# case2
summary(as.factor(myemp$deptno))
table(myemp$deptno)

# 문제20
data.frame(table(myemp$job))
# case2
summary(as.factor(myemp$job))
table(myemp$job)

