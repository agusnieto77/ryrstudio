
# Sin API -----------------------------------------------------------------

require(rvest)

url <- paste0('https://www.rionegro.com.ar/ahora/?pag=',1:10)

url

titulos <- c()

for (i in url) {
  print(paste0('Estoy escrapeando la url -> ', i))
  titulos <- append(titulos, read_html(i) |> html_elements('h2.news__title') |> html_text2())
}

# install.packages("devtools")
devtools::install_github("agusnieto77/ACEP")

require(ACEP)

titulos_limpios <- acep_clean(titulos)

texto <- acep_token(titulos_limpios)

acep_token_table(texto$token, u=20)

acep_token_plot(texto$token, u=20, frec = F)


# Con API ----------------------------------------------------------------

require(rtweet)

auth_setup_default()

tweets <- search_tweets(q='feminismo', n = 1000, include_rts = FALSE)

require(ACEP)

tweets$full_text2 <- gsub('feminismo', '', tolower(tweets$full_text))

tweets_limpios <- acep_clean(tweets$full_text2)

texto <- acep_token(tweets_limpios)

acep_token_table(texto$token)

acep_token_plot(texto$token, u=20)
