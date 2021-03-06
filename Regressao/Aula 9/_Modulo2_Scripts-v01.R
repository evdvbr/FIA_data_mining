# Iniciar grava��o do arquivo de resultados [esse comando grava s� os resultados em .txt]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")
sink("_Modulo2_Resultados.txt", append=FALSE, split=TRUE)

#**************************************************************************
# FIA - CURSO DATAMINING PARA RECEITA
# T�PICO: AN�LISE DE REGRESS�O - M�dulo 2
# SCRIPTS EM R
# DOCENTE: Prof. Dr. Eduardo K. Kayo
#**************************************************************************

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ALGUMAS DICAS PARA FORMATAR AS TABELAS DE RESULTADO
# 1. Usar o pacote "stargazer" ensinado neste m�dulo (para texto, html e Latex)
# 2. Abrir arquivo de resultados .txt no Excel e formatar como desejar
#    - usar o comando "sink" (vide linha 3) para gravar os resultados em txt
#    - Mudar "Regi�o e idioma" para "Ingl�s EUA" no Painel de Controle do Windows
#    - Abrir o software Excel
#    - Carregar o arquivo de resultados .txt a partir do Excel
#          - "op��o": Largura Fixa
#          - "Origem do arquivo": "Windows (ANSI)" ou outro adequado
#          - Clique "Avan�ar"
#          - Definir os delimitadores na r�gua de "Visualiza��o dos dados"
#          - Clique em "Concluir"
#          - Uma vez baixado o arquivo, formate a vontade
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXEMPLOS DE AULA
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### EXEMPLO 6 - PRE�OS DE IM�VEIS

# Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a mem�ria
rm(list=ls())
ls()

# Carregar base de outro tipo de software (stata)
library(foreign)
HPRICE1 <- read.dta("HPRICE1-Kayo.dta")

# Checar se arquivo foi carregado
ls()

# Regress�o principal
Exemplo06 <- lm(price ~ lotsize + sqrft + bdrms, data=HPRICE1)
summary(Exemplo06)

# Teste Breusch-Pagan para Heteroscedasticidade (default: res�duos studentizados) 
library(lmtest)
bptest(Exemplo06)

# Pacote stargazer: uma forma mais bonita para a tabela
library(stargazer)
stargazer(Exemplo06, type="text", title="An�lise de regress�o", dep.var.labels=c("Pre�os"), covariate.labels=c("Tamanho do terreno","�rea constru�da","Quartos"))

#--------------------------------------------------------------------------

### EXEMPLO 7 - PRE�OS DE IM�VEIS com regress�o em log

# Modificando a forma funcional (com log) para reduzir heteroscedasticidade
Exemplo07 <- lm(log(price)~log(lotsize)+log(sqrft)+bdrms, data=HPRICE1)
summary(Exemplo07)

library(stargazer)
stargazer(Exemplo07, type="text", title="An�lise de regress�o", dep.var.labels=c("log(Pre�os)"), covariate.labels=c("log(Tamanho do terreno)","log(�rea constru�da)","Quartos"))

# Teste de Breusch-Pagan  
library(lmtest)
bptest(Exemplo07)

#--------------------------------------------------------------------------

### EXEMPLO 8 - PRE�OS DE IM�VEIS COM ERROS ROBUSTOS � HETEROSCEDASTICIDADE
Exemplo08 <- lm(price ~ lotsize + sqrft + bdrms, data=HPRICE1)
summary(Exemplo08)
library(sandwich)
library(lmtest)
coeftest(Exemplo08, vcov=vcovHC(Exemplo08,type="HC0")) 

Exemplo08b <- coeftest(Exemplo08, vcov=vcovHC(Exemplo08,type="HC0")) 
summary(Exemplo08b)

library(stargazer)
stargazer(Exemplo06, Exemplo08b, type="text", title="An�lise de regress�o", dep.var.labels=c("Pre�os","Erros robustos"), covariate.labels=c("Tamanho do terreno","�rea constru�da","Quartos"))

#--------------------------------------------------------------------------

### EXEMPLO 9 - VARI�VEIS EM LOGARITMO NATURAL (LN)

# Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Importar matriz de dados do Stata
library(foreign)
HPRICE2 <- read.dta("HPRICE2-Kayo.dta")

# Regress�o
Exemplo09 <- lm(log(price) ~ log(nox) + rooms, data=HPRICE2)
summary(Exemplo09)

library(stargazer)
stargazer(Exemplo09, type="text", title="An�lise de regress�o", dep.var.labels=c("log(Pre�os)"), covariate.labels=c("log(polui��o)","C�modos"))

#--------------------------------------------------------------------------

### EXEMPLO 10 - REGRESS�O QUADR�TICA

# Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a mem�ria
rm(list=ls())
ls()

# Importar matriz de dados do Stata
library(foreign)
WAGE1 <- read.dta("WAGE1-Kayo.dta")

# Regress�o quadr�tica
Exemplo10 <- lm(wage~exper+I(exper^2), data=WAGE1)
summary(Exemplo10)

# Regress�o quadr�tica alternativa (cria��o de vari�vel quadr�tica antecipadamente)
WAGE1$exp_2 <- WAGE1$exper * WAGE1$exper

Exemplo10b <- lm(wage ~ exper + exp_2, data=WAGE1)
summary(Exemplo10b)

stargazer(Exemplo10, type="text", title="An�lise de regress�o quadr�tica", dep.var.labels=c("Wage"), covariate.labels=c("Experi�ncia","Exper. ao quadrado"))

# Gr�fico da regress�o quadr�tica

wagehat <- predict(Exemplo10)

plot(sort(WAGE1$exper),wagehat[order(WAGE1$exper)],type='l',col='red', xlab="Experience", ylab="Wage")

#--------------------------------------------------------------------------

### EXEMPLO 11 - OUTRA REGRESS�O QUADR�TICA???

# Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a mem�ria
rm(list=ls())
ls()

# Importar matriz de dados do Stata
library(foreign)
HPRICE2 <- read.dta("HPRICE2-Kayo.dta")

# Regress�o
Exemplo11 <- lm(log(price)~log(nox)+log(dist)+rooms+I(rooms^2)+stratio, data=HPRICE2)
summary(Exemplo11)

library(stargazer)
stargazer(Exemplo11, type="text", title="An�lise de regress�o", dep.var.labels=c("log(Pre�os)"), covariate.labels=c("log(polui��o)","log(Dist�ncia centro)","C�modos","C�modos ao quadrado","Prop.estud/prof"))

# Gr�fico da regress�o quadr�tica
Exemplo11b <- lm(log(price)~rooms+I(rooms^2), data=HPRICE2)

pricehat <- predict(Exemplo11b)

plot(sort(HPRICE2$rooms),pricehat[order(HPRICE2$rooms)],type='l',col='red', xlab="C�modos", ylab="log(Pre�o)")

#--------------------------------------------------------------------------

### EXEMPLO 12 - VARI�VEIS BIN�RIAS

# Alterar diret�rio de trabalho
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a mem�ria
rm(list=ls())
ls()

# Importar matriz de dados do Stata
library(foreign)
WAGE1 <- read.dta("WAGE1-Kayo.dta")

# Regress�o simples com vari�vel dummy (FEMALE = 1)
Exemplo12 <- lm(wage~female, data=WAGE1)
summary(Exemplo12)

#--------------------------------------------------------------------------

### EXEMPLO 13 - VARI�VEIS BIN�RIAS COM VARI�VEIS DE CONTROLE

# Regress�o com vari�vel dummy (FEMALE = 1) e vari�veis de controle
Exemplo13 <- lm(wage~female+educ+exper+tenure, data=WAGE1)
summary(Exemplo13)

# Testantdo heteroscedasticidade
library(lmtest)
bptest(Exemplo13)

# Aplicando os erros robusto � heteroscedasticidade
library(sandwich)
library(lmtest)
coeftest(Exemplo13, vcov=vcovHC(Exemplo13,type="HC0")) 

#--------------------------------------------------------------------------

### EXEMPLO 14 - LOG NA VARI�VEL DEPENDENTE E DUMMYS COMO INDEPENDENTE

# Regress�o com vari�vel dummy (FEMALE = 1) e vari�veis de controle
Exemplo14 <- lm(log(wage)~female+educ+exper+expersq+tenure+tenursq, data=WAGE1)
summary(Exemplo14)

#--------------------------------------------------------------------------

### EXEMPLO 15 - VARI�VEIS DE INTERA��O ENTRE VARI�VEIS DUMMY

# Alterar diret�rio de trabalho
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a mem�ria
rm(list=ls())
ls()

# Importar matriz de dados do Stata
library(foreign)
WAGE1 <- read.dta("WAGE1-Kayo.dta")

# Regress�o com vari�vel dummy (FEMALE = 1), estado civil e vari�veis de controle
Exemplo15 <- lm(log(wage)~female*married+educ+exper+expersq+tenure+tenursq, data=WAGE1)
summary(Exemplo15)

#--------------------------------------------------------------------------

### EXEMPLO 16 - VARI�VEIS DE INTERA��O ENTRE VARI�VEIS DUMMY E M�TRICAS

# Regress�o com com intera��o entre female e educ
Exemplo16 <- lm(log(wage)~female*educ+exper+expersq+tenure+tenursq, data=WAGE1)
summary(Exemplo16)

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERC�CIOS
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### Exerc�cio C

# Alterar diret�rio de trabalho
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a mem�ria
rm(list=ls())
ls()

# Carregando o arquivo
WAGE1 <- read.dta("WAGE1-Kayo.dta")

# Regress�o
ExercicioC <- lm(log(wage)~female*exper+educ+expersq+tenure+tenursq, data=WAGE1)
summary(ExercicioC)

#--------------------------------------------------------------------------

### Exerc�cio D

# Alterar diret�rio de trabalho
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a mem�ria
rm(list=ls())
ls()

# Carregando o arquivo
ENDIV1 <- read.table("ENDIV1.csv", header=TRUE, sep=",")

# Regress�o
ExercicioD <- lm(mb ~ endiv1 + I(endiv1^2) + lucrat2, data=ENDIV1)
summary(ExercicioD)

#--------------------------------------------------------------------------

# Encerrar grava��o do arquivo de resultados
sink()


# Apagar a mem�ria
rm(list=ls())




