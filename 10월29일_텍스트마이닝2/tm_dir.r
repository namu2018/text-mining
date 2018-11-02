
install.packages("tm")
library(tm)
library(KoNLP)
setwd("C:/Users/ktm/Documents/choi_dontouch/R-basic/10월29일_텍스트마이닝2")
myCorpus <- VCorpus(DirSource("dir_multi", pattern="txt"))
inspect(myCorpus)
str(myCorpus)
content(myCorpus[[1]])
###문서의 내용 전체를 보겠다
lapply(myCorpus, content)

###meta정보 보기 및 추가
meta(myCorpus[[1]])
meta(myCorpus[[1]], tag='etc') <- "추가"
meta(myCorpus[[3]], tag='author')<- "choi"
paste(myCorpus[[1]]$content, collapse=" ")##공백을 넣고 실시
length(myCorpus[[1]]$content) ##벡터의 수
myCorpus[[1]]$meta

###각각의 문서의 리뷰를 한줄로 만들겠다
for(i in seq_along(myCorpus)){
  myCorpus[[i]]$content <- paste(myCorpus[[i]]$content, collapse=" ") 
}


##myCorpus <- tm_map(myCorpus, stripWhitespace) #공백제거
myCorpus[[1]]$content
#myCorpus <- tm_map(myCorpus, tolower)         ##소문자로 
myCorpus <- tm_map(myCorpus, removePunctuation)##특수문자제거
myCorpus <- tm_map(myCorpus, removeNumbers) ##숫자제거
myCorpus <- tm_map(myCorpus, removeWords, stopwords("en"))##불용어 제거 
myCorpus <- tm_map(myCorpus, removeWords, c("영화","ㅎㅎㅎ","여러"))
inspect(myCorpus)


library(KoNLP)
library(NIADic)
useNIADic()
myCorpus[[1]]$contentn <- gsub("ㅋㅋㅋ","", myCorpus[[1]]$content) 

for ( i in seq_along(myCorpus)){
  myCorpus[[i]]$contentn <- gsub("ㅎㅎㅎㅎㅎㅎㅎㅎ","", myCorpus[[i]]$content) 
  myCorpus[[i]]$contentn <- gsub("ㅋㅋㅋ","", myCorpus[[i]]$content)
  myCorpus[[i]]$contentn <- gsub("영화","", myCorpus[[i]]$content)
}

###나의 라이브러리 위치

dtm=DocumentTermMatrix(myCorpus, control=list(weighting=weightTfIdf))

as.matrix(dtm)

names(dtm)
