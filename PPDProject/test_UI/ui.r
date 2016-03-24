library(shiny)
library(twitteR)


shinyUI(pageWithSidebar(
  headerPanel("Analyse de tweets"),
  
  sidebarPanel(textInput("term", "Entrer un mot", "twitter"),
               sliderInput("cant", "Choisir un nombre de tweets",min=5,max=100, value = 5),
#                radioButtons("lang", "Choisir une langue", c(
#                  "Français"="fr",
#                  "English"="en")),
               selectInput("lang", label = "Langue", 
                           choices = list("Français" = "fr", "English" = "en"), 
                           selected = 1),

               dateRangeInput('dateRange',
               label = 'Tweeté entre le',
               start = Sys.Date() - 2, end = Sys.Date() + 2,
               separator = " et le ", format = "dd/mm/yy", language = "fr"
               ),
               submitButton(text = "Recherche"),
               
               downloadButton("download", "Télécharger")),
          
  
  
  mainPanel(
    h4("Liste des tweets"),
    tableOutput("table"),
    plotOutput("wordcl"))
))