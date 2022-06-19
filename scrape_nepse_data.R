library(rvest, include.only = c("read_html", "html_nodes", "html_table"))
library(janitor, include.only = "clean_names")
library(dplyr, include.only = c("mutate", "bind_rows", "distinct"))
library(readr, include.only = "write_csv")
library(jsonlite, include.only = "write_json")

url <- "https://www.sharesansar.com/today-share-price"
rds_path <- "./data/nepse-daily-data-2079.rds"
csv_path <- "./data/nepse-daily-data-2079.csv"
json_path <- "./data/nepse-daily-data-2079.json"

share_tbl <- read_html(url) %>%
  html_nodes(xpath = "//*[@id='headFixed']") %>%
  html_table() %>%
  data.frame() %>%
  clean_names() %>%
  mutate(
    across(everything(), as.character),
    date = Sys.Date()
  )

save_files <- \() {
  rds <- readRDS(rds_path) %>%
    bind_rows(share_tbl) %>%
    distinct(symbol, date, .keep_all = T)

  saveRDS(rds, rds_path)
  write_csv(rds, csv_path) # toJSON(x = rds, dataframe = 'rows', pretty = T)
  write_json(rds, json_path)
}


save_files()
