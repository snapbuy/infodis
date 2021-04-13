setwd("D:/Naver MyBox/Lecture/KICT/data")
df <- read.csv("arxTest.csv", header=TRUE)

library(sqldf)

# (0,0,0) 모형의 frequency
sqldf("select count(*) from df group by sex, age, loc")

df$sexL1 <- '*'

df$ageL1 <- NA
df$ageL1 <- ifelse(df$age < 20, 0, NA)
df$ageL1 <- ifelse(df$age >= 20 & df$age <25, 1, df$ageL1)
df$ageL1 <- ifelse(df$age >= 25 & df$age <30, 2, df$ageL1)
df$ageL1 <- ifelse(df$age >= 30 & df$age <35, 3, df$ageL1)
df$ageL1 <- ifelse(df$age >= 35 & df$age <40, 4, df$ageL1)
df$ageL1 <- ifelse(df$age >= 40 & df$age <45, 5, df$ageL1)
df$ageL1 <- ifelse(df$age >= 45 & df$age <50, 6, df$ageL1)
df$ageL1 <- ifelse(df$age >= 50 & df$age <55, 7, df$ageL1)
df$ageL1 <- ifelse(df$age >= 55 & df$age <60, 8, df$ageL1)
df$ageL1 <- ifelse(df$age >= 60, 9, df$ageL1)

df$locL1 <- df$loc
df$locL1 <- ifelse(df$loc != "서울" & df$loc != "경기", "수도권외",df$locL1)
df$locL1 <- ifelse(df$loc == "서울", "서울",df$locL1)
df$locL1 <- ifelse(df$loc == "경기", "경기",df$locL1)


# (0,1,1) 모형의 frequency
sqldf("select sex, ageL1, locL1, count(*) from df group by sex, ageL1, locL1")

# (1,0,1) 모형의 frequency
sqldf("select sexL1, age, locL1, count(*) from df group by sexL1, age, locL1")

