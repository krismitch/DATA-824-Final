library(readxl)
df <- read_excel("~/KU MSASDS/KU-DATA 824-Data Vis/DATA 824 Week 7/Homework 7/Capstone Final/GHG_world.xlsx")

#View(df)

shinyServer(
  function(input, output) {
    output$lineplot <- renderPlot({
      plot(df$Year, df$'Average Global CO2', 
           xlab = 'Year', ylab = 'Average Global CO2 Emissions', 
           col='blue', main='Global Average GHG Emissions')
      Year <- input$Year
      lines(c(Year, Year), c(0, 700), col="red", lwd=5)
      
      
#      CO2 <- (df$'Average Global CO2')
    })
  }
)
