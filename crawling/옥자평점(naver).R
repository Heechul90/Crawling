### 옥자평점 crawling

setwd('D:/Heechul/Crawling')

ceiling(18028/10)
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

# 링크 가져와서 찾아가기
base_url <- 'https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=143435&type=after&onlyActualPointYn=N&order=newest&page='

# 총페이지 구하기
ems <- read_html(base_url) %>%
  html_nodes('div.score_total') %>%
  html_nodes('em')

pages <- ems[2] %>% html_text()
pages <- gsub(',', '', pages)
pages <- as.numeric(pages)
total_page <- ceiling(pages)
total_page

#
df_points <- data.frame(reple=c(), score=c(), date=c(), nickname=c())

for(page in 1 : total_page) {
  url <- paste0(base_url,page)
  content <- read_html(url) 
  
  node_1 <- html_nodes(content, '.score_reple p')
  node_2 <- html_nodes(content, '.score_result .star_score em')
  node_3 <- html_nodes(content, '.score_reple dt em:nth-child(2)')
  node_4 <- html_nodes(content, '.score_reple dt em') %>%
    html_nodes('a')

  
  
  reple_list <- trim(html_text(node_1))
  score_list <- trim(html_text(node_2))
  date_list <- trim(html_text(node_3))
  date_list <- gsub('\\.', '-', date_list)
  nickname_list <- html_text(node_4, 'href')
  nickname_list <- gsub("^\\s+|\\s+$", "", nickname_list)
    
  one_df <- data.frame(reple=reple_list, score=score_list, date=date_list, nickname=nickname_list)
  #print(score)
  df_points <- rbind.data.frame(df_points, one_df)  
}

head(df_points)
write.xlsx(df_points, 
           'review(naver).xlsx',
           col.names=TRUE,   # 변수이름을 그대로 사용
           row.names=FALSE)  # 행이름은 사용하지 않음
