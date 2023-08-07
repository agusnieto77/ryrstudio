
# Parte I - Paquete -------------------------------------------------------

# Cargamos los paquetes necesarios para el análisis web y la manipulación de datos
require(rvest)
require(tibble)
require(purrr)

# Parte II - La Nación ----------------------------------------------------

# Definimos una URL a partir de la cual extraeremos información sobre noticias económicas
url <- 'https://www.lanacion.com.ar/economia/'

# Corremos el código para extraer los enlaces (links) de las noticias económicas de la URL
links <- url_absolute(
  html_attr(
    html_elements(
      read_html(url), 
      xpath='//*[@id="content-main"]/div[1]/div[14]/div[1]/div/article/section/h2/a'), 
    'href'), 
  url)

# Creamos una función llamada "scrape_noticia" para realizar el scraping y obtener información de cada noticia
# Esta función toma como entrada el enlace (link) de una noticia y devuelve un data.frame con la fecha, titular, 
# nota y enlace de la noticia
scrape_noticia <- function(link) {
  l <- read_html(link)
  fecha <- html_text2(html_elements(l, '.com-date.--twoxs'))
  titular <- html_text2(html_elements(l, 'h1.com-title'))
  nota <- paste0(html_text2(html_elements(l, '.com-paragraph')), collapse = ' | ')
  hiper <- link
  
  return(data.frame(fecha = fecha, titular = titular, nota = nota, hiper = hiper))
}

# Realizamos el scraping y almacenamos la información de todas las noticias en un data.frame usando map_df
# La función "map_df" aplicará la función "scrape_noticia" a cada uno de los enlaces en la lista "links"
la_nacion <- map_df(links, scrape_noticia)

# Imprimimos el DataFrame resultante con la información de las noticias extraídas
as_tibble(la_nacion)
