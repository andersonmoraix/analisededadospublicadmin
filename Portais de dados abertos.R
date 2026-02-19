#Unidade 4 Modulo 1 Trabalhando com portais de dados abertos
install.packages("tidyverse")
library(tidyverse)

##Dados abertos de dados.gov.br

#url do dado
url_habitacao<- "http://sishab.mdr.gov.br/dados_abertos/_contratacoes_pcmv_pcva.csv"

#download do dado a partir do endereço da url
download.file(url = url_habitacao, destfile = "contratacoes_pcmv_pcva.csv", mode="wb")

#gera um dataframe a partir do arquivo csv baixado
contratacoes_pcmv_pcva <- read_delim("contratacoes_pcmv_pcva.csv",
                                     delim = "|", escape_double = FALSE, locale = locale(encoding = "LATIN1"),
                                     trim_ws = TRUE) #sugestão: procure ler sobre encoding

contratacoes_pcmv_pcva%>%
  group_by(txt_uf) %>%
  summarise(
    contratadas= sum(qtd_uh_contratadas), #soma das quantidades de unidades habitacionais contratadas
    entregues = sum(qtd_uh_entregues), #soma das quantidades de unidades habitacionais entregues
    perc_entregues = (entregues/contratadas)*100 #de unidades habitacionais entregues
  ) %>%
  arrange(desc(perc_entregues))
