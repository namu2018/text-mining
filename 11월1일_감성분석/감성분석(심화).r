

## 01. 데이터 준비
## 02. 긍정단어 부정단어 불러오기
## 03. 불러온 텍스트 전처리
## 04. 감성 분석을 위한 점수


## 01. 데이터 준비 및 사전 준비
rm(list=ls())
library(wordcloud)
library(KoNLP)
useSejongDic()
setwd("C:/Users/ktm/Documents/choi_dontouch/R-basic/11월1일_감성분석")
fname = "30_AgainCourt.txt"
road1 = readLines(fname)

## 02. 긍정단어 부정단어 불러오기
pos.words=scan("positive-words-ko-v2.txt", what="character", comment.char=";",encoding="UTF-8")
neg.words=scan("negative-words-ko-v2.txt", what="character", comment.char=";",encoding="UTF-8")



func <- function(sentence, pos.words,neg.words,progress='none')
{
  require(plyr)
  require(stringr)
  progress='test'
  
  scores <- laply(sentence, function(lines, pos.words,neg.words, progress){
    lines <- gsub('\\d+','',lines)##숫자를 공백으로 변경해라
    lines <- gsub('[[:cntrl:]]','',lines) ###\n,\r같은 공백제거
    lines <- gsub('[[:punct:]]','',lines)
    ##lines <- tolower(lines)
    word.list <- str_split(lines,'\\s+')
    words <- unlist(word.list)
    pos.matches <- match(words, pos.words)##긍정단어사전에 내가 한 단어 위치가 어디?
    neg.matches <- match(words, neg.words)##부정단어사전에 내가 한 단어 위치가 어디?
    
    pos.matches <- !is.na(pos.matches)##TRUE개수가 10개 있다면 10개의 긍정단어
    neg.matches <- !is.na(neg.matches)
    score <- sum(pos.matches) - sum(neg.matches)
    return(score)
  },  pos.words, neg.words, progress=progress)
  scores.df <- data.frame(score=scores, text=sentence)
  return(scores.df)
}

all.score <- func(road1, pos.words,neg.words,progress='text')
all.score

a <- as.numeric(all.score$score)
hist(a, breaks=10)
