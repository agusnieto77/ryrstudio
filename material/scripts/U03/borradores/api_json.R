library(rvest)
url <- 'https://www.theglobaleconomy.com/download-data.php'
read_html(url) |> html_elements('.definition') |> html_text2()


api_key <- '44c0d51eceac441fa69b2512c176a047'

library(crul)

url <- "https://uk.indeed.com/jobs?q=r&l=scotland"

rm(url)

SCRAPFLY_KEY <- api_key

scrapfly <- function(url,
                     render_js = FALSE,
                     wait_for_selector = NULL,
                     asp = FALSE,
                     country = "us",
                     proxy_pool = "public_datacenter_pool") {
  url_build("https://api.scrapfly.io/scrape", query = list(
    key = SCRAPFLY_KEY,
    url = url,
    asp = if (asp) "true" else "false",
    render_js = if (render_js) "true" else "false",
    wait_for_selector = wait_for_selector,
    country = country,
    proxy_pool = proxy_pool
  ))
}


response <- HttpClient$new(scrapfly('https://httpbin.org/headers'))$get()
response_with_javascript_render <- HttpClient$new(scrapfly('https://httpbin.org/headers', render_js = TRUE))$get()
data <- jsonlite::fromJSON(response$parse())
print(data$result$content)
print(data$result$response_headers)
print(data$result$cookies)
print(data$config)
