require(readxl)
require(prospectr)
require(pls)
require(caret)

datar <- read_xlsx("Data.xlsx", sheet=3)
X <- datar[,2:1558]
X <- data.frame(detrend(X, wav = as.numeric(colnames(X))))
y <- datar[,1564]
data <- X
data$N <- y

set.seed(72)
mod <- train(N~., data = as.matrix(data), method = "pcr",
             trControl = trainControl(method = "cv", number = 10),
             tuneLength = 30)

mod$best <- mod$results[mod$bestTune$ncomp,]
print('PCR Model for N with DT spectra data:')
print(paste('R2:', mod$best$Rsquared))
print(paste('r:', sqrt(mod$best$Rsquared)))
print(paste('RMSE:', mod$best$RMSE))
print(paste('RPD:', sd(as.vector(t(y)))/mod$best$RMSE))

pred <- predict(mod, data)
plot(cbind(y, pred), xlab="Reference N (%)", ylab="Predicted N (%)", pch = 20)
abline(0, 1)