require(rvest)

Ejemplo_1 <- read_html('https://practicewebscrapingsite.wordpress.com/example-1')

Titulo <- html_nodes(Ejemplo_1, 'strong') %>% html_text()
Texto <- html_nodes(Ejemplo_1, '.Content') %>% html_text()
Imagenes <- html_nodes(Ejemplo_1, '#post-25 img') %>% html_attr('src')

Ejemplo_2 <- read_html('https://practicewebscrapingsite.wordpress.com/example-2')

Titulo <- c()
Encabezado <- html_nodes(Ejemplo_2, '.entry-title') %>% html_text()
Titulo <- c(Titulo, Encabezado)

# Extraemos los links
Links <- html_nodes(Ejemplo_2, '.Links a') %>% html_attr('href')

# Usar cada uno de los enlaces almacenados para visitar una página web 
# mediante un bucle for, que repite un bloque de código. 
Titulo <- c()
for (i in Links){
  Ejemplo_2 <- read_html(i)
  Encabezado <- html_nodes(Ejemplo_2, '.entry-title') %>% html_text()
  Titulo <- c(Titulo, Encabezado)
}

Paginas <- seq(0,1,1)

Ejemplo_4 <- c()

for (i in Paginas){
  Sys.sleep(2)
  urls <- paste('https://practicewebscrapingsite.wordpress.com/example-4-page-',i,'', sep='')
  Ejemplo_4 <- list(Ejemplo_4, read_html(urls))
}

Ejemplo_4[[1]] <- Ejemplo_4[[1]][[2]]
