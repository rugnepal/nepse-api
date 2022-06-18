library(rvest)
library(janitor)
library(dplyr)

daily_data <- readRDS("./data/nepse-daily-data-2079.rds")

url <- "https://www.sharesansar.com/today-share-price"

share_tbl <- read_html(url) %>%
  html_nodes(xpath = "//*[@id='headFixed']") %>%
  html_table() %>%
  data.frame() %>%
  clean_names() %>%
  mutate(date = Sys.Date())

bind_rows(share_tbl, daily_data) %>%
  distinct(symbol, date, .keep_all = T) %>%
  saveRDS(paste0("./data/nepse-daily-data-2079.rds"))






