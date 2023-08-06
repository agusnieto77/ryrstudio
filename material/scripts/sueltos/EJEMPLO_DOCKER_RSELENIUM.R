shell('docker run -d -p 4445:4444 selenium/standalone-firefox')
require(RSelenium)
require(rvest)
remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4445L, browserName = "firefox")
remDr$open()
remDr$navigate("http://www.google.com/ncr")
remDr$getTitle()


url <- 'https://www.clarin.com/politica/'
         
remDr$navigate(url) 

scroll <- remDr$findElement("css", "body")

for (i in 1:300) {
  scroll$sendKeysToElement(list(key = "end"))
  scroll$sendKeysToElement(list(key = "up_arrow"))
  Sys.sleep(3)
}



cp <- remDr$getPageSource()[[1]] |> 
  read_html() |> 
  html_elements('.content-nota a') |> 
  html_attr('href') |> 
  url_absolute(url)

cp |> unique()
