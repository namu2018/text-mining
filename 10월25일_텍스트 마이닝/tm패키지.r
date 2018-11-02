###근래에는 일본에서 만든 MeCAB 패키지를 끈다.

getwd()
trump <- readLines("trump.txt", encoding='UTF-8')
trump
install.packages("tm")
library(tm)

docs <- trump
docs
myCorpus <- Corpus(VectorSource(docs))
myCorpus

##불용어 처리 및 기타 전처리
myCorpus <- tm_map(myCorpus, stripWhitespace) #공백제거
myCorpus <- tm_map(myCorpus, tolower)         ##소문자로 
myCorpus <- tm_map(myCorpus, removePunctuation)##특수문자제거
myCorpus <- tm_map(myCorpus, removeNumbers) ##숫자제거
myCorpus <- tm_map(myCorpus, removeWords, stopwords("english"))##불용어 제거 
inspect(myCorpus)

###단어문서 행렬, 문서단어행렬(DocumentTermMatrix)
tdm <- TermDocumentMatrix(myCorpus)
tdm
m <- as.matrix(tdm)
m

###워드클라우드
wordFreq <- sort(rowSums(m), decreasing=TRUE)
wordFreq
#빈도확인
findFreqTerms(tdm,lowfreq=2, highfreq=inf)
##연관성확인 
findAssocs(tdm, "embraces", 0.2)
