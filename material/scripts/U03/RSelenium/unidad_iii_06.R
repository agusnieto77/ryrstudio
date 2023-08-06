
# Parte I - Librerías -----------------------------------------------------

require(rvest)
require(RSelenium)
require(dplyr)


# Parte II - Solo con rvest -----------------------------------------------

url <- 'https://www.clarin.com/politica/'

cp <- read_html(url) |> 
  html_elements('.content-nota a') |> 
  html_attr('href') |> url_absolute(url)

# Parte III - Selenium ----------------------------------------------------

url <- 'https://www.clarin.com/politica/'
servidor <- rsDriver(browser = "firefox", port = 1234L)
cliente <- servidor$client             
cliente$navigate(url) 

scroll <- cliente$findElement("css", "body")

for (i in 1:3) {
  scroll$sendKeysToElement(list(key = "end"))
  scroll$sendKeysToElement(list(key = "up_arrow"))
  Sys.sleep(3)
}

cp <- cliente$getPageSource()[[1]] |> 
  read_html() |> 
  html_elements('.content-nota a') |> 
  html_attr('href') |> 
  url_absolute(url)

cp

# https://stackoverflow.com/questions/45395849/cant-execute-rsdriver-connection-refused
