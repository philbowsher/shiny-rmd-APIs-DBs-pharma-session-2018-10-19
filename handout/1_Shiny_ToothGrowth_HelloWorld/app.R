library(shiny)

# Define UI for miles per gallon app ----
ui <- pageWithSidebar(
  
  # App title ----
  headerPanel("Toothgrowth Plot"),
  
  # Sidebar panel for inputs ----
  sidebarPanel(
      radioButtons("plotType", "Plot type",
                   c("Scatter"="p", "Line"="h")
      )
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      
      # Output: Formatted text for caption ----
      h3(textOutput("caption")),
      
      
      
      plotOutput("plot")
    )
  )

# Define server logic to plot various variables against toothgrowth ----
server <- function(input, output){
  
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste("plot type ~", input$plotType)
  })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })
  
  

# Render a renderPlot or renderImage within an application page. 
# Renders a reactive plot that is suitable for assigning to an output slot.
  output$plot <- renderPlot({
    
    # Generic function for plotting of R objects
    # Generate a plot of the requested variable against mpg ----
    plot(ToothGrowth$dose, ToothGrowth$len, type=input$plotType, col = "#75AADB")
  })
  
  
}

#  Finally the shinyApp function creates Shiny app objects from an explicit UI/server pair
shinyApp(ui = ui, server = server)