shinyUI(fluidPage(
  # Application title
  headerPanel("Analyse de tweets"),
  
  sidebarPanel(textInput("term", "Entrer un mot", "zidane"),
               sliderInput("cant", "Choisir un nombre de tweets",min=5,max=500, value = 100),
               sliderInput("freq", "Fréquence d'apparition du mot",min=1,max=30, value = 5),
               selectInput("lang", label = "Langue", 
                           choices = list("Français" = "fr", "English" = "en"), 
                           selected = 1),
               
               dateRangeInput('search_date',
                              label = 'Tweeté entre le',
                              start = Sys.Date() - 30, end = Sys.Date() ,
                              separator = " et le ", format = "dd/mm/yy", language = "fr"
               ),
               bsTooltip("term", "Pour exclure un mot ajoutez un tiret - devant ce dernier",
                         "right", options = list(container = "body")),
               actionButton("update", "Change"),
               
               downloadButton("download", "Télécharger")),
  
  
  mainPanel(
    h4("Wordcloud"),
    plotOutput("plot"),
    h4("Top 5 des mots les plus fréquents"),
    plotOutput("fiveWord")
    
)))