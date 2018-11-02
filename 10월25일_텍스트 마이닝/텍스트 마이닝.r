setwd("C:/Users/ktm/Documents/choi_dontouch/R-basic/10월25일_텍스트 마이닝")
sen <- readLines("미국과중국.txt",encoding="UTF-8" )
extractNoun(sen)
sen <- extractNoun(sen)
sen
nouns <- sen
nouns <- sapply(all.reviews, extractNoun, USE.NAMES=F)  # nouns : 리스트
nouns <- unlist(nouns)
nouns
### 쓸데없는 단어 삭제 및 빈도 확인 
nouns <- gsub("\\d+","", nouns)
nouns <- gsub("\t","", nouns)
nouns <- gsub("[a-zA-Z]","", nouns)
nouns <- gsub("중국이","", nouns)
nouns <- nouns[nchar(nouns)>=2]
nouns

wordFreq <- table(nouns)
wordFreq <- sort(wordFreq, decreasing=T)


len = length(wordFreq)
wdFreq1 <- wordFreq[1:300] 
is(wdFreq1)
#wdFreq50 <- wordFreq[1:30]
library(wordcloud2)


#### 10. 색 지정(brewer.pal(6, "Dark2")
#### 11. 폰트 지정
#### 12. set.seed(1000)
#### 13. wordcloud( )

pal <- brewer.pal(8,"Dark2")

#windowsFonts(malgun=windowsFont("맑은 고딕"))

set.seed(1000)
wc2<-wordcloud2(data=wdFreq1, size =1.0, color = "random-light", backgroundColor = "grey",rotateRatio = 0.75)
wc2

https://mrchypark.github.io/getWebR/#1