###. 한빛아카데미 도서 크롤링

setwd('D:/Heechul/01_Crawling')

## CSS 적용방법
# 1. tag에서 attribute 를
# 2. <head> ㄴㅅㅁㅎㄷ </head>
# 3. 별도 활용


###. 필요 패키지
library(curl)
library(httr)
library(rvest)
library(RSelenium)
library(dplyr)
library(stringr)
trim <- function(x) gsub("^\\s+|\\$", '', x)

###. 
base_url <- 'http://www.hanbit.co.kr/academy/books/category_list.html?page=1&cate_cd=004007&srt=p_pub_date'
html <- read_html(base_url)
html
book_list <- html_node(html, '.sub_book_list_area')
book_list
lis <- html_nodes(book_list, 'li')
lis
lis <- read_html(base_url) %>%
  html_nodes('.sub_book_list_area') %>%
  html_nodes('li')
lis

## rvest의 동작순서서(text가져오기)
# 1) html 문서 데이터 가져오기
# 2) 필요한 노드 선택하기
# 3) 노드내에 text를 가져오기
lis <- read_html(base_url) %>%
  html_nodes('.sub_book_list_area') %>%
  html_nodes('li')
lis

for(li in lis) {
  price <- html_text(li, '.price')
  price <- gsub('\\\\', '', price)
  print(price)
}

price <- c()
title <- c()
writer <- c()

for(li in lis){
  pr <- html_text(li, '.price') %>% html_text()
  pr <- gsub('\\\\','', price)
  price <- c(price, pr)
  title <- c(title, html_nodes(li, '.book_tit') %>% html_text())
  writer <- c(writer, html_nodes(li, '.book_writer') %>% html_text())
  print(price)
}

books <- data.frame(title=title, writer=writer, price=price)