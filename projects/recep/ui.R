library(shiny)
fluidPage(
  titlePanel("flight delay by distance"),
  mainPanel(
    plotOutput("flightDelayPlot")
  )
)