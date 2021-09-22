library(ggplot2)
library(dplyr)
# 문제 1
ggplot(mpg,aes(cty, hwy)) + geom_point(col = "blue")
ggsave("output/result1.png")

# 문제 2
ggplot(mpg, aes(x=class)) + geom_bar(aes(fill=drv), alpha=1.0)
ggsave("output/result2.png")

# 문제 3
file <- readLines("data/product_click.log")
product_id <- substr(file, 14, 17)
id_table <- table(product_id)
id_df <- data.frame(id_table) %>% 
  rename("V2"="product_id")

ggplot(data=id_df, aes(x=V2, y=Freq)) + 
  theme_minimal() +
  theme_bw() +
  geom_bar(aes(fill=V2), stat="identity") + 
  coord_cartesian(ylim=c(0, 100)) + 
  labs(title = "제품당 클릭수", subtitle="제품당 클릭수를 바그래프로 표현", x="상품ID", y="클릭수")

ggsave("output/result3.png")

# 문제 4
library(showtext)
showtext_auto() 
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")
library(treemap)
data("GNI2014")
#str(GNI2014)

treemap(GNI2014,index=c("continent", "iso3"), vSize="population", border.col = "green",
        title="전세계 인구 정보", fontsize.title = 20, fontsize.labels = c(10, 8), fontfamily.title="maple")

dev.copy(png, "output/result4.png")
dev.off()

# 문제 5
grade <- read.csv("data/성적2.csv", header = T, sep=",", encoding = "UTF-8")

# (그림 1)
View(grade)
# (그림 2)
boxplot(grade$국어, grade$수학,
        names = c("국어", "수학"))
# (그림 3)
grade$수학 <- ifelse(grade$수학 > 10, round(mean(grade$수학, na.rm = T)), grade$수학)
# (그림 4)
grade <- fill(grade, 국어, .direction = "updown")
grade <- fill(grade, 수학, .direction = "updown")
# (그림 5)
library(plotly)
# ggplot으로 그래프 만들기
ggplot(data = grade, aes(x = 국어, y =  수학, col = 성명)) + geom_point(aes(size = 3))

ggsave("output/result5.png")

