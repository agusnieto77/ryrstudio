# Introducción al raspado web con R y RStudio ----------------------------------------------------

# Paquetes a cargar (función 'require()' es equivalente a la función 'library()') ----------------

require(tidyverse)
require(rvest)
require(stringr)
require(tidytext)
require(tm)

# Creamos la función para raspar El Mundo cuyo nombre será 'scraping_EM()' ------------------------

scraping_EM <- function (x){          # abro función para raspado web y le asigno un nombre: scraping_EM

  rvest::read_html(x) |>             # llamo a la función read_html() para obtener el contenido de la página

    rvest::html_elements(".ue-c-cover-content__headline-group") |>  # llamo a la función html_elements() y especifico las etiquetas de los títulos

    rvest::html_text() |>            # llamo a la función html_text() para especificar el formato 'chr' del título.

    tibble::as_tibble() |>           # llamo a la función as_tibble() para transforma el vector en tabla

    dplyr::rename(titulo = value)     # llamo a la función rename() para renombrar la variable 'value'

}                                     # cierro la función para raspado web
# Usamos la función para scrapear el diario El Mundo ----------------------------------------------

(El_Mundo <- scraping_EM("https://www.elmundo.es/espana.html"))

# Tokenizamos los títulos de la sección 'España' del periódico El Mundo ---------------------------
El_Mundo |>                                          # datos en formato tabular extraídos con la función scraping_EM()

  tidytext::unnest_tokens(                            # función para tokenizar

    palabra,                                          # nombre de la columna a crear

    titulo) |>                                       # columna de datos a tokenizar

  dplyr::count(                                       # función para contar

    palabra) |>                                      # columna de datos a contar

  dplyr::arrange(                                     # función para ordenar columnas

    dplyr::desc(                                      # orden decreciente

      n)) |>                                         # columna de frecuencia a ordenar en forma decreciente

  dplyr::filter(n > 4) |>                            # filtramos y nos quedamos con las frecuencias mayores a 2

  dplyr::filter(!palabra %in%
                  tm::stopwords("es")) |>            # filtramos palabras comunes

  dplyr::filter(palabra != "españa") |>              # filtro comodín
  dplyr::filter(palabra != "tras") |>                # filtro comodín
  dplyr::filter(palabra != "sólo") |>                # filtro comodín

  ggplot2::ggplot(                                    # abrimos función para visualizar

    ggplot2::aes(                                     # definimos el mapa estético del gráfico

      y = n,                                          # definimos la entrada de datos de y

      x = stats::reorder(                             # definimos la entrada de datos de x

        palabra,                                      # con la función reorder()

        + n                                           # para ordenar de mayor a menos la frecuencia de palabras

      )                                               # cerramos la función reorder()

    )                                                 # cerramos la función aes()

  ) +                                                 # cerramos la función ggplot()

  ggplot2::geom_bar(                                  # abrimos la función geom_bar()

    ggplot2::aes(                                     # agregamos parámetros a la función aes()

      fill = as_factor(n)                             # definimos los colores y tratamos la variable n como factores

    ),                                                # cerramos la función aes()

    stat = 'identity',                                # definimos que no tiene que contar, que los datos ya están agrupados

    show.legend = F) +                                # establecemos que se borre la leyenda

  ggplot2::geom_label(                                # definimos las etiquetas de las barras

    aes(                                              # agregamos parámetros a la función aes()

      label = n                                       # definimos los valores de ene como contenido de las etiquetas

    ),                                                # cerramos la función aes()

    size = 5) +                                       # definimos el tamaño de las etiquetas

  ggplot2::labs(                                      # definimos las etiquetas del gráfico

    title = "Temas en la agenda periodística",        # definimos el título

    x = NULL,                                         # definimos la etiqueta de la x

    y = NULL                                          # definimos la etiqueta de la y

  ) +                                                 # cerramos la función labs()

  ggplot2::coord_flip() +                             # definimos que las barras estén acostadas

  ggplot2::theme_bw() +                               # definimos el tema general del gráfico

  ggplot2::theme(                                     # definimos parámetros para los ejes

    axis.text.x =
      ggplot2::element_blank(),                       # definimos que el texto del eje x no se vea

    axis.text.y =
      ggplot2::element_text(                          # definimos que el texto del eje y

        size = 16                                     # definimos el tamaño del texto del eje y

      ),                                              # cerramos la función element_text()

    plot.title =
      ggplot2::element_text(                          # definimos la estética del título

        size = 18,                                    # definimos el tamaño

        hjust = .5,                                   # definimos la alineación

        face = "bold",                                # definimos el grosor de la letra

        color = "darkred"                             # definimos el color de la letra

      )                                               # cerramos la función element_text()

  )                                                   # cerramos la función theme()
