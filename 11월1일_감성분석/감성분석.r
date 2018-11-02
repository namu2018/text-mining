##01. 데이터 준비
##02. 긍정단어, 부정단어
##03. 불러온 텍스트 전처리
##04. 감성분석을 위한 점수


##01. 데이터 준비 및 사전준비
##세종 DIC, KoNLP, 파일:

rm(list=ls())
library(KoNLP)
useSejongDic()
fname="./30_AgainCourt.txt"
road1 <- readLines(fname)

###02. 긍정단어 부정단어 불러오기
pos.words=scan("positive-words-ko-v2.txt", what="character", comment.char=";",encoding="UTF-8")
neg.words=scan("negative-words-ko-v2.txt", what="character", comment.char=";",encoding="UTF-8")

###03.의미없는 단어 제거
pos.words <- gsub("사보타주사상자사생아사악","",pos.words)
sentences <- road1
sentences <- gsub('\\d+','',sentences)##숫자를 공백으로 변경해라
sentences <- gsub('[[:cntrl:]]','',sentences) ###\n,\r같은 공백제거
sentences <- gsub('[[:punct:]]','',sentences)

head(road1)

wordlist <- sapply(sentences, extractNoun, USE.NAMES=F)
class(wordlist)
words <- unlist(wordlist)

###04. 감성분석

match(words,c("진짜","변호사"))
pos.matches <- match(words, pos.words)
neg.matches <- match(words, neg.words)
pos.matches <- !is.na(pos.matches)
neg.matches <- !is.na(neg.matches)      
sum(pos.matches)
sum(neg.matches)
