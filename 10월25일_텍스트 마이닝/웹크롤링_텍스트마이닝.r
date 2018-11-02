getwd()
install.packages("rvest")
library(rvest)

rm(list=ls())
all.reviews <-c()
url_all=c()

for (i in 1:7){
  test <- paste0('https://movie.daum.net/moviedb/grade?movieId=112415&type=netizen&page=',i)
  url_all=c(url_all, test)
  htxt <- read_html(url_all[i])
  table <- html_nodes(htxt,'.review_info')
  content <- html_node(table,'.desc_review')
  reviews=html_text(content)
  reviews <-gsub('\n','',reviews)
  reviews <-gsub('\t','',reviews)
  all.reviews <- c(all.reviews,reviews)
}


url_all
str(url_all)
str(table)

all.reviews

