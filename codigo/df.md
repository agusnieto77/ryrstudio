### Crear un marco de datos en R

Primero creamos los vectores

    apellidos <- rep(c('García','Rodríguez','Pérez','García','González'),4)

    nombres <- rep(c('Juan','Pedro','Juana','María','Marta'),4)

    sexos <- rep(c('M','M','F','X','F'),4)

    edades <- c(21:40)

    nacionalidades <- rep(c('arg','arg','chi','bol','arg'),4)

    dias <- c(1:10,21:30)

    meses <- c('5','4','3','2','1','11','12','2','1','4','6','8','10','12','11','9','7','5','3','1')

    anios <- c(1981:2000)

Luego creamos el marco de datos

    df <- data.frame(apellido = apellidos,
                     nombre = nombres,
                     sexo = sexos,
                     edad = edades,
                     nacionalidad = nacionalidades,
                     dia = dias,
                     mes = meses,
                     anio = anios)
    head(df)

    ##    apellido nombre sexo edad nacionalidad dia mes anio
    ## 1    García   Juan    M   21          arg   1   5 1981
    ## 2 Rodríguez  Pedro    M   22          arg   2   4 1982
    ## 3     Pérez  Juana    F   23          chi   3   3 1983
    ## 4    García  María    X   24          bol   4   2 1984
    ## 5  González  Marta    F   25          arg   5   1 1985
    ## 6    García   Juan    M   26          arg   6  11 1986

Ahora inspeccionamos qué tipo de datos contiene

    str(df)

    ## 'data.frame':    20 obs. of  8 variables:
    ##  $ apellido    : chr  "García" "Rodríguez" "Pérez" "García" ...
    ##  $ nombre      : chr  "Juan" "Pedro" "Juana" "María" ...
    ##  $ sexo        : chr  "M" "M" "F" "X" ...
    ##  $ edad        : int  21 22 23 24 25 26 27 28 29 30 ...
    ##  $ nacionalidad: chr  "arg" "arg" "chi" "bol" ...
    ##  $ dia         : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ mes         : chr  "5" "4" "3" "2" ...
    ##  $ anio        : int  1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 ...

###### Corra el código en Google Colab desde este [link](https://colab.research.google.com/drive/1OJUobzElX-QJ2ty_UQDrbWHW4T4c1oe5?usp=sharing "Google Colab").
