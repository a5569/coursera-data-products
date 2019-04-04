#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(dslabs)
data(murders)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$fit <- renderPlot({
    
    fData <- if (input$region == 'All regions') {
      murders
    } else {
      murders[murders$region == input$region,]
    }
    
    # generate bins based on input$bins from ui.R
    fit <- lm(data = fData, total ~ population)
    qplot(data = fData, x = population, y = total) + stat_smooth(method = "lm") + ylab('Total gun murders in 2010') + xlab('Population')
  })
  
  output$table <- renderTable({
    fData <- if (input$region == 'All regions') {
      murders
    } else {
      murders[murders$region == input$region,]
    }
    fData %>% mutate(murder_rate_per_100000 = total/population*100000) %>% select(region, state, murder_rate_per_100000, gun_murders = total, population) %>% arrange(desc(murder_rate_per_100000)) %>% top_n(5)
  }, spacing = 'l', align = 'c', width = '95%')
  
  output$table_text <- renderPrint({
    if (input$region == 'All regions') {
      'Top 5 murder rate by state in the U.S.' 
    } else {
      paste('Top 5 murder rate by state in the region ', input$region)
    }
  })
  
  output$plot_text <- renderPrint({
    if (input$region == 'All regions') {
      'Total number of murders by gun fire vs population for the each state in the U.S.' 
    } else {
      paste('Total number of murders by gun fire vs population for the each state in the region ', input$region)
    }
  })
})
