
### TF-IDF 실습 
### 01. 코퍼스 생성
### 02. 자연어 처리
### 03. 문서 단위 행렬 만들기
### 04. TF-IDF 로 문서내의 중요도 확인
library(tm)
docs <- c(D1 = "The sky is blue.", 
          D2 = "The sun is bright.", 
          D3 = "The sun in the sky is bright.")

dd <- Corpus(VectorSource(docs)) #Make a corpus object from a text vector
# dd <- tm_map(dd, tolower)
dd <- tm_map(dd, removePunctuation)
dd <- tm_map(dd, removeWords, stopwords("english"))
strwrap(dd)

dtm <- DocumentTermMatrix(dd, control = list(weighting = weightTfIdf))
as.matrix(dtm)

library(tm)
# doc1 <- "파스타 먹방, 강남 파스타 데이트"
# doc2 <- "강남 버스 파스타 맛집"
# doc3 <- "강남 버스, 강남 파스타, 강남 맛집"
docs <- c(D1 = "파스타 먹방, 강남 파스타 데이트", 
          D2 = "강남 버스 파스타 맛집", 
          D3 = "강남 버스, 강남 파스타, 강남 맛집")

dd <- Corpus(VectorSource(docs)) #Make a corpus object from a text vector
dd <- tm_map(dd, removePunctuation)
#dd <- tm_map(dd, removeWords, stopwords("english"))
#Clean the text
strwrap(dd)
dtm <- TermDocumentMatrix(dd, control = list(weighting = weightTfIdf))
as.matrix(dtm)
