
# Ejemplo de Web Scraping -----------------------------------------------------------------

# Cargar el paquete 'rvest' para realizar web scraping
require(rvest)

# Definir la URL a scrapear
url <- paste0('https://eleconomista.com.ar/finanzas/?p=', 1:10)

# Imprimir la URL
url

# Crear un vector vacío para almacenar la información obtenida del web scraping
resumen <- c()

# Iterar sobre cada URL en el vector 'url'
for (i in url) {
  # Imprimir un mensaje que indica qué URL se está scrapeando
  message(paste0('Estoy escrapeando la url -> ', i))

  # Realizar web scraping del contenido HTML de la URL, extraer los elementos deseados y convertirlos a texto
  resumen <- append(resumen, read_html(i) |> html_elements('div.info') |> html_text2())
}

# Imprimir los primeros dos elementos del vector 'resumen'
resumen[1:2]

# Instalar el paquete 'ACEP' si aún no está instalado
# install.packages("devtools")
# devtools::install_github("agusnieto77/ACEP")

# Cargar el paquete 'ACEP'
require(ACEP)

# Limpiar el texto obtenido del web scraping utilizando el paquete 'ACEP',
# eliminando las palabras indicadas en 'other_sw'
resumen_limpio <- acep_cleaning(resumen, other_sw = c("panorama", "us", "días", "sigue"))

# Imprimir los primeros dos elementos del vector 'resumen_limpio'
resumen_limpio[1:2]

# Tokenizar el texto limpio utilizando el paquete 'ACEP'
texto <- acep_token(resumen_limpio)

# Imprimir las primeras entradas del objeto 'texto'
head(texto)

# Generar una tabla de frecuencia de tokens utilizando el paquete 'ACEP'
acep_token_table(texto$token, u=15)

# Generar un gráfico de frecuencia de tokens utilizando el paquete 'ACEP'
acep_token_plot(texto$token, u=15, frec = F)
