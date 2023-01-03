library(ggplot2)
library(dplyr)
library(base)

# Charger les fichiers CSV et les stocker dans des data frame
data <- read.csv("C:/Users/clement/Documents/INSA/Cours_5A/Analyse_Exploratoire/datasets/Life_Expectancy_00_15.csv", sep = ";")
data1 <- read.csv("C:/Users/clement/Documents/INSA/Cours_5A/Analyse_Exploratoire/datasets/world-happiness-report.csv", sep = ",")

# Renomme les colonnes du deuxième dataset
names(data1)[names(data1) == "year"] <- "Year"
names(data1)[names(data1) == "Country.name"] <- "Country"

# Standardize Data
data$Country <- tolower(data$Country)
data1$Country <- tolower(data1$Country)
data$Country <- trimws(data$Country)
data1$Country <- trimws(data1$Country)
data$Country <- as.character(data$Country)
data1$Country <- as.character(data1$Country)

# Trouve les années en commun dans les 2 datasets
intersection <- intersect(data[, c("Country", "Year")], data1[, c("Country", "Year")])

# Garde les lignes correspondant aux pays et années présents dans les 2 datasets
data <- data[do.call(paste0, data[,c("Country", "Year")]) %in% do.call(paste0, intersection),]
data1 <- data1[do.call(paste0, data1[,c("Country", "Year")]) %in% do.call(paste0, intersection),]

# Calcul les moyennes des espérances de vie
mean_data <- data %>% group_by(Year) %>% summarize(Age = mean(Life_Expectancy))
mean_data1 <- data1 %>% group_by(Year) %>% summarize(Age = mean(Healthy.life.expectancy.at.birth))

head(mean_data)
head(mean_data1)
# Merge les 2 datasets
mean <- rbind(mean_data, mean_data1)
mean <- mean %>% mutate(Label = ifelse(seq(nrow(mean)) <= 11, "Life_Expectancy", "Healthy_Life"))
print(n=25, mean)

# Créer le bar plot
ggplot(data=mean, aes(x=Year, y=Age, fill=Label)) +
  geom_bar(stat="identity", position=position_dodge())