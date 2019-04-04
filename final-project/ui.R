library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Gun murder for the U.S. from FBI reports in 2010"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput('region', 'Select and region from U.S.', c('All regions', 'South', 'West', 'Northeast', 'North Central')),
      h4('Intro'),
      p('This report show the data from the FBI 2010 gun murder, this dataset is provided by the "dslabs" package. With this report you can select each region from the U.S. and it with plot the population and the total of murders by gun fire in 2010, it will also show the top 5 states with the highest murder rate, since the bigger the state population the bigger the total of murder, but the murder rate is not constant for every state.'),
      h4('How to use'),
      p('Just choose the region in the selector above and it will recalculate the data.')
    ),
    
    mainPanel(
      h3(textOutput('plot_text')),
      plotOutput('fit'),
      h3(textOutput('table_text')),
      tableOutput('table')
    )
  )
))
