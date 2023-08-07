# Cargamos las librerías necesarias para trabajar con datos espaciales y visualización
require(tidyverse)
require(viridis)
require(sf)

# Definimos una lista de enlaces (URLs) de archivos comprimidos (shapefiles) de datos geoespaciales
links <- c('https://datos.mardelplata.gob.ar/sites/default/files/fracciones_0.zip',
           'https://datos.mardelplata.gob.ar/sites/default/files/paradas.zip',
           'https://datos.mardelplata.gob.ar/sites/default/files/radios_2.zip',
           'https://datos.mardelplata.gob.ar/sites/default/files/barrios_populares.zip')

# Creamos un directorio para almacenar los archivos descargados (shapefiles)
dir.create('material/data/shp')

# Iteramos sobre cada enlace (URL) para realizar la descarga y descompresión de los archivos
for (i in links) {
  
  # Definimos el directorio de destino para la descarga
  directorio <- 'material/data/shp/'
  
  # Almacenamos el enlace actual en la variable "url"
  url <- i
  
  # Definimos la ruta de destino para el archivo descargado
  destino <- paste0(directorio, basename(url))
  
  # Descargamos el archivo desde la URL especificada y lo guardamos en el directorio de destino
  download.file(url = url,
                destfile = destino,
                mode = 'wb')
  
  # Descomprimimos el archivo descargado en el directorio de destino
  unzip(zipfile = destino,
        exdir = directorio)
}

# Leemos los datos de los archivos shapefiles en objetos de tipo 'sf' (simple features)
frac_mdp <- read_sf(paste0(directorio, 'fracciones.shp'))
radi_mdp <- read_sf(paste0(directorio, 'radios.shp'))
para_mdp <- read_sf(paste0(directorio, 'paradas.shp'))
b_po_mdp <- read_sf(paste0(directorio, 'barrios_populares_2020.shp'))

# Se realizan reemplazos de caracteres mal codificados en las columnas "acceso_ele", "acceso_clo" y "acceso_agu"
# del objeto "b_po_mdp" para corregir problemas de codificación.

# Reemplazar todas las apariciones de "Ãº" por "ú" en la columna "acceso_ele"
b_po_mdp$acceso_ele <- gsub("Ãº", "ú", b_po_mdp$acceso_ele)

# Reemplazar todas las apariciones de "Ã" por "í" en la columna "acceso_ele"
b_po_mdp$acceso_ele <- gsub("Ã", "í", b_po_mdp$acceso_ele)

# Reemplazar todas las apariciones de "Ãº" por "ú" en la columna "acceso_clo"
b_po_mdp$acceso_clo <- gsub("Ãº", "ú", b_po_mdp$acceso_clo)

# Reemplazar todas las apariciones de "Ãº" por "ú" en la columna "acceso_agu"
b_po_mdp$acceso_agu <- gsub("Ãº", "ú", b_po_mdp$acceso_agu)


# Establecemos el sistema de referencia de coordenadas (CRS) de los datos de fracciones al sistema WGS84
st_crs(frac_mdp) <- "WGS84"

# Realizamos visualizaciones utilizando ggplot2 y los datos geoespaciales cargados
# Cada bloque de código de ggplot2 representa un gráfico diferente.

# Gráfico 1: Mapa de fracciones, destacando los barrios populares y las paradas de transporte.
ggplot(
  frac_mdp 
  |> filter(!fraccion %in% c('77', '83', '82', '81', '80', '79', '78', '76', '75', '74', '73'))
) +
  geom_sf(fill = 'skyblue', alpha = .1) +
  geom_sf(aes(fill = cantidad_f), data = b_po_mdp) +
  geom_sf(data = para_mdp, size = .5, color = 'purple', alpha = .1) +
  coord_sf(xlim = c(-57.8, -57.5), ylim = c(-38.1, -37.9),  expand = FALSE) +
  scale_fill_viridis() +
  labs(x = NULL, y = NULL) +
  theme_bw() +
  theme(legend.title = element_blank())

# Gráfico 2: Mapa de fracciones, mostrando el número de cada fracción.
ggplot(
  frac_mdp 
  |> filter(!fraccion %in% c('77', '83', '82', '81', '80', '79', '78', '76', '75', '74', '73'))
) +
  geom_sf(fill = 'skyblue', alpha = .1) +
  geom_sf_text(aes(label = fraccion), size = 2) +
  geom_sf(aes(fill = cantidad_f), data = b_po_mdp) +
  coord_sf(xlim = c(-57.8, -57.5), ylim = c(-38.1, -37.9),  expand = FALSE) +
  scale_fill_viridis() +
  labs(x = NULL, y = NULL) +
  theme_bw() +
  theme(legend.title = element_blank())

# Gráfico 3: Mapa de radios con colores según su identificador "gid".
ggplot(
  radi_mdp 
  |> filter(!fraccion %in% c('77', '83', '82', '81', '80', '79', '78', '76', '75', '74', '73'))
) +
  geom_sf(aes(fill = gid)) +
  scale_fill_viridis() +
  labs(x = NULL, y = NULL) +
  theme_bw() +
  theme(legend.title = element_blank())

# Gráfico 4: Mapa de radios con colores según su identificador "gid" usando la paleta 'A' de viridis.
ggplot(
  radi_mdp 
  |> filter(!fraccion %in% c('77', '83', '82', '81', '80', '79', '78', '76', '75', '74', '73'))
) +
  geom_sf(aes(fill = gid)) +
  scale_fill_viridis_c(option = 'A') +
  labs(x = NULL, y = NULL) +
  theme_bw() +
  theme(legend.title = element_blank())

# Gráfico 5: Mapa de radios con colores según su identificador "gid" y fondo en blanco y negro.
ggplot(
  radi_mdp 
  |> filter(!fraccion %in% c('77', '83', '82', '81', '80', '79', '78', '76', '75', '74', '73'))
) +
  geom_sf(aes(fill = gid)) +
  labs(x = NULL, y = NULL) +
  theme_bw() +
  theme(legend.title = element_blank())
