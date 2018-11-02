library(tm)
library(rvest)
rm(list=ls())
all.reviews <-c()
all_url <-c()
for (i in 1:20 ){
  miss <- paste0('https://movie.daum.net/moviedb/grade?movieId=110097&type=netizen&page=',i)
  all_url <- c(all_url,miss)
  htxt1=read_html(all_url[i])
  table1=html_nodes(htxt1,'.review_info')
  content1=html_nodes(table1,'.desc_review')
  reviews1 = html_text(content1)
  reviews1 <-gsub('\n','',reviews1)
  reviews1 <-gsub('\t','',reviews1)
  all.reviews  <-c(all.reviews , reviews1)
}

  library(KoNLP)
all.reviews

install.packages("tm")
install.packages("wordcloud2")
library(wordcloud2)
####명사추출
data <- all.reviews
tSource <- VectorSource(data)
myCorpus <- Corpus(tSource)
inspect(myCorpus)

for (i in seq_along(myCorpus)) {
  myCorpus[[i]]$content <- gsub("영화", " ", myCorpus[[i]]$content )
  myCorpus[[i]]$content <- gsub("\r", " ", myCorpus[[i]]$content )
  myCorpus[[i]]$content <- gsub("ㅋㅋㅋㅋㅋ", " ", myCorpus[[i]]$content )
}
Encoding(tdm$dimnames$Terms)='UTF-8'
tdm <- TermDocumentMatrix(myCorpus, control=list(tokenize="scan", wordLengths=c(2,7)))
inspect(tdm)
Encoding(tdm$dimnames$Terms)='UTF-8'
m <- as.matrix(tdm)
m

nTerms(tdm)




# 명사추출
nouns <- sapply(all.reviews, extractNoun, USE.NAMES=F)  # nouns : 리스트
nouns <- unlist(nouns)
nouns
### 쓸데없는 단어 삭제 및 빈도 확인 
nouns <- gsub("\\d+","", nouns)
nouns <- gsub("\t","", nouns)
nouns <- gsub("[a-zA-Z]","", nouns)
nouns <- gsub("영화","", nouns)
nouns <- gsub("장동건","", nouns)
nouns <- gsub("현빈","", nouns)
nouns <- gsub("^ㅋ^ㅋ^ㅋ^ㅋ^ㅋ","", nouns)
nouns <- gsub("평점","", nouns)
nouns <- gsub("배우","", nouns)
nouns <- gsub("창궐","", nouns)
nouns <- nouns[nchar(nouns)>=2]
nouns

wordFreq <- table(nouns)
wordFreq <- sort(wordFreq, decreasing=T)


len = length(wordFreq)
wdFreq1 <- wordFreq[1:100] 
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
wc2<-wordcloud2(data=wdFreq1, size = 0.4, color = "random-light", backgroundColor = "grey",rotateRatio = 0.75)
wc2
