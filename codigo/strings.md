### Manipular cadenas de caracteres en R

Cargamos la base de datos ‘df.csv’ con la función read.csv() y le
asignamos (&lt;-) el nombre ‘df’ en el entorno de trabajo de R.

    df <- read.csv('https://observatoriodeconflictividad.org/df.csv')
    head(df)

    ##    apellido nombre sexo edad nacionalidad dia mes anio
    ## 1    García   Juan    M   21          arg   1   5 1981
    ## 2 Rodríguez  Pedro    M   22          arg   2   4 1982
    ## 3     Pérez  Juana    F   23          chi   3   3 1983
    ## 4    García  María    X   24          bol   4   2 1984
    ## 5  González  Marta    F   25          arg   5   1 1985
    ## 6    García   Juan    M   26          arg   6  11 1986

Creamos tres frases con el contenido de la base de datos ‘df’

    df_strings <- paste(df$nombre[1:3],
                        df$apellido[1:3],
                        'tiene',
                        df$edad[1:3],
                        'años y es de nacionalidad',
                        df$nacionalidad[1:3])
    df_strings

    ## [1] "Juan García tiene 21 años y es de nacionalidad arg"    
    ## [2] "Pedro Rodríguez tiene 22 años y es de nacionalidad arg"
    ## [3] "Juana Pérez tiene 23 años y es de nacionalidad chi"

Ahora modificamos las fases para que diga la nacionalidad completa

    df_strings <- gsub('arg','argentina.',df_strings)
    df_strings <- gsub('chi','chilena.',df_strings)
    df_strings

    ## [1] "Juan García tiene 21 años y es de nacionalidad argentina."    
    ## [2] "Pedro Rodríguez tiene 22 años y es de nacionalidad argentina."
    ## [3] "Juana Pérez tiene 23 años y es de nacionalidad chilena."

Ahora contamos la cantidad de palabras de cada frase

    sapply(strsplit(df_strings, " "), length)

    ## [1] 10 10 10

Ahora contamos la cantidad de caracteres de cada frase

    nchar(df_strings)

    ## [1] 57 61 55

###### Corra el código en Google Colab desde este [link](https://colab.research.google.com/drive/1T4YLr2mEvRQuXK6-HNkMcLYZmaJGEqh0?usp=sharing "Google Colab").
