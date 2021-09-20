## 상관분석을 통해 병아리 몸무게에 영향을 미치는 인자를 찾을 수 있었고 그중에서도 병아리가 태어난 
## 달걀인 종란의 무게가 가장 큰 양의 상관 관계를 갖고 있음을 확인할 수 있었다.
## 그렇다면 종란의 무게로 병아리의 몸무게를 예측하는 것이 가능할까? 회귀분석을 통해 해결해 본다.
## 선형회귀분석 : 연속형 변수들에 대해 두 변수 간의 관계를 수식으로 나타내는 분석 방법이다.
##                영향을 주는 변수 - 독립변수(x), 영향을 받는 변수 - 종속변수(y)
##                회귀식 - y = ax + b


## 종란의 무게로 병아리의 무게를 예측할 수 있을까? (회귀분석)

w <- read.csv("data/data4.csv")
# w 데이터 셋에서 2~5열 데이터만 가져오기(첫열은 factor이므로)
w_n <- w[,2:5]
head(w_n)

# 단순선형 회귀분석 실시
w_lm <- lm(weight ~ egg_weight, data = w_n)

w_lm

## - 회귀모델 F 통계량의 p-값(유의확률)을 확인하여 0.05 보다 작으면 95% 신뢰수준에서 
##   통계적으로 유의하다고 판단함
## - 독립 변수의 p-값(유의확률)을 확인하여 0.05 보다 작으면 95% 신뢰수준에서 
##   통계적으로 유의(영향력이 있다고)하다고 판단함 또한 * 기호가 많을 수록 유의성이 높아짐
## - 결정계수(R-squared)가 높은지 확인하여 1에 가까울수록 회귀모델의 성능이 뛰어남을 뜻함.
##   독립변수가 2개이상인 다중회귀모델은 Adjusted R-squared 값으로 확인
## - 회귀모델의 y절편(상수)과 독립변수의 계수는 Estimate 값으로 확인 가능. 회귀분석 결과를
##   저장한 변수의 coefficient로도 확인 가능.
# 회귀모델 결과 확인
summary(w_lm)

# 산점도에 회귀직선을 표시해 모델이 데이터를 잘 대표하는지 확인
plot(w_n$egg_weight, w_n$weight)  # 산점도 그리기
lines(w_n$egg_weight, w_lm$fitted.values, col = "blue")  # 회귀직선 추가
text(x = 66, y = 132, label = 'Y = 2.3371X - 14.5475')  # 회귀직선 라벨로 표시

names(w_lm)  # w_lm 변수에 어떤 항목들이 있는지 확인

w_lm$coefficients
w_lm$model
w_lm$residuals # 잔차 : 실제 종속변수 값과 회귀 모델로 추정된 값의 편차

hist(w_lm$residuals, col = "skyblue", xlab = "residuals",
     main = "병아리 무게 잔차 히스토그램")

## 잔차에 대한 히스토그램을 확인한 결과 정규분포를 이루고 있지 않는다.
## 잔차가 높게 나왔다는 결과... --> 영향을 주는 변수인 독립 변수를 좀더 늘려보자. - 다중회귀분석
## 다중회귀분석 : 독립 변수가 2개 이상 - y = ax1 + bx2 + c

# 다중회귀분석 실시
w_mlm <- lm(weight ~ egg_weight + movement + food, data = w_n)

summary(w_mlm)

# p값이 높은 movement 변수를 제외한 열만 다시 회귀분석 실시 
w_mlm2 <- lm(weight ~ egg_weight + food, data = w_n)

summary(w_mlm2)

## 다중공선성 : 여러 개의 독립변수들을 사용하는 다중회귀분석에서는 독립변수들간의 강한 상관관계로
##              제대로 회귀분석이 실시되지 못할 수도 있다. 다중공선성은 분산팽창요인(VIF)을 계산해
##              구할 수 있는데 일반적으로 10 이상이면 다중공선성 문제가 있다고 판단한다.

# 다중공선성(Multicollinearity) 확인을 위한 패키지 설치
install.packages("car")
library(car)

# 분산팽창요인(Variation Inflation Factor, VIF)
# 정해져 있는 기준은 없지만 4~10이상이면 문제있다고 보고, 30보다 크면 심각하다고 판단
vif(w_mlm2)
??w_mlm2
## 잔차 히스토그램 : 단순 선영 회귀분석에서처럼 산점도를 그려서 회귀모델이 얼마나 적합한지 
## 봐야하지만 다중 회귀 분석은 독립변수가 많으므로 최소 3차원 이상의 축을 가진
## 그래프를 그려야 함  --> 잔차 히스토그램만 확인
hist(w_mlm2$residuals, col = "skyblue", xlab = "residuals",
     main = "병아리 무게 잔차 히스토그램(다중 회귀)")

## 다중회귀분석에서 변수 선택 방법
## 전진선택법 : y 절편만 있는 상수부터 시작해서 독립 변수들을 추가해 나가는 방법
## 후진소거법 : 독립 변수를 모두 포함한 상태에서 가장 적은 영향을 주는 변수를 하나씩 제거해 나감
# (참고)후진소거법을 적용해 자동으로 실행
step_mlm <- step(w_mlm, direction = "backward")

# (참고)회귀분석 결과 그래프로 확인
r <- par(mfrow=c(2,2))
plot(w_mlm2)
par(r)

## 김대표는 병아리에서 닭이 될 때까지 성장 기간에 따른 몸무게의 변화가 궁금해졌다.
## 병아리 한 마리를 지정해서 부화한 첫 날부터 70일까지의 몸무게를 기록했다. -> 어떻게 성장했을까?

## 비선형 회귀분석(다항 회귀분석)
## 독립변수와 종속변수가 선형관계가 아닌 비선형 관계일 때 사용하는 분석 방법
## 독립변수와 종속변수 관계가 곡선 형태일 때
## 독립변수에 로그나 거듭 제곱 등을 취해 보면서 적합한 비선형 모델을 찾는다.
# 비선형 회귀분석용 두번째 데이터셋 불러오기
w2 <- read.csv("data/data5.csv", header = TRUE)

head(w2)

str(w2)

plot(w2)  # 데이터 형태 산점도로 확인


# 성장기간에 따른 병아리 무게 변화 선형 회귀분석 실시
w2_lm <- lm(weight ~ day, data = w2)

summary(w2_lm)

# 산점도 위에 회귀직선 표시
lines(w2$day, w2_lm$fitted.values, col = "blue")

# 성장기간에 따른 병아리 무게 변화 비선형 회귀분석 실시
w2_lm2 <- lm(weight ~ I(day^3) + I(day^2) + day, data = w2)

summary(w2_lm2)

plot(w2)

# 산점도 위에 회귀곡선 표시
lines(w2$day, w2_lm2$fitted.values, col = "red")

# w2_lm2 회귀분석 결과에서 계수 확인
w2_lm2$coefficients

# 산점도 위에 수식 표시
text(25, 3000, "weight = -0.025*day^3 + 2.624*day^2 - 15.298*day + 117.014")






# 소스20

## 회귀분석 (regression)
## 회귀분석의 실행

data(cars) # 자동차의 속도와 정지 거리
cars
str(cars)
summary(cars)

out <- lm(dist ~ speed, data=cars)
summary(out)

out$coef  # 회귀계수
fitted(out) # 예측치
resid(out) # 잔차
cars$dist - fitted(out)  # 잔차=관측치-예측치
summary(out)$sigma  # 평균 잔차 (residual standard error)

cor.test(cars$speed, cars$dist)
plot(dist ~ speed, data=cars, col="blue")
abline(out, col="red")


## 회귀모형의 진단 (regression diagnostics)

## 회귀진단
out <- lm(dist ~ speed, data=cars)
op <- par(mfrow=c(2,2))  # 화면 분할 기능(4등분)
plot(out)
par(op) # 원래 화면(1,1)으로 전환

# 잔차의 정규성 - Q-Q plot 출력
qqnorm(resid(out))
qqline(resid(out))

shapiro.test(resid(out))


# 잔차의 독립성 (independence of errors)
library(car)
durbinWatsonTest(out)

# 이상치, 높은 레버리지값, 영향력 있는 관찰값
influencePlot(out, main="Influence Plot", sub="Circle size is proportional
              to Cook's distance")


# 선형 모형의 가정에 대한 종합적 검정
install.packages("gvlma")
library(gvlma)
gvmodel <- gvlma(out)
summary(gvmodel) 

# 종속변수의 정규분포 가정을 위반하는 문제 해결하기
# 종속변수의 변환(transformation)
op <- par(mfrow=c(2,2))
plot(dist~speed, data=cars) 
plot(log(dist)~speed, data=cars) 
plot(sqrt(dist)~speed, data=cars) 
par(op)
library(car)
summary(powerTransform(cars$dist))

# 종속변수를 제곱근으로 변환한 후 모형분석 그리고 회귀진단
out2 <- lm(sqrt(dist) ~ speed, data=cars)
summary(out2)

plot(sqrt(dist)~speed, data=cars, col="blue")
abline(out2, col="red")

op <- par(mfrow=c(2,2))
plot(out2)  
par(op)

# 정규성 검정
qqnorm(resid(out2))
qqline(resid(out2))
shapiro.test(resid(out2))

# 선형 모형의 가정에 대한 종합적 검정
library(gvlma)
gvmodel <- gvlma(out2)
summary(gvmodel)

# 예측
example <- data.frame(speed=c(10,20,30))
predict.lm(out2, example)

lmexpr <- function(x) {
  y <- 0.32241 * x + 1.27705
  return(y)  
}
sapply(example, lmexpr)


## 다중회귀분석 (multiple linear regression)

# 엄마와 아빠 키로 아들의 키를 예측하는 다중선형회귀모델 생성 
height_father <- c(180, 172, 150, 180, 177, 160, 170, 165, 179, 159) # 아버지 키 
height_mohter <- c(160, 164, 166, 188, 160, 160, 171, 158, 169, 159) # 어머니 키
height_son <- c(180, 173, 163, 184, 165, 165, 175, 168, 179, 160) # 아들 키 
height <- data.frame(height_father, height_mohter, height_son)
head(height) 

model <-lm (height_son ~ height_father + height_mohter, data = height)
model 


# 결정계수와 수정된 결정계수
summary(model)

(coef_r <- coef(model))
coef_r[1]
coef_r[2]
coef_r[3]

# 잔차 
r <- residuals(model)
r[1:4]

# 예측 
predict.lm(model, newdata = data.frame(height_father = 170, height_mohter = 160))
predict.lm(model, newdata = data.frame(height_father = 170, height_mohter = 160), interval = "confidence")


state.x77 # 미국 50개 주의 인구, 소득, 문맹률 등에 대한 데이터
?state.x77
head(state.x77)

# state.x77 데이터 중에서 5개 변수만 선정한 데이터프레임을 만든다
states <- data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])
head(states)
cor(states)
str(states)
class(states)

# psych 패키지 이용하여 상관분석
library(psych)
lowerCor(states, use="pairwise")
corr.test(states, use="pairwise")
corPlot(states, numbers=T, stars=T, upper=F, diag=F)


# 다중회귀분석 실행
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
summary(fit)


# 표준화 회귀계수 제시
zstates=data.frame(scale(states))
zfit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=zstates)
coef(zfit)
summary(zfit)


# 회귀모형의 진단 (regression diagnostics)

fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
op <- par(mfrow=c(2,2)) # 2 x 2 pictures on one plot
plot(fit)
par(op) # reset to previous setting


# Q-Q plot 만들기
library(car)
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states) 
qqPlot(fit, labels=row.names(states), id.method="identify", simulate=T, main="Q-Q Plot")

states["Nevada",]
fitted(fit)["Nevada"]
residuals(fit)["Nevada"]
rstudent(fit)["Nevada"]  # 레버리지를 고려한 표준화된 잔차(studentized residuals)



# 이상치 (Outliers)

library(car)
outlierTest(fit)

# Nevada를 제외하고 분석
fita <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states[-28, ])
summary(fita)
outlierTest(fita) 


# 선형 모형의 가정에 대한 종합적 검정 

library(gvlma)
gvmodel <- gvlma(fit)
summary(gvmodel)

gvmodel2 <- gvlma(fita)
summary(gvmodel2)


# 다중공선성 (multicollinearity) - sqrt(VIF) > 2 --> 다중공선성 문제가 있다.

library(car)
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
vif(fit)
sqrt(vif(fit)) 


# 다중공선성 검정 사례2

head(mtcars)
mtcars2 <- data.frame(mtcars[, c(1,3,4,6)])
corr.test(mtcars2, use="complete")

fit <- lm(mpg ~ disp + hp + wt, data=mtcars2)
summary(fit)
library(car)
vif(fit)
sqrt(vif(fit))

fit <- lm(mpg ~ hp + wt, data=mtcars2)
summary(fit)
vif(fit)
sqrt(vif(fit))


# 모형비교 (model comparison)

fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
fit2 <- lm(Murder ~ Population + Illiteracy, data=states)
summary(fit1)
summary(fit2)
AIC(fit, fit2)


# 최선의 모형 선택 (selecting the "best" model)

library(MASS)
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
step(fit, direction="backward") 

install.packages("leaps")
library(leaps)
states.regsubsets <- regsubsets(x=Murder ~ Population + Illiteracy + Income + Frost, data=states, nbest=4)
library(RColorBrewer)
plot(states.regsubsets, scale="adjr2", col=brewer.pal(9, "Pastel1"),
     main="All Subsets Regression")

summary(states.regsubsets)

names(summary(states.regsubsets))

summary(states.regsubsets)$adjr2

which.max(summary(states.regsubsets)$adjr2)

coef(states.regsubsets, 2)

# 또 다른 예
mtcars.regsubsets <- regsubsets(x=mpg ~ hp + wt + disp + drat, data=mtcars, nbest=4)

library(RColorBrewer)
plot(mtcars.regsubsets, scale="adjr2", col=brewer.pal(9, "Pastel1"),
     main="All Subsets Regression")

summary(mtcars.regsubsets)

names(summary(mtcars.regsubsets))

summary(mtcars.regsubsets)$adjr2

which.max(summary(mtcars.regsubsets)$adjr2)
coef(mtcars.regsubsets, 9)

