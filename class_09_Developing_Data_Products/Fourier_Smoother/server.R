
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  output$fourier_smoother_high_freq_plot<- renderPlot({
    Threshold=input$Threshold
    fourier_smoother_high_freq_plot(Threshold)
  })
  
  output$fourier_smoother_low_amp_plot<- renderPlot({
    Threshold=input$Threshold
    fourier_smoother_low_amp_plot(Threshold)
    
  })
  
  output$fourier_smoother_high_freq_domain_plot<- renderPlot({
    Threshold=input$Threshold
    fourier_smoother_high_freq_domain_plot(Threshold)
  })
  
  output$fourier_smoother_low_amp_domain_plot<- renderPlot({
    Threshold=input$Threshold
    fourier_smoother_low_amp_domain_plot(Threshold)
  })
})
