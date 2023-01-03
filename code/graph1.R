install.packages("tidyverse")
install.packages("ggplot2")
library(ggplot2)
library(tidyverse) 
library(dplyr)

# Charger le fichier CSV et le stocker dans un data frame appelé "data"
data <- read.csv("C:/Users/clement/Documents/INSA/Cours_5A/R/archive/Life_Expectancy_00_15.csv", sep = ";")

# Calculer les moyennes par continent et année et stocker les résultats dans un nouveau data frame appelé "mean_data"
mean_data <- data %>%
  group_by(Continent, Year) %>%
  summarize(Life_Expectancy = mean(Life_Expectancy))

# Créer le graphique en utilisant ggplot et en spécifiant "mean_data" comme données, "année" comme variable d'abscisse et "espérance de vie" comme variable d'ordonnée
ggplot(mean_data, aes(x = Year, y = Life_Expectancy, color = Continent)) +
  geom_line()
