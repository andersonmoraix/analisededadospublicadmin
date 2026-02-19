#Exercício
#Faça o box-plot de população considerando a distribuição por região do Brasil.

install.packages("tidyverse")
library(tidyverse)

arquivo <- "https://raw.githubusercontent.com/fernandobarbalho/enap_auto_instucional/main/data/dados_municipios.csv"

dados_municipios <- read_csv(file = arquivo)

# Boxplot da população por região
dados_municipios %>%
  ggplot(aes(x = nome_regiao, y = populacao)) +
  geom_boxplot() +
  scale_y_log10() +
  labs(
    title = "Distribuição da População dos Municípios por Região",
    x = "Região do Brasil",
    y = "População (escala log10)"
  )
