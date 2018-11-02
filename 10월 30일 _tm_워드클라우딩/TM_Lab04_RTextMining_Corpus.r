## Lab04_말뭉치(Corpus) 생성, 전처리

# 01. 텍스트 마이닝 패키지 불러오기(tm) - KoNLP
# 02. 데이터 줄단위 불러오기 - readLines
# 03. 텍스트에서 말뭉치(Corpus)로 변환 - 
   # VectorSource(벡터->데이터소스), DirSource(디렉터리->데이터소스)..., 
# 04. corpus 로 변환하여 저장 후, 전처리
   # Corpus, VCorpus 
# 05. 전처리가 후, 문서 내용 확인
   # tm_map(  tolower ) 
   # 
# 06. 불용어 처리 수행
   # stopwords('english')

# 07. 단어문서행렬(Term Document Matrix, TDM)
   # TermDocumentMatrix (코퍼스를 단어문서행렬)
   # DocumentTermMatrix (코퍼스를 단어문서행렬)

# 02. 데이터 줄단위 불러오기 - readLines
library(tm)
dat <- readLines("E:/BigData3/dataset/movie/dir_multi/ratings01_m.txt")
print(dat)

# 03. 텍스트에서 말뭉치(Corpus)로 변환
tSource <- VectorSource(dat)
tSource
myCor <- Corpus(tSource)
myCor

# 05. 전처리가 후, 문서 내용 확인
# 한글은 tm_map 함수를 하면서 내부적인 글자가 없어질 수 있다.
# tm_map(  tolower, stripWhitespace ) 문제 발생 있음.
myCor <- tm_map(myCor, removePunctuation)
myCor <- tm_map(myCor, removeNumbers)
myCor <- tm_map(myCor, stripWhitespace)

inspect(myCor)
myCor[[3]]$content

# 06. 불용어 처리 수행
## stopwords : C:\Users\ktm\Documents\R\win-library\3.5\tm\stopwords
## 나의 라이브러리 위치
.libPaths()

## 
# myCor <- tm_map(myCor, removeWords, stopwords("english"))
# 07. 단어 문서 행렬(Term Document Matrix, TDM)
# TF(용어의 빈도수)
# TFIDF
tdm <- TermDocumentMatrix(myCor, control=list(tokenize="scan", wordLengths=c(2,7)))
inspect(tdm)

tdm_M <- as.matrix(tdm)
tdm_M

## 단어 빈도수 구하기 
frequency <- rowSums(tdm_M)
frequency

## 정렬
frequency <- sort(frequency, decreasing = T) 
frequency  # 단어별 빈도 
barplot(frequency[1:20], las=2)  #막대그래프 그리고 

colors()
RColorBrewer::brewer.pal.info
## 워드 클라우드
library(wordcloud)  
w1 <- names(frequency)   # 단어별- 이름
pal <- brewer.pal(8, "Dark2")  # 색 지정 
wordcloud(words=w1,       # 이름 
          freq=frequency, # 빈도수 
          min.freq=1,     # 표시할 최소 횟수 
          random.order=F, # 가장 횟수가 많은 단어를 중심으로 
          random.color=T, # 여러가지 색을 랜덤하게 지정한다.
          colors=pal)     # 색 지정. 
