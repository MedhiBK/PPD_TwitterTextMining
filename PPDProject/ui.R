fluidPage(
  # Application title
  titlePanel("Word Cloud"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      textInput("term", "Entrer un mot", "Data Mining"),
      actionButton("update", "Change")
    ),
    
    # Show Word Cloud
    mainPanel(
      plotOutput("plot")
    )
  )
)