sentence <- readLines("data/memo.txt", encoding = 'UTF-8')
new_sentence <- c(
  gsub("[&$!#@%]", "", sentence[1]),
  gsub("e", "E", sentence[2]),
  gsub("[[:digit:]]", "", sentence[3]),
  gsub("[A-Za-z]", "", sentence[4]),
  gsub("[[:punct:][:digit:]]", "", sentence[5]),
  gsub("[[:space:]]", "", sentence[6]),
  # gsub("you&ok", "[[:tolower:]]", sentence[7]) 
  # 두 번째 아규먼트에는 문자열만 올 수 있다. 정규표현식은 첫 번째 아규먼트에만 올 수 있다.
  tolower(sentence[7])
)
write(new_sentence, "output/memo_new.txt")

# https://stackoverflow.com/questions/30664444/gsub-error-turning-upper-to-lower-case-in-r





