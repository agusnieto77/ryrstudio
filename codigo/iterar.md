### Iterar en R

Iteramos para crear un vector numérico

    df_for_1 <- c()
    df_for_2 <- c()

    for(i in 0:9){
      df_for_1 <- c(df_for_1,i+1)
      df_for_2 <- c(df_for_2,i+11)
      }

    df_for_1

    ##  [1]  1  2  3  4  5  6  7  8  9 10

    df_for_2

    ##  [1] 11 12 13 14 15 16 17 18 19 20

Iteramos para crear un vector de caracteres

    for(i in strsplit('HOLA', split = "")){
      print(paste0(i,1:4))
      print(paste0(1:4,tolower(i),1:4))
      }

    ## [1] "H1" "O2" "L3" "A4"
    ## [1] "1h1" "2o2" "3l3" "4a4"

###### Corra el código en Google Colab desde este [link](https://colab.research.google.com/drive/142gljv8tISHVasx4sGkHV9AR1aGqT4Da?usp=sharing "Google Colab").
