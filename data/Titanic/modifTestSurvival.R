#
# Code pour la modification du dataset Test
# Ajout de l'état de survie, LogFare et Surname
#


# Modification du dataset Test
setwd("~/GitHub/act_2003")
dataTest <- read.csv('data/Titanic/test.csv', stringsAsFactors = T)

# Ajout surnom
dataTest$Surname <- as.factor(sapply(as.character(dataTest$Name),  
                                 function(x) strsplit(x, split = '[,]')[[1]][1]))

# Ajout du Log-Fare
dataTest$LogFare <- log(dataTest$Fare)
dataTest$LogFare[dataTest$LogFare == -Inf] <- 0

# Ajout de l'état de survie ou nom de façon aléatoire
set.seed(2017)
dataTest$Survived <- sample(x = c(0, 1), size = length(dataTest$PassengerId), replace = TRUE)

write.csv(dataTest, paste('data/Titanic/test.csv',sep = ""),
          row.names = FALSE, fileEncoding = "UTF-8")
