library(tidyverse)
library(shiny)
library(readxl)

df <- read_excel("~/KU MSASDS/KU-DATA 824-Data Vis/DATA 824 Week 7/Homework 7/Capstone Final/GHG_data_for_APP.xlsx")


# Define UI for random distribution app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Global CO2 Emissions vs. Temperature"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Specify the number of observations to view ----
      (numericInput("Year", "Choose year:", 1960, 
                   min = 1880, max = 2020)),

      # Include clarifying text ----
      helpText("Enter a year between 1880 and 2020, incl."),
      
      br(),
      
      h4("Results:"),
      
      h5("Year:"),
      verbatimTextOutput("Year"),
      
      # Output: give CO2 for year chosen
      h5("CO2 (10^6 metric tonnes):"),
      verbatimTextOutput("CO2value"),

      
      # Output: give temp for year chosen
      h5("Temp Anomaly (deg. C):"),
      verbatimTextOutput("Tempvalue")
            
    ),
    

    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("CO2", plotOutput("CO2plot")),
                  tabPanel("Temperature", plotOutput("Tempplot")),
                  tabPanel("Notes", textOutput("Notes"))
      )
      
    )
  )
)




# Define server logic for random distribution app ----
server <- function(input, output) {

  d <- reactive({
    filter(df, Year == input$Year)
  })
  
  output$Year <- renderText({
    input$Year
  })
  
  output$CO2value <- renderText({
    df <- d()
    df$CO2[df$Year == input$Year]
  })
  
   output$Tempvalue <- renderText({
    df <- d()
    df$Temp[df$Year == input$Year]
  })
  

  
  
  # Generate a plot of the carbon dioxide emissions ----
  output$CO2plot <- renderPlot({
    plot(df$Year, df$CO2, 
         xlab = 'Year', ylab = 'Annual CO2 Emissions (million metric tonnes)', 
         col='blue', main='Global CO2 Emissions')
    Year <- input$Year
    lines(c(Year, Year), c(-100, 170000), col="red", lwd=3)
    
    
  })
  
  # Generate a plot of the temperature ----
  output$Tempplot <- renderPlot({
    plot(df$Year, df$Temp, 
         xlab = 'Year', ylab = 'Temperature Anomaly (deg. C)', 
         col='red', main='Global Temperature Anomaly')
    Year <- input$Year
    lines(c(Year, Year), c(-2, 2), col="blue", lwd=3)
  })

  # Generate Notes Page ----
  output$Notes <- renderText(paste("The carbon dioxide emissions are the total carbon dioxide 
                                   emissions for the world for all of the reporting countries.
                                   The emissions data was obtained from the following site: 
                                   https://github.com/owid/co2-data.
                                   The temperature anomaly is a relative number in degrees  
                                   Celsius, and it is relative to the temperature baseline 
                                   established between 1951-1980. More information about this  
                                   can be found at: https://data.giss.nasa.gov/gistemp/faq/abs_temp.html"))
  
}


# Create Shiny app ----
shinyApp(ui, server)