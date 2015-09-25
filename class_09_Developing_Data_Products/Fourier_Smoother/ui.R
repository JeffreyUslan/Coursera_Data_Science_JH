
library(shiny)

shinyUI(fluidPage(
  navbarPage("Fourier Smoother Demonstration", 
             tabPanel("Smoother",
                      # Application title
                      # titlePanel("Fourier Smoother Demo"),
                      
                      # Sidebar with a slider input for number of bins
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("Threshold",
                                      "Threshold Cutoff:",
                                      min = 1, max = 100, step = .5, value = 99.5, animate=TRUE)
                        ),
                        
                        mainPanel(
                          tabsetPanel(
                            tabPanel(p(icon("line-chart"),"Frequency Filter"),
                                     h4('Time Domain', align = "center"),
                                     plotOutput("fourier_smoother_high_freq_plot"),
                                     h4('Frequency Domain', align = "center"),
                                     plotOutput("fourier_smoother_high_freq_domain_plot")
                            ),
                            tabPanel(p(icon("line-chart"),"Amplitude Filter"),
                                     h4('Time Domain', align = "center"),
                                     plotOutput("fourier_smoother_low_amp_plot"),
                                     h4('Frequency Domain', align = "center"),
                                     plotOutput("fourier_smoother_low_amp_domain_plot")
                            )
                          ) # end of tabsetPanel
                        ) #end of mainpanel
                      ) #end of slider layout
             ), #end of fourier tab panel
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("about.md")
                      )
             ) # end of "About" tab panel
  )#end of navbarPanel
) # end of fluidPage
) # end of shinyUI
