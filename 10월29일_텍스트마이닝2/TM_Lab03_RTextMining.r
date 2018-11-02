library(tm)
library(KoNLP)
search()

## 경로 지정하여 해당 파일 확인
dir("D:/dataset/nsmc/dir_multi")

library(tm)
setwd("D:/dataset/nsmc")
myCorpus <- VCorpus(DirSource("dir_multi", pattern="txt"))
myCorpus

str(myCorpus[[1]])

content(myCorpus[[1]])

lapply(myCorpus, content)

meta(myCorpus[[3]])

meta(myCorpus[[1]], tag='etc') <- "메타정보추가"
meta(myCorpus[[1]])

for (i in seq_along(myCorpus)) {
    myCorpus[[i]]$content <- paste(myCorpus[[i]]$content, collapse=" ")
}

myCorpus[[5]]$content

myCorpus <- tm_map(myCorpus, removePunctuation)     # 특수문자 제거 

myCorpus <- tm_map(myCorpus, removeNumbers)         # 숫자 제거하기

myCorpus <- tm_map(myCorpus, stripWhitespace)       # 공백제거
myCorpus[[1]]$content

myCorpus <- tm_map(myCorpus, removeWords, stopwords('english')) ## 불용어 제거하기 


myCorpus[[5]]$content

library(SnowballC)
myCorpus <- tm_map(myCorpus, stemDocument)
myCorpus[[3]]$content

library(stringr)

loc1= str_locate(myCorpus[1]$content, "label")[2]
loc1
loc2= str_locate(myCorpus[1]$content, "meta")[1]
loc2

kst <- c("그리고", "아니라는거", "될거가틈", "잘될듯")
rm_words <- paste(kst, collapse="|")
for (i in seq_along(myCorpus)) {
    myCorpus[[i]]$content <- str_replace_all(myCorpus[[i]]$content, rm_words, " ")
    loc2= str_locate(myCorpus[i]$content, "meta")[1]
    myCorpus[[i]]$content <- str_sub(myCorpus[[i]]$content, start=1, end=loc2)
}


myCorpus[[5]]$content

library(KoNLP)
library(NIADic)
useNIADic()  # K-ICT 빅데이터 센터 사전 

for (i in seq_along(myCorpus)) {
    myCorpus[[i]]$content <- gsub("볼 수록", "볼수록", myCorpus[[i]]$content )
    myCorpus[[i]]$content <- gsub("이쁨터짐", "이쁨 터짐", myCorpus[[i]]$content )
}

myCorpus[[3]]$content

#new_word <- c("성룡형님", "초딩")
#new_dic <- data.frame(new_word, "ncn")
#buildDictionary(ext_dic=c("sejong","woorimalsam", "insighter"), user_dic=new_dic)

#extractNoun(myCorpus[[1]]$content)
#nouns[nchar(nouns) > 2]
#paste(nouns, collapse=" ")
myCor_tdm
myCor_tdm <- TermDocumentMatrix(myCorpus, control=list(tokenize="scan", wordLengths=c(2,7)))
inspect(myCor_tdm)

nTerms(myCor_tdm)

nDocs(myCor_tdm)

Terms(myCor_tdm)[nchar(Terms(myCor_tdm)) >= 2 & nchar(Terms(myCor_tdm)) <= 4]

findFreqTerms(myCor_tdm, lowfreq=3, highfreq=Inf)

findAssocs(myCor_tdm, c("택시", "중국영화"), c(0.5))

myCor_tdm <- removeSparseTerms(myCor_tdm, sparse=0.90)
myCor_tdm
frequency <- row_Sums(myCor_tdm)
frequency <- sort(frequency, decreasing = T)
wordFreq = slam::row_sums(myCor_tdm)
wordFreq = sort(wordFreq, decreasing=TRUE)
wordFreq

library(wordcloud)
pal <- brewer.pal(8, "Dark2")
w = names(wordFreq)
wordcloud(words=w, freq=wordFreq, 
         min.freq=3, random.order=F,
         random.color=T, colors=pal)

rm.idx <- grep("[있습니다|이거|영화|나는|보는|그런|그냥|것을]",names(wordFreq))
wordFreq1 <- wordFreq[-rm.idx]
wordFreq1

w1 <- names(wordFreq1)
wordcloud(words=w1, freq=wordFreq, 
         min.freq=3, random.order=F,
         random.color=T, colors=pal)

tds <- myCor_tdm[Terms(myCor_tdm) %in% w1, ]
m2 <- as.matrix(tds)
colnames(m2) <- gsub(".txt", "", colnames(m2))
distMatrix <- dist(scale(m2))
fit <- hclust(distMatrix, method="ward.D")
plot(fit, xlab="", sub="", main="clustering 키워드")
rect.hclust(fit, k=7)

tds <- myCor_tdm[Terms(myCor_tdm) %in% w1, ]
m2 <- as.matrix(tds)

tm2 <- t(m2)
distMatrix <- dist(scale(tm2))

fit <- hclust(distMatrix, method="ward.D")
plot(fit, xlab="", sub="", main="clustering 키워드")
rect.hclust(fit, k=3)

tds1 <- weightTfIdf(myCor_tdm)
M <- t(as.matrix(tds1))
M
