#MODULO 3 UNIDADE 2 - Criando gráficos com ggplot

#Instalando os pacotes
install.packages("tidyverse")
library(tidyverse)

arquivo<- "https://raw.githubusercontent.com/fernandobarbalho/enap_auto_instucional/main/data/dados_municipios.csv"

dados_municipios<- read_csv(file= arquivo)

#Na sequência de instruções abaixo geramos um gráfico de colunas com as populações dos municípios pernambucanos com mais de 100 mil habitantes
# no eixo x (horizontal) aparecem as populações e no eixo y (vertical) o nome das cidades
dados_municipios %>%
  filter(sigla_uf == "PE") %>%
  filter(populacao>100000) %>%
  ggplot()+
  geom_col(aes(x=populacao, y=nome))

#A função slice_max retorna as n linhas que possuem os maiores valores para uma dada variável
#Veja como podemos usar a função slice_max para mostrar os 10 municípios mais populosos do Brasil
dados_municipios %>%
  slice_max(populacao, n=10) %>%
  ggplot()+
  geom_col(aes(x=populacao, y=nome))

#Observe que o gráfico mostra as cidades em uma ordem aleatória. É conveniente deixarmos o gráfico em forma de ranking
#Usando a função mutate reordenamos a variável nome para que ela passe a aparecer no gráfico a partir da variável população

dados_municipios %>%
  slice_max(populacao, n=10) %>%
  mutate(nome=reorder(nome, populacao)) %>% #reordena a variável nome a partir do valor da variável população
  ggplot()+
  geom_col(aes(x=populacao, y=nome))

#podemos preencher as barras com cores que mudam de acordo com o valor de uma variável
#fazemos isso associando o parâmetro fill da função aes.
#indicamos para esse parâmetro qual a variável que servirá de referência para as cores.
#No caso abaixo as 10 cidades mais populosas terão as cores de suas barras preenchidas de acordo com a variável nome_região

dados_municipios %>%
  slice_max(populacao, n=10) %>%
  mutate(nome=reorder(nome, populacao)) %>%
  ggplot()+
  geom_col(aes(x=populacao, y=nome, fill=nome_regiao))

#Instale o pacote dados
install.packages("dados")

library(dados)
library(tidyverse)


#vamos agora fazer algumas experiências com gráficos de pontos
#usamos para isso a função geom_point
#No gráfico abaixo identficiamos a relação entre pib_per_capita no eixo x e expectativa de vida no eixo y
#fazemos o filtro para os países das Américas no ano de 2007

dados_gapminder %>%
  filter(continente=="Américas") %>%
  filter(ano==2007) %>%
  ggplot()+
  geom_point(aes(x=pib_per_capita, y=expectativa_de_vida))


#Podemos incluir mais um continente no filtro para isso vamos usar o operador %in% que checa se um determinado valor está presente num conjunto

conjunto_continentes <- c("Américas", "África") #Cria um objeto com o conjunto de continentes a ser usado no filtro

dados_gapminder %>%
  filter(continente %in% conjunto_continentes) %>%
  filter(ano==2007) %>%
  ggplot()+
  geom_point(aes(x=pib_per_capita, y=expectativa_de_vida))


#O gráfico não permite identificar quais pontos são de países da África e quais são das Américas.
#Vamos colorir os pontos de acordo com o continente usando o parâmetro color dentro da função aes

dados_gapminder %>%
  filter(continente %in% conjunto_continentes) %>%
  filter(ano==2007) %>%
  ggplot()+
  geom_point(aes(x=pib_per_capita, y=expectativa_de_vida, color= continente))

#Os dados do dataframe dados_gapminder referem-se a uma série de indicadores coletados ao longo de vários anos
#Para saber como um determinado indicador evoluiu uma opção interessante é usar o gráfico de linha
#Faremos uso da função geom_line

#O gráfico abaixo mostra a evolução da expectativa de vida no Brasil desde o início da série histórica
dados_gapminder %>%
  filter(pais == "Brasil") %>%
  ggplot()+
  geom_line(aes(x=ano, y=expectativa_de_vida ))

#Talvez o uso de pontos ajude a identificar os anos em que ocorreram as coletas de dados.
#Nesse caso vamos trabalhar com a combinação de duas geometrias: geom_line e geom_point. Veja abaixo

dados_gapminder %>%
  filter(pais == "Brasil") %>%
  ggplot()+
  geom_line(aes(x=ano, y=expectativa_de_vida )) +
  geom_point(aes(x=ano, y=expectativa_de_vida ))
