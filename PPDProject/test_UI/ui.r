library(shiny)

# Define UI for slider demo application
shinyUI(pageWithSidebar(
  
  
  #  Application title
  headerPanel("Parameters"),
  
  # Sidebar with sliders that demonstrate various available options
  sidebarPanel(
    
    #Search keywords
    textInput("keywords", "Keywords :", ""),
    actionButton("search", "Search"),
    
    # Simple integer interval
    sliderInput("integer", "Max tweets display:", 
                min=0, max=1000, value=500),
    
    
    dateRangeInput('dateRange',
                   label = 'Date range',
                   start = Sys.Date() - 2, end = Sys.Date() + 2
    ),
    
    
    # Animation with custom interval (in ms) to control speed, plus looping
    sliderInput("animation", "Looping Animation:", 1, 2000, 1, step = 10, 
                animate=animationOptions(interval=300, loop=T))
  ),
  
  # Show a table summarizing the values enteredYy
  mainPanel(
    h2('List of tweets found'),
    dataTableOutput('tweets_list')
  )
))