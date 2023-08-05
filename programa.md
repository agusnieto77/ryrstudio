---
layout: default
editor_options: 
  markdown: 
    wrap: sentence
---

# Programa del Seminario de Posgrado

**Introducción a la recolección y análisis de datos con R y RStudio**

Año lectivo: 2023

Régimen de cursada: Cuatrimestral (segundo cuatrimestre)

Profesor a cargo: Agustín Nieto

Carga horaria: 12

Período: 7, 8 y 10 de agosto

Número de encuentros: 3

Horario: jueves 13-17 hs.
[modalidad: virtual]

##### FUNDAMENTACIÓN Y OBJETIVOS

El curso se fundamenta en la necesidad creciente de comprender y aprovechar el potencial de los datos en diversos ámbitos. En la era digital, la cantidad de datos disponibles es enorme y su análisis adecuado puede brindar valiosas perspectivas y ventajas competitivas. El curso capacita a lxs estudiantes en el manejo y análisis de datos con R y RStudio. Se exploran técnicas de web scraping, manipulación de datos con dplyr y tidyr, y minería de texto con tidytext y quanteda. Lxs estudiantes aprenden a recolectar datos de fuentes en línea, limpiarlos y extraer información relevante. Al finalizar, están preparadxs para enfrentar desafíos en el análisis de datos estructurados, semi-estructurados y no estructurados, aplicando estas habilidades en contextos académicos o profesionales.

El objetivo de este curso es capacitar a los y las estudiantes en la recolección y análisis de datos estructurados, semi-estructurados y no estructurados utilizando R y RStudio. Al finalizar el curso, quienes participen estarán familiarizados con las técnicas de web scraping, manipulación de datos con dplyr y tidyr, y minería de texto con tidytext y quanteda, y podrán aplicar estos conocimientos para obtener, limpiar, transformar y analizar datos de diversas fuentes.

**Objetivos**

-	Comprender los conceptos fundamentales de la recolección y análisis de datos y su importancia en el contexto actual.
-	Adquirir habilidades en web scraping para extraer datos de sitios web estáticos y dinámicos de manera automatizada.
-	Dominar las técnicas de manipulación y limpieza de datos utilizando las librerías dplyr y tidyr de R.
-	Explorar y visualizar datos utilizando las capacidades gráficas de R y ggplot2.
-	Comprender los conceptos básicos de la minería de texto y cómo aplicarlos en la extracción de información relevante de textos.
-	Aprender a preprocesar y analizar textos utilizando las librerías tidytext y quanteda.
-	Aplicar técnicas de análisis de sentimiento y modelado de tópicos en textos con el fin de obtener información útil y relevantes.
-	Aplicar los conocimientos adquiridos en la realización de un proyecto final que integre las diferentes técnicas aprendidas durante el curso.


##### CONTENIDOS Y BIBLIOGRAFÍA OBLIGATORIA

**Unidad I**

*Recolección de datos con web scraping*
-	Introducción al web scraping
-	Uso de herramientas como rvest y RSelenium
-	Extracción de datos de sitios web estáticos y dinámicos
-	Manipulación y limpieza de datos extraídos
-	Manipulación de datos con dplyr y tidyr


-   Gualda, E.
    (2022).
    Social big data, sociología y ciencias sociales computacionales.
    Empiria: Revista de metodología de ciencias sociales, (53), 147-177.

**Unidad II**

De palabras a números y viceversa.
Alcance y límites de la minería de textos para la medición de la conflictividad social: experiencias de investigación en el marco del Observatorio de Conflictividad Social de la UNMdP.

-   Albrieu, R., & Palazzo, G.
    (2020).
    Categorización de conflictos sociales en el ámbito de los recursos naturales: Un estudio de las actividades extractivas mediante la minería de textos.
    Revista CEPAL, 131, 29--59.

-   Franzosi, R.
    (2020).
    What's in a text?
    Bridging the gap between quality and quantity in the digital era.
    Quality & Quantity, 1--28.

-   Liang, H., & Zhu, J. J.
    (2017).
    Big data, collection of (social media, harvesting).
    The International Encyclopedia of Communication Research Methods, 1--18.

-   Escobar, M., Gil Moreno, E., & Calvo López, C.
    (2022).
    Análisis de la dinámica, la estructura y el contenido de los mensajes de Twitter: violencia sexual en #Cuéntalo.
    Empiria.
    Revista De metodología De Ciencias Sociales, (53), 89--119.

**Unidad III**

Web Scraping con rvest y RSelenium.
HTML, CSS y coso: las etiquetas para la recuperación de la información que necesitamos.
Web Scraping con rvest y RSelenium.
Inspección de estructuras html.
Recuperación de información publicada en la web, tanto en páginas estáticas como en páginas dinámicas.
Transformación de la información semi-estructurada en datos estructurados.

-   Müller, K., & Wickham, H.
    (2021).
    Tibble: Simple data frames.

-   Wickham, H., Averick, M., Bryan, J., Chang, W., McGowan, L. D., François, R., Grolemund, G., Hayes, A., Henry, L., Hester, J., Kuhn, M., Pedersen, T. L., Miller, E., Bache, S. M., Müller, K., Ooms, J., Robinson, D., Seidel, D. P., Spinu, V., Yutani, H.
    (2019).
    Welcome to the tidyverse.
    Journal of Open-Source Software, 4(43), 1686.

-   Wickham, H.
    (2021).
    Rvest: Easily harvest (scrape) web pages.

**Unidad IV**

Limpieza y normalización del corpus que logramos scrapear.
Palabras vacías (stopwords), lemas, raíces, entidades, etiquetas POS (Parts Of Speech), etc.
Tokenizado de textos.
Primeras mediciones: palabras más frecuentes y relaciones más fuertes.
Uso de diccionarios para la detección de eventos (de protesta) y otras entidades (provincias, barrios, organizaciones, etc.).

-   Melo, Jairo (2017).
    "Lectura distante, fragmentada y colaborativa en el archivo infinito", en Relaciones: Estudios de historia y sociedad, 38.149: 169-89.

-   Moretti, Franco (2015).
    Lectura distante, FCE, Argentina.

-   Mueller, Martin (2012) "Scalable Reading", en Scalablereading.

-   Silge, J., & Robinson, D.
    (2017).
    Text mining with r: A tidy approach.
    O'Reilly Media, Inc.

**Unidad V**

Análisis profundo del corpus: filtros y sub-corpus (sobre notas referidas a eventos de protesta).
Ajuste de las palabras vacías con un diccionario personalizado.
Eliminación de notas repetidas.
Elaboración de resúmenes con palabras clave, etc.
Análisis exploratorio de los datos normalizados con paquetes de visualización: ggplot2 y sf.
Armado de índices de conflictividad.

-   Nieto, A.
    (2021).
    Intersecciones entre historia digital e historia social: un ejercicio de lectura distante sobre la conflictividad marítima en la historia argentina reciente.
    Drassana, (28), 122--142.

-   Rosati, German.
    «La Visualización de Datos Es Trabajo Esencial».
    Factor\~data (blog), 20 de julio de 2020.

-   Schwandt, Silke (2020).
    "Métodos digitales para la semántica histórica", en Conceptos históricos, 8, 5.

-   Wickham, H.
    (2016).
    ggplot2: Elegant graphics for data analysis.
    Springer-Verlag New York.

##### METODOLOGÍA DE TRABAJO Y SISTEMA DE EVALUACIÓN

**Modalidad de trabajo**

El seminario es inicial en cuanto a las competencias técnicas en R Project.
Los encuentros requieren mínimos conocimientos de usos de servicios de Internet y sistemas operativos.
Desarrollaremos ejercicios computacionales en R para abordar distintos problemas metodológicos.
Los textos de corte más teórico permitirán reflexionar sobre los alcances de las técnicas computacionales para el análisis da la conflictividad social.

**Evaluación**

Quienes realicen el seminario deberán cumplir con un 75% de asistencia y luego entregar un condigo (en desarrollo) que permita ejecutar alguna acción de procesamiento de corpus de texto, necesario para su investigación de tesis, y un ensayo breve de tipo expositivo en el cual se reflexiones sobre la experiencia de trabajo con R y se refiera a la utilidad de las técnicas de las ciencias sociales computacionales y humanidades digitales.
El ensayo no puede superar las 10 páginas.
Se establecerá un plazo de tres meses para la entrega del trabajo final.
