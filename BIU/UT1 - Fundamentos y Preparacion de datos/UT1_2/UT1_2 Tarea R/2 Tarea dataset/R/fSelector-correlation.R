library(FSelector)
library(mlbench)
data(BostonHousing)

# se dejan unicamente las variables numericas. Asi se filtra una
# variable llamada chas
d=BostonHousing[-4]

# se calculan los pesos mediante correlacion lineal, La variable
# clase se llama medv
weights <- linear.correlation(medv~., d)

# se muestran los pesos
print(weights)

# se seleccionan los tres mejores
subset <- cutoff.k(weights,3)
f <- as.simple.formula(subset,"medv")
print(f)

# se utilizan los pesos mediante rank.correlation
weights <- rank.correlation(medv~.,d)

# se muestran los pesos
print(weights)

# se seleccionan los mejores
subset <- cutoff.k(weights,3)
f <- as.simple.formula(subset,"medv")
print(f)

