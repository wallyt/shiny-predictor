library(shiny)
library(scales)
library(randomForest)
library(ROCR)

training <- read.csv("data/training.csv")
testing <- read.csv("data/testing.csv")

# Test-run a random forest
set.seed(42)
fit <- randomForest(factor(Performance) ~ ., importance = T, data = training)
preds <- predict(fit, testing)
matrix <- confusionMatrix(testing$Performance, preds)

pr <- predict(fit, testing, type = "prob")[,2]
pred <- prediction(pr, testing$Performance)
perf <- performance(pred, "tpr", "fpr")
perfAUC <- performance(pred, "auc")
auc <- perfAUC@y.values[[1]]

shinyServer(
    function(input, output) {
        output$vars <- renderPrint({input$varID})
        output$accur <- renderPrint({percent(matrix$overall[1])})
        output$confuse <- renderPrint({matrix$table})
        output$roc <- renderPlot({
                plot(perf, main = "ROC Curve for Random Forest", col=2, lwd=2) 
                abline(a=0,b=1,lwd=2,lty=2,col="gray") 
                text(0.8,0.4,paste("AUC = ",format(auc, digits=5, scientific=FALSE)))
        })
    }
)
