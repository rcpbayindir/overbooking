library(shiny)

function(input, output) {
  output$flightDelayPlot <- renderPlot({
    ggplot(delay, aes(dist, delay)) +
      geom_point(aes(size = count), alpha = 1/2) +
      geom_smooth() +
      scale_size_area(max_size = 2)
  })
}
