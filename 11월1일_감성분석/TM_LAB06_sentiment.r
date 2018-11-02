

## 01. 데이터 준비
## 02. 긍정단어 부정단어 불러오기
## 03. 불러온 텍스트 전처리
## 04. 감성 분석을 위한 점수


## 01. 데이터 준비 및 사전 준비
rm(list=ls())
library(wordcloud)
library(KoNLP)
useSejongDic()

fname = "30_AgainCourt.txt"
road1 = readLines(fname)

## 02. 긍정단어 부정단어 불러오기
pos.words = scan("pos_kor_words.txt", what="character", comment.char=";")
neg.words = scan("neg_kor_words.txt", what="character", comment.char=";")

## 03. 불러온 텍스트 전처리
#### 사전에 원하는 단어 추가하기
# pos.words = c(pos.word, "기쁘다")
# neg.words = c(neg.word, "바보", "지루")
# length(pos.words)
# length(neg.words)

#### 의미 없는 데이터 제거, 단어 발생 빈도 등을 기반으로 감성 분석 값을 반환.
require(plyr)
require(stringr)
sentence <- road1

# 구두점 문자, ! " # $ % & ’ ( ) * + , - . / : ; < = > ? @ [  ] ^ _ ` { | } ~. 제거
sentence <- gsub('[[:punct:]]', "", sentence)  
# \n, \r 같은 제어문자 등 제거
sentence <- gsub('[[:cntrl:]]', "", sentence)
# 숫자 제거
sentence <- gsub('\\d+', "", sentence)
head(sentence)
length(sentence)   # 문장들의 길이 약 1400여개

#### 명사 추출
wordlist <- sapply(road1, extractNoun, USE.NAMES=F)
words <- unlist(wordlist)   # 단어를 하나의 벡터로 
head(words)
length(words)      # 약 7400여개

## 04. 감성 분석을 위한 점수
pos.matches <- match(words, pos.words)  ## 긍정단어, 부정단어 확인
neg.matches <- match(words, neg.words)  ## 단어 존재(사전에서 위치), 없으면 NA
pos.matches <- !is.na(pos.matches)  # NA가 아닌것 가져오기(문장에 단어 있음)
neg.matches <- !is.na(neg.matches)
sum(pos.matches)  # 점수 합(긍정단어)
sum(neg.matches)  # 점수 합(부정단어) 
score <- sum(pos.matches) - sum(neg.matches)
plot(score, ylim=c(-200, 200))
