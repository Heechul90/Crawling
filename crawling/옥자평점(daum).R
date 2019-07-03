### 

setwd('D:/Heechul/Crawling')

###. 필요 패키지
library(xlsx)
library(writexl)
library(curl)
library(httr)
library(rvest)
library(RSelenium)
library(dplyr)
library(stringr)
trim <- function (x) gsub("^\\s+|\\s+$", "", x)


base_url <- 'https://movie.daum.net/moviedb/grade?movieId=97728&type=netizen&page='

final_df <- data.frame(댓글=c(), 평점=c(), 닉네임=c(), 날짜=c())

for(page in 1 : ceiling(1660/10)) {
  url <- paste0(base_url,page)
  content <- read_html(url) 
  
  reple <- html_nodes(content, '.desc_review') %>%
    html_text()
  reple <- gsub("^\\s+|\\s+$", "", reple)
  
  score <- html_nodes(content, '.emph_grade') %>%
    html_text()
  
  nickname <- html_nodes(content, '.link_profile') %>%
    html_text()
  
  date <- html_nodes(content, '.info_append') %>%
    html_text()
  date <- gsub("^\\s+|\\s+$", "", date)
  date <- gsub("\\.", "-", date)
  
  one_df <- data.frame(댓글 = reple, 평점 = score, 닉네임 = nickname, 날짜 = date)
  
  final_df <- rbind.data.frame(final_df, one_df) 
}

write.xlsx(final_df, 
           'review(daum).xlsx',
           col.names=TRUE,   # 변수이름을 그대로 사용
           row.names=FALSE)  # 행이름은 사용하지 않음

