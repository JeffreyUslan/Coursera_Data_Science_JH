
library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Fourier Smoother Demo"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("Threshold",
                  "Threshold Cutoff:",
                  min = .5, max = 100, step = .5, value = 0)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Frequency Filter",plotOutput("fourier_smoother_high_freq")),
        tabPanel("Amplitude Filter",plotOutput("fourier_smoother_low_amp"))
      )
    )
  )
))
