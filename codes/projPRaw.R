require(readxl)
require(prospectr)
require(pls)
require(caret)

datar <- read_xlsx("Data.xlsx", sheet=3)
X <- datar[,2:1558]
y <- datar[,1562]
data <- X
data$P <- y

set.seed(70)
mod <- train(P~., data = as.matrix(data), method = "pcr",
             trControl = trainControl(method = "cv", number = 10),
             tuneLength = 30)

mod$best <- mod$results[mod$bestTune$ncomp,]
print('PCR Model for P with raw spectra data:')
print(paste('R2:', mod$best$Rsquared))
print(paste('r:', sqrt(mod$best$Rsquared)))
print(paste('RMSE:', mod$best$RMSE))
print(paste('RPD:', sd(as.vector(t(y)))/mod$best$RMSE))

pred <- predict(mod, data)
plot(cbind(y, pred), xlab="Reference P (ppm)", ylab="Predicted P (ppm)", pch = 18)
abline(0, 1)