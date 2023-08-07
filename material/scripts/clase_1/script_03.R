
# Parte I - Paquete -------------------------------------------------------

# Cargamos el paquete necesario para el análisis web
require(rvest)

# Parte II - La Nación ----------------------------------------------------

# Definimos una URL a partir de la cual extraeremos información sobre noticias económicas
url <- 'https://www.lanacion.com.ar/economia/'

# Creamos conjuntos de objetos vacíos para almacenar la información de las noticias
# links: lista de enlaces de las noticias
links <- c()

# Variables para almacenar la información de cada noticia
fechas    <- c()   # fechas de publicación
titulares <- c()   # titulares de las noticias
notas     <- c()   # párrafos de las noticias
hipers    <- c()   # enlaces originales de las noticias

# Creamos un DataFrame vacío para almacenar la información de todas las noticias
la_nacion <- data.frame()

# Corremos el código para extraer los enlaces (links) de las noticias económicas de la URL
links <- url_absolute(
  html_attr(
    html_elements(
      read_html(url), 
      xpath='//*[@id="content-main"]/div[1]/div[14]/div[1]/div/article/section/h2/a'), 
    'href'), 
  url)

# Corremos el for para extraer el contenido de los enlaces (links) escrapeados
# Cada enlace representa una noticia en el sitio web de La Nación
for(link in links){
  l <-  read_html(link)
  fechas    <- append(fechas,    
                      html_text2(html_elements(l, '.com-date.--twoxs')))    # Extraemos la fecha de publicación
  titulares <- append(titulares, 
                      html_text2(html_elements(l, 'h1.com-title')))         # Extraemos el titular de la noticia
  notas     <- append(notas,     
                      list(html_text2(html_elements(l, '.com-paragraph')))) # Extraemos los párrafos de la noticia
  hipers    <- append(hipers, 
                      link)                                                 # Almacenamos el enlace original de la noticia
}

# Corremos otro for para organizar los contenidos escrapeados y crear un data.frame
# El data.frame "la_nacion" almacenará la información de las noticias obtenidas
for(i in 1:length(links)) {
  # Creamos una nueva fila para cada noticia y almacenamos la fecha, titular, párrafos y enlace original
  la_nacion <- rbind(la_nacion, 
                     data.frame(fecha=fechas[i], 
                                titular=titulares[i], 
                                nota=paste0(notas[[i]], collapse = ' | '), 
                                hiper=hipers[i]))
}

# Convertimos el resultado en un tibble para imprimirlo en un formato más legible
tibble::as_tibble(la_nacion)
