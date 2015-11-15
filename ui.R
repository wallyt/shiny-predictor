library(shiny)

training <- read.csv("data/training.csv")
testing <- read.csv("data/testing.csv")

shinyUI(pageWithSidebar(
    headerPanel("Predicting Loan Performance"),
    sidebarPanel(
        h4('Potential predictors of loan performance'),
        br(),
        checkboxGroupInput("varID", "Select the variables to be used in the model",
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
                    step = 5),
        submitButton("Run it!")
    ),
    mainPanel(
        h3('Result of random forest model'),
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
))
