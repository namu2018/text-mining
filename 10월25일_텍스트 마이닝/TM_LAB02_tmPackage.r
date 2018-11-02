
#!install.packages("tm")
library(tm)

library(tm)
docs <- c("I am boy", "You are a girl", "I am a student")
is(docs)

VectorSource(docs)

## 코퍼스 생성
print(Corpus(VectorSource(docs)))
myCorpus <- Corpus(VectorSource(docs))
is(myCorpus)

print(myCorpus[1:3])
print(myCorpus[[1]])  # "I am boy"        -> 각각의 문서
print(myCorpus[[2]])  # "You are a girl"  -> 각각의 문서
print(myCorpus[[3]])  # "I am a student"  -> 각각의 문서

## Corpus의 내용을 확인해 보기
inspect(myCorpus[1:3])

setwd("C:/Users/WITHJS/Documents/R/00_TM_TextMining")
textMining = readLines("D:/dataset/textMining/anb-jarena-lee.txt")
is(textMining)
print(textMining)

myCorpus = Corpus(VectorSource(textMining))
myCorpus <- tm_map(myCorpus, stripWhitespace)
myCorpus <- tm_map(myCorpus, tolower)
myCorpus <- tm_map(myCorpus, removePunctuation)
myCorpus <- tm_map(myCorpus, removeNumbers)
myCorpus <- tm_map(myCorpus, removeWords, stopwords("english"))  # 불용어 제거

stopword2 <- c(stopwords('en'), "and", "but", "not")  # 추가 불용어 추가
myCorpus <- tm_map(myCorpus, removeWords, stopword2 ) 

str(myCorpus)

tdm <- TermDocumentMatrix(myCorpus)
tdm  
# terms는 총 72개의 단어, documents:13  (소스는 13개의 문장이다.)
# sparsit가 92%는 tdm안에 92%가 0인 원소이다.

# tdm(Term-Document Matrix)는 tm 패키지만 볼 수 있다. 
# 따라서 일반적으로 우리가 알아볼 수 있는 Matrix로 변환한다.
m <- as.matrix(tdm)
m

print(textMining)

### 추가 불용어 처리를 해 준다. 
stopword2 <- c(stopwords('en'), "new", "among", "ennui")  # 추가 불용어 추가
myCorpus <- tm_map(myCorpus, removeWords, stopword2 ) 
tdm2 <- TermDocumentMatrix(myCorpus)
tdm2

## 행렬 변환
m2 <- as.matrix(tdm2)
m2

library(RColorBrewer)
wordFreq <- sort(rowSums(m2), decreasing=TRUE)
head(wordFreq, 20)

## 컬럼별 집계
wordFreq2 <- sort(colSums(m2), decreasing=TRUE)
wordFreq2

findFreqTerms(tdm2, lowfreq=2, highfreq=Inf)

findAssocs(tdm2, "jersey", 0.2)   # jersey와 0.2 이상의 단어만 검색

library(RColorBrewer)
library(wordcloud)
search()

names(wordFreq)
wordFreq

set.seed(1234)
wordF = findFreqTerms(tdm2, lowfreq=1, highfreq=Inf)
pal = brewer.pal(8, "Dark2")

wordcloud(words=names(wordFreq), 
          freq=wordFreq, 
          scale=c(4, 1), 
          min.freq=2, colors=pal, random.order=F, random.color=T)
legend(0.3, 1 ,"tm Package Test", cex=1, fill=NA, border=NA, bg='white', text.col='red', text.font=2, box.col='red')

barplot(wordFreq, main='tm Package plot', las=2)

testText <- readLines("D:/dataset/textMining/___.txt")  # 라인별 text 파일 읽어오기
print(testText)
str(testText)
