#
# Code pour la modification du dataset Test et train
# Ajout de l'âge
#

library(dplyr)
library(mice)

# Modification des datasets
setwd("~/GitHub/act_2003")
dataTest <- read.csv('data/Titanic/test.csv', stringsAsFactors = F)
dataTrain <- read.csv('data/Titanic/train.csv', stringsAsFactors = F)

full  <- bind_rows(dataTrain, dataTest)

factor_vars <- c('PassengerId','Pclass','Sex','Embarked')

full[factor_vars] <- lapply(full[factor_vars], function(x) as.factor(x))


set.seed(129)
# Perform mice imputation, excluding certain less-than-useful variables:
mice_mod <- mice(full[, !names(full) %in% c('PassengerId','Name','Ticket','Cabin','Survived')], method='rf') 

# Save the complete output 
mice_output <- complete(mice_mod)

# Plot age distributions
par(mfrow=c(1,2))
hist(full$Age, freq=F, main='Age: Original Data', 
     col='darkgreen', ylim=c(0,0.04))
hist(mice_output$Age, freq=F, main='Age: MICE Output', 
     col='lightgreen', ylim=c(0,0.04))

# Replace Age variable from the mice model.
full$Age <- mice_output$Age

dataTrain$Age <- full$Age[1:891]
dataTest$Age <- full$Age[892:length(full$Age)]

# Write on dataset
write.csv(dataTrain, paste('data/Titanic/train.csv',sep = ""),
          row.names = FALSE, fileEncoding = "UTF-8")
write.csv(dataTest, paste('data/Titanic/test.csv',sep = ""),
          row.names = FALSE, fileEncoding = "UTF-8")
