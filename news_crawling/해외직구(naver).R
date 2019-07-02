### 고양이 사료(건식)

setwd('D:/Heechul/Crawling')


###. 필요 패키지
library(curl)
library(httr)
library(rvest)
library(RSelenium)
library(dplyr)
library(stringr)
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

# 링크 가져와서 찾아가기
url <- 'https://shopping.naver.com/foreign/category/10001268'
html <- read_html(url)

list <- html %>%
  html_nodes('._2Aa0HOdzWw') %>%
  html_nodes('li')
list

title <- c()
view <- c()

for(li in list) {
  text_title <- html_nodes(list, '._2yFdmfTRB1')
  title <- c(title, trim(html_text(text_title, 'em')))
}
title


ranking <- data.frame(headline = headline, view = view )
ranking