library(shiny)

shinyServer(
    function(input, output) {
        output$vars <- renderPrint({input$varID})
    }
)
