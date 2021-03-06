# Iniciar grava��o do arquivo de resultados [esse comando grava s� os resultados em .txt]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")
sink("_Modulo1_Resultados.txt", append=FALSE, split=TRUE)

#**************************************************************************
# FIA - CURSO DATAMINING PARA RECEITA
# T�PICO: AN�LISE DE REGRESS�O - M�dulo 1
# SCRIPTS EM R
# DOCENTE: Prof. Dr. Eduardo K. Kayo
#**************************************************************************

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ALGUMAS DICAS:
# - o s�mbolo # � utilizado no in�cio da linha de um texto, n�o de comando.
# - para visualizar a matriz inteira, voc� pode usar o Rcomander ou 
#   simplesmente digitar o nome do arquivo no console do R.
# - os exemplos e exerc�cios s�o enunciados nos slides das respectivas
#   aulas; acompanhe os slides concentuais e desenvolva os exerc�cios
#   usando os scripts desses arquivos.
# - comandos e recursos adicionais podem ser encontrados em f�runs de dis-
#   cuss�o na internet.
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXEMPLOS DE AULA
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### EXEMPLO 1 - FAZENDO O SCRIPT B�SICO DE UMA REGRESS�O

# 1. Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo .CSV
SalMensal <- read.table("SalMensal.csv", header=TRUE, sep=",")

# 3. Checar se arquivo foi carregado
ls()

# 4. Sempre que voc� quiser ver sua base de dados, basta digitar o nome do arquivo:
SalMensal

# 5. Regress�o simples
Exemplo01 <- lm(sal~man, data=SalMensal)
summary(Exemplo01)

# 6. Plotar gr�fico sal�rio x homem
Graf <- plot(sal~man, data=SalMensal)
abline(Exemplo01)

# 7. Apagar a mem�ria [quando as an�lises se encerrarem; comando opcional]
rm(list=ls())

#--------------------------------------------------------------------------

### EXEMPLO 2 - O SAL�RIO DO CEO

# 1. Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo
load("CEOSAL1.rda")  

# 3. Checar se arquivo foi carregado
ls()

# 4. Regress�o simples
Exemplo02 <- lm(salary~roe, data=CEOSAL1)
summary(Exemplo02)

# 5. Plotar gr�fico sal�rio x roe
Graf <- plot(salary~roe, data=CEOSAL1)
abline(Exemplo02)

# 6. Gravar valores estimados e res�duos como novas vari�veis aleat�rias
CEOSAL1$fit <- fitted(Exemplo02)
CEOSAL1$res <- resid(Exemplo02)

# 7. visualizar a matriz (6 primeiras linhas)
head(CEOSAL1)

#--------------------------------------------------------------------------

### EXEMPLO 3 - F�RMULA 1

# 1. Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo .CSV
F1 <- read.table("F1.csv", header=TRUE, sep=",")

# 3. Salvando matriz como arquivo .rda para uso futuro
save(F1,file="F1.rda")

# 4. Checar se arquivo foi carregado
ls()

# 5. Visualizar os nomes das vari�veis
names(F1)

# 6. Rodando a regress�o simples
Exemplo03a <- lm(points~rain_mm, data=F1)
summary(Exemplo03a)

# 7. Rodando a regress�o m�ltipla
Exemplo03b <- lm(points ~ rain_mm + training, data=F1)
summary(Exemplo03b)

# 8. Matriz de correla��es
library(Rcmdr)
rcorr.adjust(F1[,c("rain_mm","training")], type="pearson")

#--------------------------------------------------------------------------

### EXEMPLO 4 - Tipos de escolaridade e sal�rios

# Provid�ncia preliminar
# - Instala��o do pacote "car", caso voc� ainda n�o tenha instalado

# 1. Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo .CSV
twoyear <- read.table("twoyear.csv", header=TRUE, sep=",")

# 3. Checar se arquivo foi carregado
ls()

# 4. Visualizar os nomes das vari�veis
names(twoyear)

# 5. Rodando a regress�o 
Exemplo04 <- lm(lwage ~ jc + univ + exper, data=twoyear)
summary(Exemplo04)

# 6. Carregando o pacote "car"
library("car")

# 7. Testando diferen�a entre coeficientes
linearHypothesis(Exemplo04, c("jc = univ"))

#--------------------------------------------------------------------------

### EXEMPLO 5 - Determinantes dos sal�rios dos jogadores de baseball

# 1. Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo .CSV
MLB1 <- read.table("MLB1.csv", header=TRUE, sep=",")

# 3. Checar se arquivo foi carregado
ls()

# 4. Visualizar os nomes das vari�veis
names(MLB1)

# 5. Rodando a regress�o 
Exemplo05 <- lm(lsalary ~ years + gamesyr + bavg + hrunsyr + rbisyr, data=MLB1)
summary(Exemplo05)

# 6. Carregando o pacote "car"
library("car")

# 7. Testando se coeficientes em conjunto s�o significantes
linearHypothesis(Exemplo05, c("bavg + hrunsyr + rbisyr = 0"))

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERC�CIOS
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


### Exerc�cio A

# 1. Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo
load("CEOSAL1.rda")  

# 3. Checar se arquivo foi carregado
ls()

# 4. Visualizar os nomes das vari�veis
names(CEOSAL1)

# 5. Regress�o simples
ExercicioA <- lm(lsalary ~ lsales + roe + finance + consprod + utility, data=CEOSAL1)
summary(ExercicioA)

# 7. Gravar valores estimados e res�duos como novas vari�veis aleat�rias
CEOSAL1$fitExA <- fitted(ExercicioA)
CEOSAL1$resExA <- resid(ExercicioA)

# 8. visualizar a matriz (6 primeiras linhas)
head(CEOSAL1)

# 9. Carregando o pacote "car"
library("car")

# 10. Testando a diferen�a entre os sal�rios dos CEOs de produtos de consumo x financeiro
linearHypothesis(ExercicioA, c("finance = consprod"))

#--------------------------------------------------------------------------

### Exerc�cio B. 

# 1. Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo .CSV
ENDIV1 <- read.table("ENDIV1.csv", header=TRUE, sep=",")

# 3. Checar se arquivo foi carregado
ls()

# 4. Visualizar os nomes das vari�veis
names(ENDIV1)

# 5. Visualizar a matriz (6 primeiras linhas)
head(ENDIV1)

# 6. Algumas estat�sticas descritivas posteriormente exploraremos mais essas informa��es
summary (ENDIV1[,c("endiv1","roa","mb","lntam")])

# 7. Matriz de correla��o (carregar package Rcmdr)
library(Rcmdr)
rcorr.adjust(ENDIV1[,c("endiv1","roa","mb","lntam")], type="pearson")

# 8. Regress�es com vari�vel dependente = endiv1
ExercicioB1 <- lm(endiv1 ~ roa, data=ENDIV1)
summary(ExercicioB1)

ExercicioB2 <- lm(endiv1 ~ roa + mb + lntam, data=ENDIV1)
summary(ExercicioB2)

# 9. Regress�es com vari�vel dependente = mb
ExercicioB3 <- lm(mb ~ lucrat2, data=ENDIV1)
summary(ExercicioB3)

ExercicioB4 <- lm(mb ~ lucrat2 + endiv1 + lntam, data=ENDIV1)
summary(ExercicioB4)

#**************************************************************************

# Encerrar grava��o do arquivo de resultados
sink()
