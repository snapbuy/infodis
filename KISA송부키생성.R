setwd("D:/NaverCloud/Lecture/KICT/data")
dsn1 = read.csv("금융정보.csv", header = T, fileEncoding = "utf-8")
dsn2 = read.csv("병원정보.csv", header = T, fileEncoding = "utf-8")

library(digest)

# 결합키 생성 예(sha256 알고리즘으로 협의했다고 가정)
dsn1$combine_key = sapply(paste(dsn1$Name, dsn1$BirthDate), digest, algo="sha256")
dsn2$combine_key = sapply(paste(dsn2$Name, dsn2$BirthDate), digest, algo="sha256")

dsn1$combine_key[1]
dsn2$combine_key[1]

library("dplyr")

# KISA에 송부할 결합키 파일 생성

dsn1_key = select(dsn1, c(ID, combine_key)) 
dsn2_key = select(dsn2, c(ID, combine_key))
write.csv(dsn1_key, file="금융정보_key.csv", row.names=FALSE, fileEncoding='utf-8')
write.csv(dsn2_key, file="병원정보_key.csv", row.names=FALSE, fileEncoding='utf-8')
