##KoNLP를 이용한 텍스트 마이닝 분석
###한국어를 분석할 수 있는 27개 이상의 함수 존재
install.packages("KoNLP")
library(KoNLP)
###사전 불러오기 
useSejongDic()

##명사추출
extractNoun(sentence)
###Hannanum alalyzer 을 사용하여 한국어 문장으로 부터 명사를 추출 
###java로 개발
sentence <- "우리나라 고유 문화는 우수하다. 전시회를 재미있게 보았다. 시간이 스스륵 지나갔다."
extractNoun(sentence, autoSpacing = TRUE)
extractNoun(sentence, autoSpacing = FALSE)##기본

##사전에 단어 추가
##mergeUserDic()함수를 사용하여 sejong사전에 '스르륵' 단어 '부사'로 추가하기 
mergeUserDic(data.frame(c('스르륵'),c('mag')))
extractNoun(sentence)

###형태소 분석하기
Mor <- MorphAnalyzer(sentence)
ls(Mor)
names(Mor)
class(Mor)

###품사태그를 달아주는 함수
SimplePos09(sentence)
SimplePos22(sentence)

###명사확인
library(stringr)
txt=SimplePos22(sen)
txt_n <- str_match(txt, '([a-zA-Z가-힣]+)/N')
txt_n
##############
class(txt_n)
setwd("C:/Users/ktm/Documents/choi_dontouch/R-basic/10월25일_텍스트 마이닝")
sen <- readLines("미국과중국.txt",encoding="UTF-8" )
extractNoun(sen)
sen <- extractNoun(sen)
sen
nouns <- sen
#nouns <- sapply(all.reviews, extractNoun, USE.NAMES=F)  # nouns : 리스트
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
wc2<-wordcloud2(data=wdFreq1, size =0.8, color = "random-light", backgroundColor = "grey",rotateRatio = 0.75)
wc2

