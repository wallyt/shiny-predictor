library(shiny)
library(dplyr)
library(scales)
library(randomForest)
library(ROCR)
library(caret)

training <- read.csv("data/training.csv")
training$Performance <- factor(training$Performance, levels = c("Good", "Bad"))
testing <- read.csv("data/testing.csv")
testing$Performance <- factor(testing$Performance, levels = c("Good", "Bad"))

# Test-run a random forest
forest <- function(toggle, credits, inputs) {
    if(toggle == 1) {
        train <- training %>% filter(Credit.Score >= credits[1], 
                                    Credit.Score <= credits[2])
        test <- testing %>% filter(Credit.Score >= credits[1], 
                                    Credit.Score <= credits[2])
    } else {
        train <- training
        test <- testing
    }
    
    Formula <- formula(paste("factor(Performance) ~", 
                             paste(inputs, collapse="+")))
    set.seed(42)
    fit <- randomForest(Formula, importance = T, data = train)
    set.seed(42)
    preds <- predict(fit, test)
    matrix <- confusionMatrix(preds, test$Performance)
    # Build ROC curve data and AUC value
    set.seed(42)
    pr <- predict(fit, test, type = "prob")[,1]
    set.seed(42)
    pred <- prediction(pr, test$Performance)
    perf <- performance(pred, "tpr", "fpr")
    perfAUC <- performance(pred, "auc")
    auc <- perfAUC@y.values[[1]]

    returnList <- list("matrix" = matrix, "perf" = perf, "auc" = auc)
    return(returnList)
}

shinyServer(
    function(input, output) {
        returnList <- reactive({
            toggle <- ifelse("Credit.Score" %in% input$varID, 1, 0)
            credits <- c(input$range[1], input$range[2])
            factors <- input$varID
            forest(toggle, credits, factors)
        })
        output$accur <- renderPrint({
            returnList()
            percent(returnList()$matrix$overall[1])
        })
        output$confuse <- renderPrint({returnList()$matrix$table})
        output$roc <- renderPlot({
            plot(returnList()$perf, main = "ROC Curve for Random Forest", col=2, lwd=2) 
            abline(a=0,b=1,lwd=2,lty=2,col="gray") 
            text(0.8,0.4,paste("AUC = ",format(returnList()$auc, digits=5, scientific=FALSE)))
        })
        
        output$vars <- renderText({
            paste(input$varID, " ")
        })
        output$`cr-range` <- renderText({
            paste(input$range[1], "to", input$range[2])
        })
    }
)
