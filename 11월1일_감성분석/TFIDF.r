
library(tm)

docs <- c(D1="The sky is blue",
          D2="The sun is bright.",
          D3="The sun in the sky is bright")
dd <- Corpus(VectorSource(docs))
dd <- tm_map(dd, removePunctuation)
dd <- tm_map(dd, removeWords, stopwords("english"))

strwrap(dd)
inspect(dd)
?strwrap

###03. 단어문서행렬 

dtm=DocumentTermMatrix(dd, control=list(weighting=weightTfIdf))

as.matrix(dtm)


###
doc <- c("파스타 먹방, 강남 파스타기 데이트","강남 버스 파스타 맛집","강남 버스, 강남 파스타, 강남 맛집")
docs <- doc


#####trump기사
getwd()
docs <- readLines("trump.txt")
docs
dd
dd <- Corpus(VectorSource(docs))
inspect(dd)
dd <- tm_map(dd, removePunctuation)
inspect(dd)
dd <- tm_map(dd, removeWords, stopwords("english"))
dd <- tm_map(dd, removeNumbers)
dd <- tm_map(dd, stripWhitespace)
##dd <- tm_map(dd, removeWords, stopwords("en"))



strwrap(dd)
inspect(dd)
?strwrap

###03. 단어문서행렬 

dtm=DocumentTermMatrix(dd, control=list(weighting=weightTfIdf))

a = as.matrix(dtm)
a
View(a)
