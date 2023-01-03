install.packages("tidyverse")
install.packages("ggplot2")
library(ggplot2)
library(tidyverse) 
library(dplyr)

# Charger le fichier CSV et le stocker dans un data frame appelé "data"
data <- read.csv("C:/Users/clement/Documents/INSA/Cours_5A/R/archive/Life_Expectancy_00_15.csv", sep = ";")

# Créer une colonne indicant la décénnie de l'espérance de vie
data <- data %>%
  mutate(Decade = cut(Life_Expectancy, breaks = seq(40, 100, 10)))

# Calcule la moyenne d'obesité par tranche d'age
average <- data %>% group_by(Decade) %>% summarize(Obesity = mean(Obesity.among.adults))

print(average)
# Créer le graphique en utilisant ggplot et en spécifiant "mean_data" comme données, "année" comme variable d'abscisse et "espérance de vie" comme variable d'ordonnée
ggplot(average, aes(x = Decade, y = Obesity, group = 1)) + geom_line()
