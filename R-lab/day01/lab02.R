# 문제1
v1 <- sample(1:30, 10, replace=TRUE)
v2 <- names(v1) <- c("z","y","x","w","v","u","t","s","r","q") # letters[26:17]
v1; v2
# case2
v1 <- sample(1:30, 10)
v2 <- v1
names(v2) <- letters[26:17]
v1; v2

# 문제2
v <- seq(10, 38, 2)
m1 <- matrix(v, nrow = 3, ncol = 5, byrow=T); m1
m2 <- m1 + 100; m2
m_max_v <- max(m1); m_max_v
m_min_v <- min(m1); m_min_v
row_max <- apply(m1, 1, max); row_max
col_max <- apply(m1, 2, max); col_max

# 문제3
n1 <- c(1,2,3)
n2 <- c(4,5,6)
n3 <- c(7,8,9)
m2 <- cbind(n1, n2, n3); m2
# colnames(m2) <- c("[,1]", "[,2]", "[,3]"); m2
# case2
m2 <- matric(c(n1, n2, n3), 3, 3); m2

# 문제4
m3 <- matrix(data = 1:9, nrow = 3, ncol = 3, byrow=T); m3

#문제5
m4 <- m3;
rownames(m4) <- c("row1","row2","row3")
colnames(m4) <- c("col1","col2","col3")
m4

# 문제6
alpha <- matrix(letters[1:6], nrow = 2, ncol = 3); alpha
alpha2 <- rbind(alpha, c('x','y','z')); alpha2
alpha3 <- cbind(alpha, c('s','p')); alpha3

# 문제7
a <- array(1:24, dim=c(2,3,4)); a
# (1)
a[2,3,4]
# (2)
a[2,,]
# (3)
a[,1,]
# (4)
a[,,3]
# (5)
a + 100
# (6)
a[,,4] * 100
# (7)
a[1,2:3,]
# (8)
a[2,,2] <- a[2,,2] + 100
# (9)
a[,,1] <- a[,,1] - 2
# (10)
a <- a * 10
# (11)
rm(a)

