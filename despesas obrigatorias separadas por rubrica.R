#Modulo 2 unidade 2.2
#A instalação do pacote RTN requer a execução das duas linhas seguintes

install.packages("devtools")

devtools::install_github("tchiluanda/rtn")


#Ao executar a linha acima é possível que o console espere uma resposta sua perguntando se deseja instalar outros pacotes que podem estar desatualizados. Nesse momento, pressione enter no console para que a instalação do pacote continue.

library(rtn)
library(tidyverse)
#Busca todas as contas

rtn::get_full_account_name()

#conta de despesa de benefícios previdenciários

despesa_beneficios_previdenciarios<- "4.1 Benefícios Previdenciários"


###Atenção é possível que a linha acima precise ser modificada caso você perceba que a execução do

#código não retornou o que foi mostrado no vídeo. Uma das explicações para essa situação é que o nome da conta pode

#eventualmente estar um pouco diferente, às vezes basta um espaço a mais para a execução ser comprometida.

#Na execução da linha 5 aparece todos os nomes de todas as contas, você pode

#copiar e colar o nome da conta benefícios previdenciários e subsituir na linha 10.


#Busca quanto se gastou em benefícios previdenciários nos meses de dezembro, mês 12

get_account_data_by_month(despesa_beneficios_previdenciarios,month = 12)


#Busca quanto se gastou em benefícios previdenciários em todos os meses: 1:12

dados_previdenciarios<-get_account_data_by_month(despesa_beneficios_previdenciarios,month = 1:12)

#gera gráfico da série temporal de dados de benefícios previdenciários

dados_previdenciarios%>%
  
  plot_rtn_series()

#ou ainda

get_account_data_by_month(despesa_beneficios_previdenciarios,month = 1:12) %>%
  
  plot_rtn_series()

#Busca novamente todas as contas

get_full_account_name()


#Códigos de contas associadas a despesas obrigatórias com controle de fluxo

despesas_obrigatorias<- c("4.4.1.1", "4.4.1.2", "4.4.1.3","4.4.1.4","4.4.1.5" )

#gera valores acumulados em 12 meses para as contas selecionadas

get_12_month_accumulated_account_data_by_month(despesas_obrigatorias,
                                               
                                               month = c(1:12), #indica que quer o valor acumulado para todos os 12 meses do ano
                                               
                                               match_required = FALSE)%>% #indica que vai fazer o match sem precisar do nome completo da conta
  
  plot_rtn_series() #gera o gráfico de linha
