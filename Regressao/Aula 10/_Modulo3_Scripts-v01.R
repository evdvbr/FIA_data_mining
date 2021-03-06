# Iniciar grava��o do arquivo de resultados [esse comando grava s� os resultados em .txt]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")
sink("_Modulo3_Resultados.txt", append=FALSE, split=TRUE)

#**************************************************************************
# FIA - CURSO DATAMINING PARA RECEITA
# T�PICO: AN�LISE DE REGRESS�O - M�dulo 3
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

### EXEMPLO 17 - �NDICES DE CRIMINALIDADE

# Definir diret�rio de trabalho [o usu�rio define o diret�rio que lhe convier]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")
  
# Apagar a mem�ria
rm(list=ls())
ls()

# Importar matriz de dados do Stata
library(foreign)
CRIME2 <- read.dta("CRIME2-Kayo.dta")

# Checar se arquivo foi carregado
ls()

# Salvar matriz como arquivo .rda para uso futuro
save(CRIME2,file="CRIME2.rda")

# Visualizar os nomes das vari�veis
names(CRIME2)

## Regress�o apenas com dados de 1987
Exemplo17 <- lm(crmrte~unem, data=subset(CRIME2,year==87))
summary(Exemplo17)

#--------------------------------------------------------------------------

### EXEMPLO 18 - �NDICES DE CRIMINALIDADE COM DADOS AGRUPADOS

## Regress�o com os dados agrupados de 1982 e 1987 (pooled)
Exemplo18 <- lm(crmrte~d87+unem, data=CRIME2)
summary(Exemplo18)

# ou Alternativamente...
library(plm)
CRIME2PANEL <- pdata.frame(CRIME2, index = c("area","year"))
Exemplo18B <- plm(crmrte~d87+unem, data=CRIME2PANEL, model = "pooling")
summary(Exemplo18B)

#--------------------------------------------------------------------------

### EXEMPLO 19 - �NDICES DE CRIMINALIDADE COM EFEITOS FIXOS (within)
library(plm)
CRIME2PANEL <- pdata.frame(CRIME2, index = c("area","year"))
Exemplo19 <- plm(crmrte~d87+unem, data=CRIME2PANEL, model = "within")
summary(Exemplo19)

#--------------------------------------------------------------------------

### EXEMPLO 20 - DETERMINANTES DO SAL�RIO COM DADOS AGRUPADOS (POOLED)

# Importar matriz de dados do Stata
library(foreign)
WAGEPAN <- read.dta("WAGEPAN-Kayo.dta")

# Visualizar os objetos carregados na mem�ria
ls()

# Visualizar os nomes das vari�veis
names(WAGEPAN)

# Visualizar a matriz (6 primeiras linhas)
head(WAGEPAN)

# Salvar matriz como arquivo .rda para uso futuro
save(WAGEPAN,file="WAGEPAN.rda")

# Checar se arquivo .rda foi salvo
dir()

## Regress�o com dados agrupados, efeitos aleat�rios e efeitos fixos
library(plm)
WAGEPANEL <- pdata.frame(WAGEPAN, index = c("nr","year"))

# Dados agrupados
Exemplo20 <- plm(lwage~educ+black+hisp+exper+expersq+married+union+
                   d81+d82+d83+d84+d85+d86+d87, data=WAGEPANEL, model = "pooling")
summary(Exemplo20)

#--------------------------------------------------------------------------

### EXEMPLO 21 - DETERMINANTES DO SAL�RIO COM EFEITOS ALEAT�RIOS

# efeitos aleat�rios
Exemplo21 <- plm(lwage~educ+black+hisp+exper+expersq+married+union+
                   d81+d82+d83+d84+d85+d86+d87, data=WAGEPANEL, model = "random")
summary(Exemplo21)

#--------------------------------------------------------------------------

### EXEMPLO 22 - DETERMINANTES DO SAL�RIO COM EFEITOS FIXOS

# efeitos fixos
Exemplo22 <- plm(lwage~educ+black+hisp+exper+expersq+married+union+
                   d81+d82+d83+d84+d85+d86+d87, data=WAGEPANEL, model = "within")
summary(Exemplo22)

#--------------------------------------------------------------------------

### EXEMPLO 23 E 24 - ESCOLHA ENTRE POLS, EFEITOS ALEAT�RIOS OU EFEITOS FIXOS

# Teste de Breush-Pagan para escolha entre POLS ou efeitos aleat�rios
plmtest(Exemplo21, effect = c("individual"), type = c("bp"))

# Teste de Hausman para escolha entre efeitos fixos ou aleat�rios
phtest(Exemplo21, Exemplo22)



#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERC�CIOS
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### Exerc�cio E

# Carregar arquivo
load("GRUNFELD.rda")  

# Checar se OBJETO arquivo foi carregado
ls()

## Regress�o com dados agrupados, efeitos aleat�rios e efeitos fixos
library(plm)
GRUNFELDPANEL <- pdata.frame(Grunfeld, index = c("firm","year"))

# Dados agrupados
ExercicioE1 <- plm(inv~value+capital, data=GRUNFELDPANEL, model = "pooling")
summary(ExercicioE1)

# efeitos aleat�rios
ExercicioE2 <- plm(inv~value+capital, data=GRUNFELDPANEL, model = "random")
summary(ExercicioE2)

# efeitos fixos
ExercicioE3 <- plm(inv~value+capital, data=GRUNFELDPANEL, model = "within")
summary(ExercicioE3)

# Teste de Breush-Pagan para escolha entre POLS ou efeitos aleat�rios
plmtest(ExercicioE2, effect = c("individual"), type = c("bp"))

# Teste de Hausman para escolha entre efeitos fixos ou aleat�rios
phtest(ExercicioE2, ExercicioE3)

### Incluindo vari�veis dummy de tempo

# efeitos aleat�rios (o termo "factor(...)" exerce o mesmo efeito de se criar v�rias vari�veis dummy)
ExercicioE4 <- plm(inv~value+capital+factor(year), data=GRUNFELDPANEL, model = "random")
summary(ExercicioE4)

# efeitos fixos
ExercicioE5 <- plm(inv~value+capital+factor(year), data=GRUNFELDPANEL, model = "within")
summary(ExercicioE5)

# Teste de Breush-Pagan para escolha entre POLS ou efeitos aleat�rios
plmtest(ExercicioE4, effect = c("individual"), type = c("bp"))

# Teste de Hausman para escolha entre efeitos fixos ou aleat�rios
phtest(ExercicioE4, ExercicioE5)

#--------------------------------------------------------------------------


# Encerrar grava��o do arquivo de resultados
sink()


# Apagar a mem�ria
rm(list=ls())




