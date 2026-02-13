#MODULO 3 - UNIDADE 1Modelando dados e gráficos


#instalando e carregando os pacotes
install.packages("tidyverse")

library(tidyverse)

#O objeto arquivo abaixo indica onde está na internet a tabela com os dados sobre municípios brasileiros
#lendo o arquivo
arquivo<- "https://raw.githubusercontent.com/fernandobarbalho/enap_auto_instucional/main/data/dados_municipios.csv"


dados_municipios<- read_csv(file= arquivo)

#Mostra o conteúdo de dados municipios

dados_municipios

glimpse(dados_municipios)

#Filtrando os dados de Pernanbuco

filter(.data= dados_municipios, sigla_uf=="PE" )

#SFiltrando os dados do Ceara

filter(.data= dados_municipios, sigla_uf=="CE" )

#O pacote tidyverse permite o uso do operador %>%, conhecido como pipe (cano, em inglês), que facilita a construção de uma sequência de operações
#O operador %>% leva o conteúdo de um dataframe para o primeiro parâmetro de uma função que vem logo após o %>%
#Isso elimina a necessidade de informar o valor do primeiro parâmetro da função
#NO exemplo abaixo, o %>% leva o conteúdo de dados_municipios para o primeiro argumento da função filter, que é .data

dados_municipios %>%
  
  filter(sigla_uf=="CE")

#Isso permite fazer uma sequência de comandos sobre um dado original.
#No exemplo abaixo, aplicamos um novo filtro ao filto original
#Agora além de filtrar por estado, vamos filtrar também por população, permanecendo apenas os municípios com mais
#de 100000 habitantes

dados_municipios %>%
  
  filter(sigla_uf=="CE") %>%
  
  filter(populacao > 100000)

#Já vimos que a tabela contém 26 colunas para saber o nome das colunas usamos a função name
#Passamos como parâmetro para a função name o nome do dataframe

names(dados_municipios)

#Filtrando por nome e poulacao

dados_municipios%>%
  
  filter(sigla_uf == "CE") %>%
  
  filter(populacao > 100000) %>%
  
  select(sigla_uf,nome, populacao) #indica as colunas que devem aparecer no resultado da sequência de comandos

#Talvez seja interessante ordenar esses municípios. Para isso acrescentamos à sequência de comandos a função arrange
#Na função arrange devemos indicar qual a coluna que será feita a ordenação

dados_municipios%>%
  
  filter(sigla_uf == "CE") %>%
  
  filter(populacao > 100000) %>%
  
  select(sigla_uf,nome, populacao) %>% #indica as colunas que devem aparecer no resultado da sequência de comandos
  
  arrange(populacao)

#Para que a a ordenação seja feita em ordem decrescente use a função desc. Veja abaixo

dados_municipios%>%
  
  filter(sigla_uf == "CE") %>%
  
  filter(populacao > 100000) %>%
  
  select(sigla_uf,nome, populacao) %>% #indica as colunas que devem aparecer no resultado da sequência de comandos
  
  arrange(desc(populacao)) #ordenação em ordem decrescente de população

#Para fazer agrupamentos utilizando o tidyverse utilizamos duas funções: group_by e summarise

#Na função group_by informa-se as variáveis que queremos agrupar

#Na função summarise informa-se operações que se deseja fazer com as variáveis agrupadsa

#No exemplo abaixo, para cada sigla_uf, somamos a população de todos os municípios

dados_municipios %>%
  
  group_by(sigla_uf) %>% #Agrupa pela variável sigla_uf
  
  summarise(
    
    populacao_estado = sum(populacao) #soma a populacao de todos os municípios
    
  )
#Agora o resultado da sequência de comandos anterior em ordem decrescente de população do estado

dados_municipios %>%
  
  group_by(sigla_uf) %>% #Agrupa pela variável sigla_uf
  
  summarise(
    
    populacao_estado = sum(populacao) #soma a populacao de todos os municípios
    
  ) %>%
  
  arrange(desc(populacao_estado)) #faz a ordenação descrescente por populacao_estado

#Podemos também contar o número de municípios em cada estado usando a função n

dados_municipios %>%
  
  group_by(sigla_uf) %>% #Agrupa pela variável sigla_uf
  
  summarise(
    
    quantidade_municipios = n() #soma a populacao de todos os municípios
    
  ) %>%
  
  arrange(desc(quantidade_municipios)) #faz a ordenação descrescente por populacao_estado

#E combinar num mesmo resultado as informações de população do estado, quantidade de municípios, média de habitantes por município e mediana de habitantes

dados_municipios %>%
  
  group_by(sigla_uf) %>% #Agrupa pela variável sigla_uf
  
  summarise(
    
    quantidade_municipios = n(),
    
    populacao_estado = sum(populacao),
    
    media_populacao = mean(populacao),
    
    mediana_populacao = median(populacao)
    
  ) %>%
  
  arrange(desc(quantidade_municipios)) #faz a ordenação descrescente por populacao_estado

#Podemos alterar a estrutura de uma tabela usando a função mutate

#No caso abaixo vamos criar uma nova coluna a partir da combinação das variáveis nome, siga_uf e nome_regiao_saude

#vamos usar a função paste para fazer a concatenação de variáveis tipo texto. Vamos separar as variáveis com "-"

dados_municipios %>%
  
  mutate(nome_regiao_saude_uf = paste(nome, nome_regiao_saude, sigla_uf, sep = "-")) %>%
  
  select(nome_regiao_saude_uf, populacao)

