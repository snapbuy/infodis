setwd("D:/NaverCloud/Lecture/KICT/Data")

# KISA는 두 기관에서 받은 파일로 키와 ID 결합정보를 생성한다.
key1 = read.csv("금융정보_key.csv", header = T, fileEncoding = "utf-8")
key2 = read.csv("병원정보_key.csv", header = T, fileEncoding = "utf-8")
key = merge(key1, key2, by = 'combine_key')

# 결합처리는 두 기관에서 받은 정보를 KISA 결합키를 기준으로 병합한다.
dsn1 = read.csv("금융정보_결합요청.csv", header = T, fileEncoding = "utf-8")
dsn2 = read.csv("병원정보_결합요청.csv", header = T, fileEncoding = "utf-8")

library("dplyr")
dsn1 = rename(dsn1, ID.x = ID)
dsn2 = rename(dsn2, ID.y = ID)

dsn_combine = merge(key, dsn1, by = 'ID.x')
dsn_combine = merge(dsn_combine, dsn2, by = 'ID.y')
dsn_combine = select(dsn_combine, -c(ID.x, ID.y, combine_key)) 

write.csv(dsn_combine, file="결합결과정보.csv", row.names=FALSE, fileEncoding='utf-8')
