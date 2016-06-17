shinyUI(
  fluidPage(
    tags$style(type="text/css",
               ".shiny-output-error { visibility: hidden; }",
               ".shiny-output-error:before { visibility: hidden; }"
    ),
  # Application title
    shinyUI(
      navbarPage(
        title = 'Analyse de tweets',
        tabPanel("Thématique",  
          sidebarPanel(textInput("term", "Entrer un mot", "zidane"),
            bsTooltip("term", "Pour exclure un mot ajoutez un tiret - devant ce dernier",
                      "right", options = list(container = "body")),
            sliderInput("cant", "Choisir un nombre de tweets",min=5,max=500, value = 100),
            sliderInput("freq", "Fréquence d'apparition du mot",min=1,max=30, value = 5),
            selectInput("lang", label = "Langue", 
                        choices = list("Français" = "fr", "English" = "en"), 
                        selected = 1),
            dateRangeInput('search_date',
                           label = 'Tweeté entre le',
                           start = Sys.Date() - 30, end = Sys.Date() ,
                           separator = " et le ", format = "dd/mm/yy", language = "fr"),
            actionButton("update", "Rafraîchir"),
            downloadButton("download", "Télécharger")
          ),
          mainPanel(
             h4("Wordcloud"),
             plotOutput("plot"),
             h4("Top 5 des mots les plus fréquents"),
             plotOutput("fiveWord"),
             h4("Les tweets les plus populaires"),
             tableOutput("tweetList")
          )
        ), 
        tabPanel("Utilisateur", 
           sidebarPanel(
             textInput("username", "Entrer un nom d'utilisateur", ""),
             submitButton("Rafraîchir")
           ),
           mainPanel(
             imageOutput("avatar", 50, 50),
             h4("Nom de l'utilisateur"),
             textOutput("screenName"),
             h4("Date de création"),
             textOutput("created"),
             h4("Nombre de followers"),
             textOutput("followersCount"),
             h4("Nombre de tweets"),
             textOutput("statusesCount"),
             plotOutput("statusesCompare"),
             plotOutput("followersCompare")
           ) 
        )
      )
    )
  )
)