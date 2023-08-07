
# Parte I - Paquete -------------------------------------------------------

# Cargamos los paquetes necesarios para el análisis web y la manipulación de datos
require(rvest)
require(tibble)

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

# Creamos un tibble vacío llamado "la_nacion" para almacenar la información de las noticias
la_nacion <- tibble()

# Bucle "for" que recorre cada enlace (link) obtenido previamente desde la URL
for (link in links) {
  
  # Leemos el contenido HTML de la noticia utilizando la función "read_html" de la librería "rvest" y lo almacenamos en la variable "l"
  l <- read_html(link)
  
  # Creamos un nuevo tibble con la información extraída de la noticia actual (fecha, titular, nota y enlace) y lo añadimos a "la_nacion" utilizando la función "rbind"
  la_nacion <- rbind(
    la_nacion,
    tibble(
      
      # Extraemos la fecha de la noticia utilizando la clase CSS '.com-date.--twoxs' 
      # y lo almacenamos en la variable "fecha"
      fecha   = html_text2(html_elements(l, '.com-date.--twoxs')),
      
      # Extraemos el titular de la noticia utilizando la clase CSS 'h1.com-title' 
      # y lo almacenamos en la variable "titular"
      titular = html_text2(html_elements(l, 'h1.com-title')),
      
      # Extraemos el contenido de la noticia utilizando la clase CSS '.com-paragraph' 
      # y lo concatenamos con ' | ' para separar los párrafos
      # Luego, lo almacenamos en la variable "nota"
      nota    = paste0(html_text2(html_elements(l, '.com-paragraph')), collapse = ' | '),
      
      # Finalmente, copiamos el link escrapeado
      hiper   = link
    )
  )
}

# Imprimimos el DataFrame resultante con la información de las noticias extraídas
la_nacion
