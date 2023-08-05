### Importar y exportar marcos de datos en R

Importamos la base de datos ‘df.csv’ con la función read.csv()

    df <- read.csv('https://observatoriodeconflictividad.org/df.csv')
    head(df)

    ##    apellido nombre sexo edad nacionalidad dia mes anio
    ## 1    García   Juan    M   21          arg   1   5 1981
    ## 2 Rodríguez  Pedro    M   22          arg   2   4 1982
    ## 3     Pérez  Juana    F   23          chi   3   3 1983
    ## 4    García  María    X   24          bol   4   2 1984
    ## 5  González  Marta    F   25          arg   5   1 1985
    ## 6    García   Juan    M   26          arg   6  11 1986

Exportamos el objeto ‘df’ como objeto de R con la función saveRDS()

    saveRDS(df,'df.rds')

Importamos la base de datos ‘df.rds’ con la función readRDS()

    readRDS('df.rds') |> head()

    ##    apellido nombre sexo edad nacionalidad dia mes anio
    ## 1    García   Juan    M   21          arg   1   5 1981
    ## 2 Rodríguez  Pedro    M   22          arg   2   4 1982
    ## 3     Pérez  Juana    F   23          chi   3   3 1983
    ## 4    García  María    X   24          bol   4   2 1984
    ## 5  González  Marta    F   25          arg   5   1 1985
    ## 6    García   Juan    M   26          arg   6  11 1986

Exportamos el objeto ‘df’ como valores separados por comas con la
función write.csv()

    write.csv(df,'df.csv', row.names = F)

###### Corra el código en Google Colab desde este [link](https://colab.research.google.com/drive/1rMC9cFZfo1ZPRBopsSn7Ym0ivgm7hx-X?usp=sharing "Google Colab").
