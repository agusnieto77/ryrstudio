# Datos en línea para la investigación: conectar, bajar, clasificar, visualizar -----------

## Ordenar y Clasificar (Parte I) --------------

### Ordenar y reordenar datos con dplyr y tidyr

# dplyr es una gramática de manipulación de datos que proporciona un conjunto consistente
# de verbos que lo ayudan a resolver los desafíos más comunes de manipulación de datos:

#      -> mutate()    agrega nuevas variables que son funciones de variables existentes
#      -> select()    elige variables en función de sus nombres.
#      -> filter()    elige casos en función de sus valores.
#      -> summarise() reduce varios valores a un solo resumen.
#      -> arrange()   cambia el orden de las filas.

# El objetivo de tidyr es crear datos ordenados. Los datos ordenados son datos donde:

#      -> Cada columna es variable.
#      -> Cada fila es una observación.
#      -> Cada celda es un valor único.

### Trabajar con dplyr

##### Bajamos y cargamos los datos con funciones las funciones 'download.file' y 'read.table' 

# del paquete 'utils', paquete base de r
# Los paquetes que vamos a usar en este fragmento de código no requieren ser cargados.
# Descarga del registro de femicidio de datos.jus.gob.ar
# creamos el objeto 'url' con la ubicación del archivo que queremos bajar

url <- "http://datos.jus.gob.ar/dataset/27bb9b2c-521b-406c-bdf9-98110ef73f34/resource/583cec9a-3022-4234-8b32-17692a267aac/download/registro-de-femicidios-20200109.csv"

# Imprimimos el objeto url
url

# creamos el objeto 'file' para definir el lugar donde guardar el documento a bajar, con funciones base de r
file <- base::file.path("./material/data", base::basename(url))

# Imprimimos el objeto file
file

# bajamos el documento que nos interesa
utils::download.file(url, file)

# cargamos el documento en el objeto 'femicidios'
femicidios <-
    read.table(file,
               header = TRUE,
               sep = ',',
               stringsAsFactors = FALSE,
               encoding = "UTF-8")

# Utiliza la función head() para mostrar las primeras filas del objeto "femicidios".
# La función head() muestra las primeras 6 filas por defecto.
head(femicidios)

# Estructuras con dplyr
# Inspeccionamos la estructura de los datos con la función 'glimpse' de 'dplyr'
# Cargamos dplyr
require(dplyr)

# Vemos los datos a partir de 'glimpse' es como una versión transpuesta de print(): las columnas corren por la página y los datos se cruzan
glimpse(femicidios)

# Tabla de frecuencias con dplyr
# Con la función 'count' del paquete 'dplyr' creamos una tabla con la frecuencia de femicidios por provincia
# creamos una tabla con los datos de la columna 'hecho_provincia' con la función count de dplyr
tabla_fem <- count(femicidios, hecho_provincia)

# Imprimimos el objeto tabla_fem
tabla_fem

# Renombrar con dplyr
# Renombramos valores de la tabla con la función 'mutate' de 'dplyr'

tabla_fem <- tabla_fem |> mutate(
    hecho_provincia = case_when(
        hecho_provincia == "Ciudad Autónoma de Bs.As." ~ "CABA",
        hecho_provincia == "" ~ "s-d",
        TRUE ~ as.character(hecho_provincia)))

# Imprimimos el objeto tabla_fem
tabla_fem

# Frecuencias con dplyr
# Ahora ordenamos la frecuencia con la función arrange del paquete dplyr
tabla_fem <- tabla_fem |> arrange(desc(n))

# Imprimimos el objeto tabla_fem
tabla_fem

# Filtrar con dplyr
# Con la función 'filter' de 'dplyr' filtramos el valor 's-d' de la columna 'hecho_provincia'
tabla_fem <- tabla_fem |> filter(hecho_provincia != 's-d')

# Imprimimos el objeto tabla_fem
tabla_fem

# Top
# Usamos la función slice_max del paquete dplyr para quedarnos con los primeros cinco registros de la tabla
slice_max(tabla_fem, n, n = 5)

# Renombramos
# Renombramos las variables con la función rename del paquete dplyr
tabla_fem <- rename(tabla_fem, Provincias = hecho_provincia, Femicidios = n)

# Imprimimos el objeto tabla_fem
tabla_fem

# Tablas con knitr
# Mejoramos la estética de la tabla con formattable, knitr y kableExtra
# Instalamos y cargamos formattable, knitr y kableExtra

# install.packages(c('formattable','kableExtra'))

require(formattable)
require(knitr)
require(kableExtra)

# Con los paquetes formattable, knitr y kableExtra creamos una tabla con css bootstrap y gráfico de barras incluido
column_spec(kable_styling(kable(select(mutate(head(tabla_fem, 5),
                    Provincias = Provincias,
                    Femicidios = color_bar("lightgreen")(Femicidios)),
             Provincias, everything()),
      escape = F,
  caption = "<center><span style='font-size:30px'>Femicidios en Argentina</span></center>"),
  "hover", full_width = F, font_size = 16),
  2, width = "10cm")

# Ordenar y Clasificar (Parte 2) ----------

# Trabajar con tidyr

# Cargamos los datos con las funciones 'read.table' del paquete 'utils', paquete base de r
# Definimos la URL del archivo de datos que queremos cargar
url <- "https://raw.githubusercontent.com/carpentries-incubator/open-science-with-r/gh-pages/data/gapminder_wide.csv"

# Utilizamos la función 'read.table' del paquete 'utils' para cargar los datos desde la URL
# El argumento 'header = TRUE' indica que el archivo tiene una fila de encabezados con los nombres de las columnas
# El argumento 'sep = ','' especifica que el separador de columnas es la coma ","
# El argumento 'stringsAsFactors = FALSE' asegura que las cadenas de texto no se conviertan automáticamente en factores
# El argumento 'encoding = "UTF-8"' especifica la codificación del archivo
poblacion <- read.table(url,
                        header = TRUE,
                        sep = ',',
                        stringsAsFactors = FALSE,
                        encoding = "UTF-8")

# Mostramos las primeras filas de la tabla "poblacion"
head(poblacion)

# Vemos la estructura de datos de la tabla "poblacion"
str(poblacion)

# Transformamos la base a formato largo
# Utilizamos las funciones 'pivot_longer' del paquete 'tidyr' para transformar la tabla "poblacion" de formato ancho a largo.
# El argumento 'c(-continent, -country)' indica que las columnas "continent" y "country" se mantendrán como identificadores,
# mientras que el resto de las columnas se convertirán en dos columnas nuevas: "obs_anio" (nombre de la observación y año) y "valor" (valor de la observación).
poblacion_long <- pivot_longer(poblacion, 
                               c(-continent, -country),
                               names_to = "obs_anio",
                               values_to = "valor")

# Mostramos las primeras filas de la tabla "poblacion_long"
head(poblacion_long)

# Vemos la estructura de datos de la tabla "poblacion_long"
str(poblacion_long)

# Separar para crear nuevas columnas
# Utilizamos la función 'separate_wider_delim' del paquete 'tidyr' para separar la columna "obs_anio" en dos columnas: "obs" (nombre de la observación) y "anio" (año).
# También convertimos la columna "anio" a formato numérico utilizando la función 'as.integer'.
gap_long <- mutate(
  separate_wider_delim(
    poblacion_long,
    cols = obs_anio,
    names = c("obs", "anio"),
    delim = "_"),
  anio = as.integer(anio))

# Mostramos las primeras filas de la tabla "gap_long"
head(gap_long)

# Vemos la estructura de datos de la tabla "gap_long"
str(gap_long)

# Separamos para darle la estructura deseada
# Utilizamos la función 'pivot_wider' del paquete 'tidyr' para volver a transformar la tabla "gap_long" en un formato más ancho.
# Las columnas "obs" se convertirán en encabezados de columnas y los valores correspondientes se ubicarán en cada celda.
gap_normal <- pivot_wider(data = gap_long, names_from = obs, values_from = valor)

# Mostramos las primeras filas de la tabla "gap_normal"
head(gap_normal)

# Vemos la estructura de datos de la tabla "gap_normal"
str(gap_normal)

# Algo de tablas para visualización y consultas...
# Cargamos los paquetes 'gapminder' y 'DT' para trabajar con los datos y la visualización de tablas.
# Este código no parece estar conectado directamente con las operaciones anteriores, ya que carga el paquete 'gapminder'
# que proporciona un conjunto de datos incorporado, pero no se utilizó previamente en el código.
require(gapminder)
require(DT)

# Cargamos el conjunto de datos 'gapminder' incorporado en el paquete 'gapminder' en la tabla "tabla02"
data("gapminder")
tabla02 <- datatable(gapminder)

# Creamos un archivo HTML llamado "tabla02.html" que contiene la tabla "tabla02"
html <- "material/data/tabla02.html"
saveWidget(tabla02, html)


## Ordenar y Clasificar (Parte III) -------------------------

# EPH: Encuesta Permanente de Hogares (Parte III)

# El paquete 'eph' en un conjunto de herramientas para descargar y manipular 
# la Encuesta Permanente de Hogares de Argentina. Podemos descargar los conjuntos 
# de datos, descargar los datos sobre pobreza, podemos calcular si un hogar es pobre o no, 
# siguiendo la metodología oficial. Los métodos implementados se basan en INDEC (2016).

# Vamos a ver cómo trabajar con el paquete 'eph'

# install.packages('eph')

require(eph)

# Obtenemos la base de microdatos de individuos
# para el primer trimestre de 2020:

(ind_01_20 <-           # nombre del objeto a crear
  get_microdata(        # función para cargar los datos de la eph
    year = 2020,        # año
    trimester = 1,      # trimestre
    type = 'individual' # tipo: 'individual' / 'hogar'
    )) |> head()

# Consultamos el diccionario de códigos para los aglomerados
head(diccionario_aglomerados)

# Filtramos los datos para el aglomerado Mar del Plata (aglomerado 34) y organizamos las etiquetas
(mdp_ind_01_20 <- ind_01_20 %>% filter(AGLOMERADO == '34') %>% organize_labels(., type='individual')) |> head()

# Armamos la tabla de condición de ocupación según sexo con sus respectivos totales y porcentajes
(tabla <- mdp_ind_01_20 %>%
    calculate_tabulates(x = 'ESTADO', y = 'CH04', weights = 'PONDIH', add.totals = 'row', add.percentage = 'col')) |> head()

# Mejoramos el resultado obtenido para la tabla de condición de ocupación según sexo (%)
(Tabla_Ocu1 <- calculate_tabulates(base = mdp_ind_01_20, x = 'ESTADO', y = 'CH04', weights = 'PONDIH', add.totals = 'row', add.percentage = 'col') %>%
    data.frame() %>%
    as_tibble() %>%
    rename(Condicion = ESTADO.CH04) %>%
    filter(!stringr::str_detect(Condicion, "Entrevista")) %>%
    rename(Varon_P = Varon) %>%
    rename(Mujer_P = Mujer) %>%
    mutate(Condicion = case_when(
      Condicion == "Ocupado" ~ "Ocupadx",
      Condicion == "Desocupado" ~ "Desocupadx",
      Condicion == "Inactivo" ~ "Inactivx",
      Condicion == "Menor de 10 anios." ~ "< 10 años",
      TRUE ~ as.character(Condicion)
    )))

# Mejoramos el resultado obtenido para la tabla de condición de ocupación según sexo (Nº)
(Tabla_Ocu2 <- calculate_tabulates(base = mdp_ind_01_20, x = 'ESTADO', y = 'CH04', weights = 'PONDIH', add.totals = 'row') %>%
    data.frame() %>%
    as_tibble() %>%
    rename(Condicion = ESTADO.CH04) %>%
    rename(Varon_N = Varon) %>%
    rename(Mujer_N = Mujer) %>%
    filter(!stringr::str_detect(Condicion, "Entrevista")) %>%
    mutate(Condicion = case_when(
      Condicion == "Ocupado" ~ "Ocupadx",
      Condicion == "Desocupado" ~ "Desocupadx",
      Condicion == "Inactivo" ~ "Inactivx",
      Condicion == "Menor de 10 anios." ~ "< 10 años",
      TRUE ~ as.character(Condicion)
    )))

# Unimos las tablas de condición de ocupación según sexo en una sola tabla
(Tabla_unificada <- full_join(Tabla_Ocu2, Tabla_Ocu1, by = "Condicion"))
