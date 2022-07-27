shinyUI(pageWithSidebar(
  headerPanel("Carbon Dioxide Emissions vs. Global Temperature"),
  sidebarPanel(
    sliderInput('Year', 'Choose Year',value=1990, min=1949,max=2020,step=1,)
  ),
  mainPanel(
    plotOutput('lineplot')
  )
))