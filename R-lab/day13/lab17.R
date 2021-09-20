library(dplyr)
# [ 1단계 ]
emp <- read.csv("data/emp.csv")
#str(emp)
#View(emp)

# 문제1
emp %>% filter(job == "MANAGER")
# 문제2
emp %>% select(empno, ename, sal)
# 문제3
emp %>% select(-empno)
# 문제4
emp %>% select(ename, sal)
# 문제5
emp %>% count(job)
# 문제5 - case2
emp %>% group_by(job) %>% count
# 문제6
emp %>% 
  filter(sal >= 1000 & 3000 >= sal) %>% 
  select(ename, sal, deptno)
# 문제7
emp %>% 
  filter(job != "ANALYST") %>% 
  select(ename, job, sal)
# 문제8
emp %>% 
  filter(job == "SALESMAN" | job == "ANALYST") %>% 
  select(ename, job)
# 문제9
emp %>% 
  group_by(deptno) %>% 
  summarise(sum_sal = sum(sal))
# 문제10
emp %>% arrange(sal)
# 문제11
emp %>% 
  arrange(desc(sal)) %>% 
  head(1)
# 문제12
emp %>% 
  rename(salary = sal, commrate = comm) -> empnew
str(empnew)
# 문제13
emp %>% 
  arrange(desc(deptno)) %>% 
  head(1) %>% 
  select(deptno)
# 문제13 - case2
emp %>% 
  count(deptno) %>% 
  arrange(desc(n)) %>% 
  select(deptno) %>% 
  head(1)
# 문제14
emp %>% 
  select(ename) %>% 
  mutate(enamelength = nchar(ename)) %>% 
  arrange(enamelength)
# 문제14 - case2
emp %>% 
  mutate(enamelength = nchar(ename)) %>% 
  arrange(enamelength) %>% 
  select(ename, enamelength)
# 문제15
emp %>% 
  filter(!is.na(comm)) %>% 
  summarise(n = n()) # count


# [ 2단계 ]
library(ggplot2)
# 문제16
str(ggplot2::mpg)
mpg <- as.data.frame(ggplot2::mpg)
# (1)
str(mpg) #mpg %>% str
# (2)
dim(mpg) #mpg %>% dim
# (3)
mpg %>% head(10)
# (4)
mpg %>% tail(10)
# (5)
View(mpg) #mpg %>% View
# (6)
summary(mpg) #mpg %>% summary
# (7)
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(n = n()) #count
# (7) - case2
mpg %>% 
  count(manufacturer)
# (8)
mpg %>% 
  group_by(manufacturer, model) %>% 
  summarise(n = n()) #count
# (8) - case2
mpg %>% 
  count(manufacturer, model)

# 문제17
# (1)
mpg %>% 
  rename(city = cty, highway = hwy) -> mpgnew
str(mpgnew) # mpgnew %>%  str
# (2)
head(mpgnew) # mpgnew %>% head

# 문제18
# (1)
mpg %>% 
  filter(displ <= 4) %>% 
  summarise(mean(hwy))
mpg %>% 
  filter(displ >= 5) %>% 
  summarise(mean(hwy))
cat("배기량이 4 이하인 자동차의 hwy는 25.96319이고 
배기량이 5 이상인 자동차의 hwy는 18.07895이므로
배기량이 4 이하인 자동차의 hwy가 평균적으로 더 높다.")

# (1) - case2
mpg %>% 
  filter(displ <= 4 | displ >= 5) %>% 
  mutate(displ.group = ifelse(displ <= 4, "배기량 4이하", "배기량 5이상")) %>% 
  group_by(displ.group) %>% 
  summarise(hwy.mean = mean(hwy))

# (1) - case3
mpg %>% filter(displ <= 4) -> displ4
mpg %>% filter(displ >= 5) -> displ5
if(mean(displ4$hwy) > mean(displ5$hwy)){
  cat("배기량이 4 이하인 자동차의 hwy가 평균적으로 더 높다")
}else{
  cat("배기량이 5 이상인 자동차의 hwy가 평균적으로 더 높다")
}

# (2)
mpg %>% 
  filter(manufacturer == "audi") %>% 
  summarise(audi = mean(cty))
mpg %>% filter(manufacturer == "toyota") %>% 
  summarise(toyota = mean(cty))
cat("audi의 cty는 17.61111이고 toyota의 cty는 18.52941이므로
toyota의 cty가 평균적으로 더 높다.")

# (2) - case2
mpg %>% 
  filter(manufacturer %in% c("audi", "toyota")) %>% 
  group_by(manufacturer) %>% 
  summarise(cty.mean = mean(cty))

# (3)
mpg %>%
  filter(manufacturer == "chevrolet" | manufacturer == "ford" | manufacturer == "honda") %>% 
  summarise(mean(hwy))

# (3) - case2
mpg %>%
  filter(manufacturer %in% c("chevrolet", "ford", "honda")) %>% 
  summarise(mean(hwy))

# 문제19
# (1)
mpg %>% 
  select(class, cty) -> mpg3
head(mpg3)
# (2)
mpg %>% 
  filter(class == "suv") %>% 
  summarise(suv_mean = mean(cty))
mpg %>% 
  filter(class == "compact") %>% 
  summarise(compact_mean = mean(cty))
cat("suv class의 cty가 13.5이고
compact class의 cty가 20.12766이므로
compact class의 cty가 평균적으로 더 높다")

# (2) - case2
mpg %>% 
  filter(class %in% c("suv", "compact")) %>% 
  group_by(class) %>% 
  summarise(cty.mean = mean(cty))

# 문제20
mpg %>% 
  filter(manufacturer == "audi") %>%
  arrange(desc(hwy)) %>% 
  head(5)



