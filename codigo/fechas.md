### Manipular fechas en R

Cargamos la base de datos ‘df.csv’ con la función read.csv() y le
asignamos (&lt;-) el nombre ‘df’ en el entorno de trabajo de R.

    df <- read.csv('https://observatoriodeconflictividad.org/df.csv')
    str(df)

    ## 'data.frame':    20 obs. of  8 variables:
    ##  $ apellido    : chr  "García" "Rodríguez" "Pérez" "García" ...
    ##  $ nombre      : chr  "Juan" "Pedro" "Juana" "María" ...
    ##  $ sexo        : chr  "M" "M" "F" "X" ...
    ##  $ edad        : int  21 22 23 24 25 26 27 28 29 30 ...
    ##  $ nacionalidad: chr  "arg" "arg" "chi" "bol" ...
    ##  $ dia         : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ mes         : int  5 4 3 2 1 11 12 2 1 4 ...
    ##  $ anio        : int  1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 ...

Creamos una nueva base uniendo los datos de la fecha de nacimiento:
‘anio’, ‘mes’, y ‘dia’

    df_date <- data.frame(
      apellido = df$apellido,
      nombre = df$nombre,
      sexo = df$sexo,
      edad = df$edad,
      nacionalidad = df$nacionalidad,
      fecha_nacimiento = paste(df$anio,df$mes,df$dia, sep = '-')
    )
    str(df_date)

    ## 'data.frame':    20 obs. of  6 variables:
    ##  $ apellido        : chr  "García" "Rodríguez" "Pérez" "García" ...
    ##  $ nombre          : chr  "Juan" "Pedro" "Juana" "María" ...
    ##  $ sexo            : chr  "M" "M" "F" "X" ...
    ##  $ edad            : int  21 22 23 24 25 26 27 28 29 30 ...
    ##  $ nacionalidad    : chr  "arg" "arg" "chi" "bol" ...
    ##  $ fecha_nacimiento: chr  "1981-5-1" "1982-4-2" "1983-3-3" "1984-2-4" ...

Ahora modificamos la variable fecha\_nacimiento de formato ‘chr’ a
‘date’

    df_date$fecha_nacimiento <- as.Date(df_date$fecha_nacimiento)
    str(df_date)

    ## 'data.frame':    20 obs. of  6 variables:
    ##  $ apellido        : chr  "García" "Rodríguez" "Pérez" "García" ...
    ##  $ nombre          : chr  "Juan" "Pedro" "Juana" "María" ...
    ##  $ sexo            : chr  "M" "M" "F" "X" ...
    ##  $ edad            : int  21 22 23 24 25 26 27 28 29 30 ...
    ##  $ nacionalidad    : chr  "arg" "arg" "chi" "bol" ...
    ##  $ fecha_nacimiento: Date, format: "1981-05-01" "1982-04-02" ...

Ahora actualizamos los datos de la columna ‘edad’ a la fecha de hoy

    df_date$edad_actual <- as.integer((Sys.Date()-df_date$fecha_nacimient)/365.25)
    head(df_date)

    ##    apellido nombre sexo edad nacionalidad fecha_nacimiento edad_actual
    ## 1    García   Juan    M   21          arg       1981-05-01          41
    ## 2 Rodríguez  Pedro    M   22          arg       1982-04-02          40
    ## 3     Pérez  Juana    F   23          chi       1983-03-03          39
    ## 4    García  María    X   24          bol       1984-02-04          38
    ## 5  González  Marta    F   25          arg       1985-01-05          37
    ## 6    García   Juan    M   26          arg       1986-11-06          35

###### Corra el código en Google Colab desde este [link](https://colab.research.google.com/drive/1OLelYB7NYQIm3ZmFxdRoJknVrzsnZfGv?usp=sharing "Google Colab").
