library(shiny)
library(twitteR)


shinyUI(pageWithSidebar(
  headerPanel("Analyse de tweets"),
  
  sidebarPanel(textInput("term", "Entrer un mot", "twitter"),
               sliderInput("cant", "Choisir un nombre de tweets",min=5,max=100, value = 5),
               radioButtons("lang", "Choisir une langue", c(
                 "Français"="fr",
                 "English"="en")),
               submitButton(text = "Recherche"),
               
               downloadButton("download", "Télécharger")),
  
  
  mainPanel(
    h4("Liste des tweets"),
    tableOutput("table"),
    plotOutput("wordcl"))
))