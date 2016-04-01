library(shiny)
library(twitteR)


shinyUI(pageWithSidebar(
  headerPanel("Analyse de tweets"),
  
  sidebarPanel(textInput("term", "Entrer un mot", "Data Mining"),
               sliderInput("cant", "Choisir un nombre de tweets",min=100,max=500, value = 100),
#                radioButtons("lang", "Choisir une langue", c(
#                  "Français"="fr",
#                  "English"="en")),
                sliderInput("freq", "Fréquence d'apparition du mot",min=1,max=30, value = 3),
               selectInput("lang", label = "Langue", 
                           choices = list("Français" = "fr", "English" = "en"), 
                           selected = 1),

               dateRangeInput('dateRange',
               label = 'Tweeté entre le',
               start = Sys.Date() - 30, end = Sys.Date() ,
               separator = " et le ", format = "dd/mm/yy", language = "fr"
               ),
               submitButton(text = "Recherche"),
               
               downloadButton("download", "Télécharger")),
          
  
  
  mainPanel(
    h4("Top 5 des mots"),
    tableOutput("tableau"),
    plotOutput("wordcl"))
    #h4("Liste des tweets"),
    #tableOutput("table"))
))