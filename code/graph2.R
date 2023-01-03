# Installer et charger dplyr
install.packages("dplyr")
install.packages("ggplot2")
library(ggplot2)
library(dplyr)

# Charger les données
data <- read.csv("C:/Users/clement/Documents/INSA/Cours_5A/R/archive/Life_Expectancy_00_15.csv", sep = ";")

# Créer une nouvelle colonne qui catégorise chaque valeur d'âge dans un intervalle de 10 ans
data <- data %>%
  mutate(expectancy_group = cut(Life_Expectancy, breaks = seq(30, 110, by = 5)))

# Calculer la moyenne du nombre d'habitants pour chaque intervalle d'âge et chaque valeur de Least Developed
averages <- data %>%
  group_by(Least.Developed, expectancy_group) %>%
  summarize(sum_pop = sum(Population))

averages$developed_label <- factor(averages$Least.Developed, levels = c(TRUE, FALSE), labels = c("Non développé", "Développé"))
# Tracer la pyramide des âges
# ggplot(averages, aes(x = sum_pop, y = expectancy_group, fill = Least.Developed)) +
#   geom_bar(stat = "identity", position = "dodge")
print(averages)

ggplot(averages) +
  aes(x = expectancy_group, fill = developed_label) +
  geom_bar(data = subset(averages, developed_label == "Non développé"),
           aes(y = sum_pop*(-1)), stat='identity') +
  geom_bar(data = subset(averages, developed_label == "Développé"),
           aes(y = sum_pop), stat='identity') +
  scale_fill_manual(values = c("light blue", "pink")) +
  coord_flip() +
  labs(title = "Nombre d'habitant et leur espérance de vie des pays développés et non développés", x = "espérance de vie", y = "total population") +
  theme_light() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    axis.text.x = element_text(size = 12, face = "bold"),
    axis.text.y =  element_text(size = 12, face = "bold"),
    legend.position = "bottom",
    legend.title = element_blank(),
  )
