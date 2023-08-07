# Parte I - Librerías -----------------------------------------------------

# Cargamos las librerías necesarias para el scraping y el manejo de datos
require(rvest)    # Para realizar scraping de datos de sitios web
require(RSelenium) # Para usar Selenium WebDriver para interactuar con sitios web
require(dplyr)     # Para manipulación y análisis de datos

# Parte II - Solo con rvest -----------------------------------------------

# Definimos la URL del sitio web de donde extraeremos la información de las noticias
url <- 'https://www.clarin.com/economia/'

# Realizamos el scraping de los enlaces (links) de las noticias económicas utilizando rvest
# Seleccionamos los elementos HTML que contienen los enlaces con la clase '.content-nota a'
# Luego, obtenemos los atributos 'href' (los enlaces) y los convertimos a URLs absolutas
# Finalmente, eliminamos duplicados para obtener los enlaces únicos
ce <- read_html(url) |> 
  html_elements('.content-nota a') |> 
  html_attr('href') |> url_absolute(url) |> unique()

# Parte III - Selenium ----------------------------------------------------

# Realizamos el scraping de los enlaces (links) de las noticias económicas utilizando Selenium WebDriver
# Configuramos el servidor de Selenium para usar el navegador Firefox, en el puerto 2222
# chromever es la versión del navegador Chrome a utilizar
url <- 'https://www.clarin.com/economia/'
servidor <- rsDriver(browser = "firefox", port = 1122L, chromever = "108.0.5359.22")
cliente <- servidor$client             
cliente$navigate(url) 

# Realizamos un scroll en la página para cargar más noticias
scroll <- cliente$findElement("css", "body")

# Repetimos el scroll tres veces (podría ser más o menos según el sitio web)
for (i in 1:3) {
  scroll$sendKeysToElement(list(key = "end"))   # Scroll hacia el final de la página
  scroll$sendKeysToElement(list(key = "up_arrow")) # Scroll hacia arriba para cargar más noticias
  Sys.sleep(3) # Esperamos 3 segundos para que cargue el contenido
}

# Extraemos los enlaces (links) de las noticias económicas utilizando rvest desde la página actualizada por Selenium
CE <- cliente$getPageSource()[[1]] |> 
  read_html() |> 
  html_elements('.content-nota a') |> 
  html_attr('href') |> 
  url_absolute(url) |> 
  unique()

# Cerramos el cliente actual del servidor de Selenium WebDriver.
servidor$client$close()

# Abrimos un nuevo cliente del servidor de Selenium WebDriver. Esto puede ser útil para iniciar una nueva sesión en el navegador web.
servidor$client$open()

# Cerramos nuevamente el cliente del servidor de Selenium WebDriver. Esto puede realizarse por diversas razones, como liberar recursos o finalizar la sesión actual en el navegador web.
servidor$client$close()

# Finalmente, detenemos el servidor de Selenium WebDriver. Esto es importante para liberar los recursos del servidor y cerrar todas las sesiones y conexiones asociadas a él.
servidor$server$stop()


# Finalmente, obtenemos los enlaces (links) de las noticias económicas de ambas partes (solo con rvest y con Selenium)
CE
