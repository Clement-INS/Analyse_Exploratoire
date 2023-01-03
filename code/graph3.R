# Installer et charger dplyr
install.packages("dplyr")
install.packages("ggplot2")
install.packages("fmsb")
library(fmsb)
library(ggplot2)
library(dplyr)
library(tibble)
library(viridis)

# Charger les données
data <- read.csv("C:/Users/clement/Documents/INSA/Cours_5A/R/archive/Life_Expectancy_00_15.csv", sep = ";")

# créer une colonne indicant la décénnie de l'espérance de vie
data <- data %>%
  mutate(decade = cut(Life_Expectancy, breaks = seq(40, 100, 10)))

# groupe les données par décénnie et calcul les moyennes
averages <- data %>%
  group_by(decade) %>%
  summarize(CO2 = mean(CO2.emissions),
            Forest_Area = mean(Forest.area),
            Open_Defecation = mean(People.practicing.open.defecation),
            Basic_Water= mean(People.using.at.least.basic.drinking.water.services),
            Health_Expenditure = mean(Health.expenditure),
            Obesity = mean(Obesity.among.adults),
            GDP = mean(GDP.per.capita),
            Beer = mean(Beer.consumption.per.capita))

# mets les décénnies en nom de ligne
averages <- column_to_rownames(averages, var = "decade")

# récupères les valeurs max et min de chaque colonne
max_values <- sapply(averages, max)
min_values <- sapply(averages, min)

# ajoute les max et min en début du dataframe
averages <- rbind(max_values, min_values, averages)

# créer un vecteur de 5 couleurs visibles par les daltoniens
colors <- viridis(5)

# créer un radarchart des moyennes de nos données
radarchart( averages  , axistype=1 , 
            #custom polygon
            pcol=colors, plwd=4 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", cglwd=0.8,
            #custom labels
            vlcex=1 
)
legend(x=1.2, y=1, legend = rownames(averages[-c(1,2),]), bty = "n", pch=20 , col=colors, cex=1.2, pt.cex=3)
