#Modulo 4 Unidade 2.3

# 1. Criar uma biblioteca própria (se não existir)
dir.create("~/Rlibs", showWarnings = FALSE)
# 2. Usar essa biblioteca como padrão
.libPaths("~/Rlibs")
# 3. Instalar o pacote do GitHub dentro dela
install.packages("devtools")
devtools::install_github("tchiluanda/Rcofog")



#Utilizacao do pacote RCOFOG
#Instala o pacote Rcofog
install.packages("devtools")
devtools::install_github("tchiluanda/Rcofog")
library(Rcofog)
library(tidyverse)

#Gera um gráfico de fluxo entras funções e sub-funções de governo para o ano de 2020
Rcofog::dataExpenseFlow(year=2020)%>%
  Rcofog::graphExpenseFlow()

#Gera um gráfico de série temporal para comparar saúde, educação e defesa
funcoes<- c("Saúde","Educação","Defesa")

#Antes vamos ver apenas os dados
Rcofog::dataTimeSeries(sel_function = funcoes)

#Agora vamos ver o gráfico também
Rcofog::dataTimeSeries(sel_function = funcoes) %>%
  Rcofog::graphTimeSeries()
