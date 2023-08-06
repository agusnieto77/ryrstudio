df <- data.frame(team=c('A', 'A', 'A', 'A', 'B', 'B', 'B', 'B'),
                 position=c('G', 'G', 'F', 'C', 'G', 'F', 'F', 'C'),
                 points=c(7, 7, 8, 11, 13, 15, 19, 13))

library(dplyr)
library(tidyr)

# produce crosstab 
df |> 
  group_by(team, position) |> 
  tally()  |> 
  spread(team, n)

table(df$position, df$team)

df |> 
  group_by(team, position) |> 
  tally()  |> 
  spread(position, n)

table(df$team, df$position)

# Fuente: https://www.statology.org/dplyr-crosstab/