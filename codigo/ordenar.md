### Ordenar marcos de datos como objetos en R

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

Creamos tres nuevas columnas: ‘id’, ‘salario\_2001’ y ‘salario\_2002’

    df <- cbind(id = as.integer(row.names(df)), df)
    df$salario_2001 <- rep(c(300,400,500,600),5)
    df$salario_2002 <- rep(c(450,350,650,550),5)
    head(df)

    ##   id  apellido nombre sexo edad nacionalidad dia mes anio salario_2001
    ## 1  1    García   Juan    M   21          arg   1   5 1981          300
    ## 2  2 Rodríguez  Pedro    M   22          arg   2   4 1982          400
    ## 3  3     Pérez  Juana    F   23          chi   3   3 1983          500
    ## 4  4    García  María    X   24          bol   4   2 1984          600
    ## 5  5  González  Marta    F   25          arg   5   1 1985          300
    ## 6  6    García   Juan    M   26          arg   6  11 1986          400
    ##   salario_2002
    ## 1          450
    ## 2          350
    ## 3          650
    ## 4          550
    ## 5          450
    ## 6          350

Reordenamos la base: la pasamos de formato ancho (más columnas / menos
filas) a formato largo (menos columnas / más filas).

    df_long <- reshape(df, 
                       direction = "long",
                       timevar = "anio_",
                       varying = 10:11, sep = '_')
    head(df_long)

    ##        id  apellido nombre sexo edad nacionalidad dia mes anio anio_ salario
    ## 1.2001  1    García   Juan    M   21          arg   1   5 1981  2001     300
    ## 2.2001  2 Rodríguez  Pedro    M   22          arg   2   4 1982  2001     400
    ## 3.2001  3     Pérez  Juana    F   23          chi   3   3 1983  2001     500
    ## 4.2001  4    García  María    X   24          bol   4   2 1984  2001     600
    ## 5.2001  5  González  Marta    F   25          arg   5   1 1985  2001     300
    ## 6.2001  6    García   Juan    M   26          arg   6  11 1986  2001     400

Reordenamos la base: la pasamos de formato largo (menos columnas / más
filas) a formato ancho (más columnas / menos filas).

    df_wide <- reshape(df_long, direction = "wide",
                       new.row.names = unique(df_long$id))
    head(df_wide)

    ##   id  apellido nombre sexo edad nacionalidad dia mes anio salario_2001
    ## 1  1    García   Juan    M   21          arg   1   5 1981          300
    ## 2  2 Rodríguez  Pedro    M   22          arg   2   4 1982          400
    ## 3  3     Pérez  Juana    F   23          chi   3   3 1983          500
    ## 4  4    García  María    X   24          bol   4   2 1984          600
    ## 5  5  González  Marta    F   25          arg   5   1 1985          300
    ## 6  6    García   Juan    M   26          arg   6  11 1986          400
    ##   salario_2002
    ## 1          450
    ## 2          350
    ## 3          650
    ## 4          550
    ## 5          450
    ## 6          350

###### Corra el código en Google Colab desde este [link](https://colab.research.google.com/drive/1EhHNQqhUYQlFqiDiO4b9LuZwgKsS4Zte?usp=sharing "Google Colab").
