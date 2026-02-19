#Modulo 3 - Unidade 4 Correlção em municipios com menos de 20 mil habitantes

#O endereço indicado logo abaixo contém um arquivo com dados sobre municípios, incluindo informações sobre gastos com saúde

#O endereço indicado logo abaixo contém um arquivo com dados sobre municípios, incluindo informações sobre gastos com saúde
install.packages("tidyverse")
library(tidyverse)

arquivo<- "https://raw.githubusercontent.com/fernandobarbalho/enap_auto_instucional/main/data/dados_saude_municipio.csv"

dados_saude_municipio<- read_csv(file = arquivo)
municipios_pequenos<-
  
  dados_saude_municipio%>%
  
  filter(populacao<20000)

municipios_pequenos%>%
  
  ggplot()+
  
  geom_point(aes(x=populacao, y=perc))

cor(municipios_pequenos$populacao, municipios_pequenos$perc)
