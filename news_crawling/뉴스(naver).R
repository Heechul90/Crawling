### 뉴스 crawling (naver)

setwd('D:/Heechul/Crawling')


###. 필요 패키지
install.packages('xlsx')
library(xlsx)
library(writexl)
library(curl)
library(httr)
library(rvest)
library(RSelenium)
library(dplyr)
library(stringr)
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

# 링크 가져와서 찾아가기
base_url <- 'https://news.naver.com/main/list.nhn?mode=LS2D&sid2=228&mid=shm&sid1=105&date='

date <- 20190701:20190703
page <- 1:5

news_title <- c()
news_url <- c()
news_date <- c()

for(dt in date) {
  for(page_num in page) {
    url <- paste0(base_url, dt, '&page=', page_num)
    html <- read_html(url)
    
    title <- html_nodes(html, '#main_content') %>%
      html_nodes(css = '.list_body') %>%
      html_nodes(css = '.type06_headline') %>%
      html_nodes('a') %>%
      html_text('href')
    title <- gsub("^\\s+|\\s+$", "", title)
   
    title_url <- html_nodes(html, '#main_content') %>%
      html_nodes(css = '.list_body') %>%
      html_nodes(css = '.type06_headline') %>%
      html_nodes('a') %>%
      html_attr('href')
    
    
   news_title <- c(news_title, title) 
   news_url <- c(news_url, title_url)
   news_date <- c(news_date, rep(dt, length(title)))
   
   
   news <- data.frame(title = news_title, url = news_url, date = news_date)
   
  }
}

write.xlsx(news,
           "news_crawling.xlsx", 
           sheetName="news",
           col.names=TRUE,   
           row.names=FALSE)  

write.xlsx(attitude,             # R데이터명
           file="d:/test.xlsx",  # 여기서는 기존의 엑셀 파일이라고 설정함
           sheetName="new",  # 기존의 엑셀 파일에 new라는 시트에 데이터를 넣음
           col.names=TRUE,   # 변수이름을 그대로 사용
           row.names=FALSE,  # 행이름은 사용하지 않음
           append=TRUE)      # 기존의 엑셀 파일이 있으면 그곳에 추가해서 저장


