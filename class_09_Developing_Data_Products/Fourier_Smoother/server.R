
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  output$fourier_smoother_high_freq<- renderPlot({
    Threshold=input$Threshold
    fourier_smoother_high_freq(Threshold)
  })
  
  output$fourier_smoother_low_amp<- renderPlot({
    Threshold=input$Threshold
    fourier_smoother_low_amp(Threshold)
    # plot(runif(100))
  })
  
})
