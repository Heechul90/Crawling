###. 20대가 가장 많이 본 뉴스(naver)

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
url <- 'https://news.naver.com/main/ranking/popularDay.nhn?rankingType=age&subType=20'
html <- read_html(url)

news_list <- read_html(url) %>%
  html_nodes('.ranking') %>%
  html_nodes('li')
news_list


headline <- c()
view <- c()

for(li in news_list) {
  ranking_headline <- html_nodes(li, '.ranking_headline')
  headline <- c(headline, trim(html_text(ranking_headline, 'em')))
  ranking_view <- html_nodes(li, '.ranking_view')
  view <- c(view, trim(html_text(ranking_view, 'em')))
}
headline
view

ranking <- data.frame(headline = headline, view = view )
ranking



