#==========================================================================================================
# Programa de An�lise Fatorial
# Prof Dra Maria Aparecida Gouvea
#==========================================================================================================


#==========================================================================================================
# O comando "install.packages" do R � utilizado para instalar os pacotes: corrplot, FactoMineR, 
# factoextra, psych, nFactors. Este comando deve ser executado apenas na primeira vez em que se estiver instalando estes
# pacotes no computador aonde ser� executado o estudo de An�lise Fatorial. Depois que os pacotes j� tiverem
# sido instalados, basta colocar na frente do comando "install.packages" o carater de coment�rios # .
#==========================================================================================================


#--- Pacote utilizado para Calcular e plotar a Matriz de Correla��o ---
#install.packages("corrplot",dep=TRUE)

#--- Pacote utilizado para Execu��o da An�lise Fatorial Explorat�ria ---
#install.packages("psych", dep=TRUE)
#install.packages("nFactors", dep=TRUE)
#install.packages("FactoMineR", dep=TRUE)
#install.packages("factoextra", dep=TRUE)


#==========================================================================================================
# Comandos para carregar os pacotes que foram instalados anteriormente
#==========================================================================================================

library(corrplot)
library(psych)
library(nFactors)
library(FactoMineR)
library(factoextra)


#==========================================================================================================
# Colocando o Endere�o do Diret�rio de onde o arquivo com os Dados sera lidos
#==========================================================================================================

setwd("D:\\Users\\25052288840\\Downloads")


#===========================================================================================================
# Lendo Arquivo de Dados
#===========================================================================================================

Dados1 <- data.frame(read.csv2("Micros.csv", head=T, sep=";", dec=","))
Dadosfinal <- Dados1[,2:7]

Dadosfinal
#===========================================================================================================
# Matriz de Correla��o das Var�aveis
#===========================================================================================================

Matcorrela��o <- cor(Dadosfinal)
print(Matcorrela��o,digit=3)

#===========================================================================================================
# Rodando o KMO (Todas Vari�veis) e MSA (Para cada vari�vel- Diagonal da Matriz AntiImagem)
#===========================================================================================================

KMO(Matcorrela��o)

#===========================================================================================================
# Calculando a Matriz de Correla��o dos Dados - (A primeira coluna, que � ID dos dados, n�o ser� utilizada) 
#===========================================================================================================

#--- Escolhendo o N�mero de Autovalores( Por exemplo: AutoValores > 1)
teste.pca <- PCA(Dadosfinal, scale.unit = TRUE , ncp = ncol(Dadosfinal) , graph = FALSE)
teste.pca$eig
barplot(teste.pca$eig[,1],main="Eigenvalues",names.arg=1:nrow(teste.pca$eig))

#---- Determinando o n�mero de fatores ( AutorValor > 1)
numerodefatores = sum(teste.pca$eig[,1] > 1)
print(numerodefatores)

#--- Rodando Com o Numero de Fatores Escolhidos Auto Valor> 1)
teste.pca <- PCA(Dadosfinal, scale.unit = TRUE , ncp = numerodefatores , graph = TRUE)
teste.pca$eig
fviz_eig(teste.pca, addlabels = TRUE)

#---- Comunalidade ----
Comunalidade <- teste.pca$var$cos2[,1]+teste.pca$var$cos2[,2]
print(Comunalidade,digit=3)

#--- Coordenada Sem Rota��o
teste.pca$var$coord


# --- Utilizou-se VARIMAX com  M�todo de Rota��o dos Fatores ---
Fitvarimax <- principal(Matcorrela��o, nfactors=numerodefatores, n.obs = nrow(Dadosfinal),  rotate="varimax", method =regression)
print(Fitvarimax, cutoff=0, digits=3)

#---- Escores ----
ScoreBruto <- as.matrix(Dadosfinal) %*% as.matrix(Fitvarimax$loadings[,1:2])
ScoreNormalizado <- scale(ScoreBruto)
ScoreNormalizado
sort(ScoreNormalizado[,1])
order(ScoreNormalizado[,1])
sort(ScoreNormalizado[,2], decreasing = TRUE)
order(ScoreNormalizado[,2], decreasing = TRUE)



ScoreNormalizado


#===============================================================================================================
# FIM
#===============================================================================================================
