library(shiny)
library(BH)
library(RcppEigen)

training <- read.csv("data/training.csv")
testing <- read.csv("data/testing.csv")

shinyUI(fluidPage(style = "margin-bottom: 20px",
    h1("You-Build-It Loan Performance Predictor", 
       style = "color: #FFF; background-color: #4B5B75; text-align: center; padding: 15px"),
    fluidRow(h4('This is an interactive application that fits and then validates a random forest predictive model
                on a preloaded dataset of loans made to residential real estate investors. 
               Below are the potential input variables that can be used to predict the loans\' performance, and 
               you\'re in control!', style = "padding: 5px 20px")
    ),
    br(),
    fluidRow(
        column(4, style = "background-color: #E6F1F5; margin-left: 15px; padding-bottom: 15px",
            h3('Instructions'),
            p('To run the model:'),
            tags$ol(
                tags$li('Decide which input factors should go into the model by selecting or deselecting 
                        any of the variables below'),
                tags$li('If you select "Credit Score", you can adjust the range of borrowers\' scores with the slider'),
                tags$li('Clicking "Run it!" will automatically fit a random forest model to a training set and then 
                        validate the model'),
                tags$li('Gauge the predictability of your model by the accuracy, the confusion matrix and the AUC 
                        calculation in the chart (AUC of 1.0 = perfect, AUC of 0.5 = random guess, so higher is better)'),
                tags$li('Change which input factors should be used and rerun it to see if you can 
                        build a more accurate model!')
            ),
            h3('Potential predictors selection'),
            br(),
            checkboxGroupInput("varID", "Select the input variables to be used in the model",
                           c("Original Loan Amount" = "Original.Balance",
                             "Loan to Value Ratio" = "Loan.to.Value", 
                             "Property Appraised Value" = "Appraised.Price",
                             "# Years Investing Experience" = "Years.Investing", 
                             "Credit Score" = "Credit.Score"),
                           selected = c("Loan to Value Ratio", "Credit Score")
            ),
            br(),
            sliderInput('range', 'Adjust the range of credit scores to be used', 
                        value = c(min(training$Credit.Score), max(training$Credit.Score)),
                        min = min(training$Credit.Score), 
                        max = max(training$Credit.Score), 
                        step = 5)
            ,
                span(submitButton("Run it!"), style = "text-align: center")
        ),
        column(7, style = "margin-left: 10px",
            h3('Result of random forest model'),
            br(),
            h4("You've selected:"),
            verbatimTextOutput("vars"),
            h4("And a range of credit scores of:"),
            verbatimTextOutput("cr-range"),
            h4("Which resulted in an accuracy on the test set of:"),
            verbatimTextOutput("accur"),
            h4("With a confusion matrix of:"),
            verbatimTextOutput("confuse"),
            h4("ROC"),
            plotOutput('roc')
        )
    )
))
