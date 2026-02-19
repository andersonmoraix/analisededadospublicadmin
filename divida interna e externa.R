#Modulo 4 Unidade 2

#Dados abertos do tesouro transparente

install.packages("janitor") #instale o pacote para melhorar a legibilidade dos nomes da tabela

library(tidyverse)

library(janitor)


#url do dado

url_estoque_dpf<- "https://www.tesourotransparente.gov.br/ckan/dataset/0998f610-bc25-4ce3-b32c-a873447500c2/resource/b6280ed3-ef7e-4569-954a-bded97c2c8a1/download/EstoqueDPF.csv"

#lê o arquivo diretamente da url, observe que aqui não precisamos fazer o download do dado
estoque_dpf<- read_csv2(url_estoque_dpf)

#veja os nomes das colunas do dataframe
names(estoque_dpf)

#A função clean_names do pacote janitor deixa o nome das variáveis mais legíveis
estoque_dpf<- janitor::clean_names(estoque_dpf)

#veja como ficam os nomes das colunas do dataframe após a limpeza
names(estoque_dpf)

#gráfico a partir do agrupamento por tipo de dívida
estoque_dpf %>%
  filter(mes_do_estoque=="12/2021") %>% #filtra para permanecer apenas dados de 12/2021
  group_by(tipo_de_divida) %>% #agrupa por tipo de dívida (interna/externa)
  summarise(
    total_divida = sum(valor_do_estoque) #calcula o total da dívida por tipo
  ) %>%
  ggplot()+
  geom_col(aes(x=tipo_de_divida,y=total_divida))
