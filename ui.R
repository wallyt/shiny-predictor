library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Predicting Loan Performance"),
    sidebarPanel(
        h3('Select the variables to be used in the model'),
        checkboxGroupInput("varID", "Variables",
                           c("Original Loan Amount" = "Original.Balance",
                             "Loan to Value Ratio" = "Loan.to.Value", 
                             "Property Appraised Value" = "Appraised.Price",
                             "# Years Investing Experience" = "Years.Investing", 
                             "Credit Score" = "Credit.Score")
        ),
        sliderInput('range', 'Adjust the range of (normalized) credit scores to be used', 
                    value = min(training$Credit.Score), 
                    min = min(training$Credit.Score), 
                    max = max(training$Credit.Score), 
                    step = 0.05),
        submitButton("Run it!")
    ),
    mainPanel(
        h3('Result of random forest model'),
        h4("You've selected:"),
        verbatimTextOutput("vars"),
        h4("Which resulted in an accuracy on the test set of:"),
        verbatimTextOutput("accur"),
        h4("With a confusion matrix of:"),
        verbatimTextOutput("confuse"),
        h4("ROC"),
        plotOutput('roc')
    )
))
