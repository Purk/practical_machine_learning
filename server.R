# server.R

library(quantmod)
library(tseries)
source("helpers.R")

shinyServer(function(input, output) {
  
  dataInput <- reactive({  
    getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  finalInput <- reactive({
    if (!input$adjust) return(dataInput())
    adjust(dataInput())
  })
  
  output$plot <- renderPlot({
    #chartSeries{quantmod} automatically displays the "close" column when chart is rendered.
    chartSeries(finalInput(), theme = chartTheme("white"), 
                type = "line", log.scale = input$log, TA = NULL)
  })
  
  output$pval <- renderPrint({
    if (adf.test(Ad(dataInput()), k=0)$p.value < 0.05) {
      cat(paste(input$symb, "is stationary!"))
    }else { 
      cat(paste(input$symb, "is not stationary"))
    }
  })
})
