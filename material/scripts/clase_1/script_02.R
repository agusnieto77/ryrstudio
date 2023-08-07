# Parte I - Paquetes ------------------------------------------------------

# Cargamos los paquetes necesarios para el análisis
require(polite)
require(rvest)

# Parte II - Ámbito Financiero ------------------------------------------------

# Definimos una URL para el sitio web Ámbito Financiero
url <- 'https://www.ambito.com/contenidos/'

# Creamos una lista de URLs de las páginas que queremos escrapear
urls <- c(paste0(url, 'economia.html/', 1:4),
          paste0(url, 'finanzas.html/', 1:4))

# Imprimimos los links
urls

# Creamos un conjunto de objetos vacíos para almacenar información

# Vector para almacenar los links
links <- c()

# Vectores para almacenar información de las noticias
fechas    <- c()
titulares <- c()
notas     <- c()
hipers    <- c()

# Creamos un DataFrame vacío para almacenar los datos finales
ambito_financiero <- data.frame()

# Corremos un loop for para extraer los links de las noticias
for (url in urls) {
  # Utilizamos la función 'scrape' de polite para obtener el HTML de la URL
  # Luego, utilizamos rvest para extraer los links de las noticias
  links <- append(links, scrape(bow(url)) |>
                    html_elements('h2.news-article__title a') |>
                    html_attr('href'))
}

for (url in urls) {
  # Utilizamos read_html para obtener el HTML de la URL
  # Luego, utilizamos rvest para extraer los links de las noticias
  links <- append(links, read_html(url) |>
                    html_elements('h2.news-article__title a') |>
                    html_attr('href'))
}

# Eliminamos duplicados de los links
links <- unique(links)

# Imprimimos los links obtenidos
links

# Corremos un loop for para extraer el contenido de las noticias utilizando los links obtenidos anteriormente
for (link in links) {
  l <- read_html(link)
  
  # Extraemos las fechas de publicación de las noticias
  fechas    <- append(fechas, html_text2(html_elements(l, 'span.news-headline__publication-date, span.news-headline-lbp__publication-date')))
  
  # Extraemos los titulares de las noticias
  titulares <- append(titulares, html_text2(html_elements(l, 'h1.news-headline__title, h1.news-headline-lbp__title')))
 
   # Extraemos el contenido de las noticias
  notas     <- append(notas, paste(
    html_text2(
      html_elements(
        l, 
        'div.col-12.col-md-8.detail-news__main-column article.article-body, 
        div.col-12.col-md-9.detail-news-lbp__news-content')), 
    collapse = "\n\n"))
  
  # Almacenamos el link de la noticia
  hipers    <- append(hipers, link)
}

# Imprimimos las fechas de las noticias
fechas

# Imprimimos los titulares de las noticias
titulares

# Imprimimos el contenido de las noticias
notas

# Imprimimos los links de las noticias
hipers

# Corremos un loop for para crear un DataFrame con la información de las noticias
for (i in 1:length(links)) {
  ambito_financiero <- rbind(ambito_financiero, data.frame(
    fecha   = fechas[i], 
    titular = titulares[i], 
    nota    = notas[i], 
    hiper   = hipers[i])
  )
}

# Imprimimos el DataFrame obtenido
as_tibble(ambito_financiero)

# Removemos el texto adicional de las fechas
ambito_financiero$fecha <- sub(" - .*$", "", ambito_financiero$fecha)

# Convertimos las fechas a formato fecha
ambito_financiero$fecha <- as.Date(ambito_financiero$fecha, format = "%d de %B %Y")

# Imprimimos el DataFrame con las fechas formateadas
as_tibble(ambito_financiero)
