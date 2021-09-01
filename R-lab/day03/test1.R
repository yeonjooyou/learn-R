# scan() : 파일이 숫자로만 구성되어있을 때때
cat("오름차순 :", sort(scan("data/iotest1.txt"), decreasing=F), "\n",
    "내림차순 :", sort(scan("data/iotest1.txt"), decreasing=T), "\n",
    "합 :", sum(scan("data/iotest1.txt")), "\n",
    "평균 :", mean(scan("data/iotest1.txt")), "\n")

# case2
nums <- scan("data/iotest1.txt") # 워킹디렉토리를 기준으로 상대패스

cat("오름차순 :", sort(nums),"\n")
cat("내림차순 :", sort(nums, decreasing = T),"\n")
cat("합 :", sum(nums), "\n")
cat("평균 :", mean(nums), "\n")