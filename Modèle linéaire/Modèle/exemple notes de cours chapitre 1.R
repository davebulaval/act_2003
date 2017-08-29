x <- c(2,3,6,9,12)
y <- c(2,5,3,6,5)

#estimations parametres
reg <- lm(y~x)
#résumé des estimations
summary(reg)
#valeur de y^
fitted(reg)
#valeur des résiduts E^
residuals(reg)
