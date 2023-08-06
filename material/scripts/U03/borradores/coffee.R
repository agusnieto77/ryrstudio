library(polite)
library(rvest)

url  <- bow('https://www.homestratosphere.com/types-of-coffee-beans/', force = TRUE)

info <- scrape(url)

info2 <- scrape(url) |> html_elements('h2') |> html_text2()

info3 <- scrape(url, query=list(t='Coffee Beans')) |> html_elements('h2') |> html_text2()


url <- 'https://www.theglobaleconomy.com/download-data.php'
scrape(bow(url, force = TRUE)) |> html_elements('.definition') |> html_text2()
