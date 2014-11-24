#This application will take input from the user in the form of a stock symbol and date range
#and it will reactively draw a graph and test if the time series is stationary or not.
#There are also 2 tick boxes which can be used to adjust prices for inflation and one to 
#plot the y-axis on a log scale.

library(shiny)

shinyUI(fluidPage(
  titlePanel("stock chart"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select a stock to examine. 
        Information will be collected from yahoo finance."),
    
      textInput("symb", "Symbol", "SPY"),
    
      dateRangeInput("dates", "Date range",
        start = as.character(Sys.Date()-365), 
        end = as.character(Sys.Date())),
      br(),
      
      checkboxInput("log", "Plot y axis on log scale", 
        value = FALSE),
      
      checkboxInput("adjust", 
        "Adjust prices for inflation", value = FALSE)
    ),
    
    mainPanel(
      plotOutput("plot"),
      br(),
      helpText("Lets's test for a unit root and see if the time series is stationary:"),
      #actionButton("get", "Test for stationarity"),
      br(),
      textOutput("pval"),
      br()
    )
  )
))
