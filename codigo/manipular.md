### Manipular marcos de datos como objetos en R

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

Creamos una nueva columna llamada ‘id’

    df <- cbind(id = as.integer(row.names(df)), df)
    head(df)

    ##   id  apellido nombre sexo edad nacionalidad dia mes anio
    ## 1  1    García   Juan    M   21          arg   1   5 1981
    ## 2  2 Rodríguez  Pedro    M   22          arg   2   4 1982
    ## 3  3     Pérez  Juana    F   23          chi   3   3 1983
    ## 4  4    García  María    X   24          bol   4   2 1984
    ## 5  5  González  Marta    F   25          arg   5   1 1985
    ## 6  6    García   Juan    M   26          arg   6  11 1986

Creamos una nueva base de datos

    df_2 <- data.frame(id = 1:20, 
                       fumadore = sample(
                         c(rep('si',10),rep('no',10)), 
                         20))
    head(df_2)

    ##   id fumadore
    ## 1  1       no
    ## 2  2       si
    ## 3  3       si
    ## 4  4       si
    ## 5  5       no
    ## 6  6       si

Ahora unimos las dos bases

    dfu <- merge(df,df_2)
    head(dfu)

    ##   id  apellido nombre sexo edad nacionalidad dia mes anio fumadore
    ## 1  1    García   Juan    M   21          arg   1   5 1981       no
    ## 2  2 Rodríguez  Pedro    M   22          arg   2   4 1982       si
    ## 3  3     Pérez  Juana    F   23          chi   3   3 1983       si
    ## 4  4    García  María    X   24          bol   4   2 1984       si
    ## 5  5  González  Marta    F   25          arg   5   1 1985       no
    ## 6  6    García   Juan    M   26          arg   6  11 1986       si

###### Corra el código en Google Colab desde este [link](https://colab.research.google.com/drive/1lLMUjYM-BRPi4l92To0e4yBnDYAFpr8v?usp=sharing "Google Colab").
