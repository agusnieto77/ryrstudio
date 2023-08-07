
# Parte I - Cargamos los paquetes -----------------------------------------

# Cargamos los paquetes necesarios para las tareas de web scraping y procesamiento de datos
library(tidyverse)  # Gestión de datos de uso general
library(rvest)      # Análisis de archivos HTML/XML
library(lubridate)  # Facilita la manipulación de vectores date-time
library(jsonlite)   # Formato JSON

# Parte II - Documentos de texto, imágenes, etc. --------------------------

# Creamos el objeto 'url' en base a un link de Prensa Económica
url <- 'https://prensaeconomica.com.ar/revistas/'

# Seleccionamos y extraemos los links de las revistas
urls <- read_html(url) |> 
  html_elements(xpath = '//*[@id="page-7662"]/div[2]/div/div/div/section/div/div/div[2]/div/div/div[2]/div/div/a') |> 
  html_attr('href')

# Creamos un vector para almacenar los links de los PDFs
links <- c()

# Iteramos sobre los URLs de las revistas y extraemos los links de los PDFs
for (u in urls) {
  html <- read_html(u)
  link <- html_attr(
    html_elements(
      html, 
      css = 'div._3d-flip-book'), 
    'data-pdf')
  links <- append(links, link)
}

# Nombramos y creamos un nuevo directorio para almacenar los PDFs descargados
nuevodir <- paste0(getwd(), "/material/scripts/clase_1/pdfs/")
if (!file.exists(nuevodir))  {
  dir.create(nuevodir)
}

cat('\014')  # Limpiamos la consola para una mejor visualización

# Descargamos los PDFs y los almacenamos en el directorio nuevo
for (i in seq_along(links)) {
  message(paste0('Bajando ', i, '/', length(links), ' documentos...'))
  download.file(url = links[i], destfile = paste0(nuevodir, basename(links[i])), mode="wb")
  cat('\014')
}

# Parte II - Datos estructurados ------------------------------------------

# Creamos el objeto 'url' en base a un link de Wikipedia
url <- 'https://es.wikipedia.org/wiki/Demograf%C3%ADa_de_Argentina'

# Cargar y analizar el DOM (Modelo de Objetos del Documento) del archivo HTML
html <- read_html(url)

# Imprimir el contenido HTML
print(html)

# Seleccionamos las tablas del contenido HTML
tablas <- html_table(html_nodes(html, ".wikitable"))

# Imprimir todas las tablas
tablas

# Imprimir solo la primera tabla
print(tablas[[2]], n = 24)

# Imprimir la tercera y la primera tabla
tablas[c(3,2)]

# Imprimir solo la segunda tabla
print(tablas[[3]], n = 37)

# Borramos todos los objetos creados para liberar memoria
rm(list = ls())

# Limpiamos la consola para una mejor visualización
cat("\014")

# Parte III - Datos no estructurados --------------------------------------

# Creamos el objeto 'url' en base a un link de La Nación
url <- 'https://www.lanacion.com.ar/economia/'

# Cargar y analizar el DOM (Modelo de Objetos del Documento) del archivo HTML
html <- read_html(url)

# Imprimir el contenido HTML
print(html)

# Imprimir el contenido HTML como caracteres
as.character(html)

# Imprimir la estructura jerárquica del contenido HTML
xml2::html_structure(html)

# Seleccionamos nodos de fecha y los convertimos en un vector de fechas
fechas <- html |> 
  html_elements(xpath='//*[contains(@class, "com-date")]') |> 
  html_text2()

# Imprimir las fechas
fechas
class(fechas)

# Transformamos el vector 'fechas' en un vector de clase 'data-time'
fechas <- as_date(fechas, format = '%d de %B de %Y')
class(fechas)
fechas <- as.character(fechas)
fechas <- as_date(fechas)
# Imprimir las fechas
fechas

fechas[1]-365

# Seleccionar los nodos de los titulares
titulares <- html_text2(html_elements(html, 'div.hlp-degrade h2'))

# Imprimir los titulares
titulares

# Seleccionar los nodos de los links
links <- url_absolute(
  html_attr(
    html_elements(
      html, 
      xpath='//*[@id="content-main"]/div[1]/div[14]/div[1]/div/article/section/h2/a'), 
    "href"), 
  url)

# Imprimir los links
links

# Crear una estructura de datos compuesta (lista)

# Creamos un objeto vacío para almacenar los datos
datos <- list()

# Corremos el loop para almacenar los datos de fechas, titulares y links en la lista
for (i in 1:length(titulares)) {
  datos <- append(datos, list(list(fecha=fechas[i], titular=titulares[i], link=links[i])))
}

# Imprimir los datos
datos

# Formatear los resultados de la minería en formato JSON
json <- toJSON(datos)

# Imprimir el JSON
json

# Formatear los resultados de la minería en formato tibble (data frame mejorado)
df <- unnest(fromJSON(json), cols = c(fecha, titular, link))

# Imprimir el tibble
df

# Borramos todos los objetos creados para liberar memoria
rm(list = ls())

# Limpiamos la consola para una mejor visualización
cat("\014")
