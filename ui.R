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
        submitButton("Run it!")
    ),
    mainPanel(
        h3('Result of random forest model'),
        h2("You've selected:"),
        verbatimTextOutput("vars")
    )
))
