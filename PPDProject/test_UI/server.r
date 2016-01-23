library(shiny)
library(datasets)
source("tweet_extract.r")

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  #Recherche des tweets
  library(twitteR)
  api_key <- "fIZMJKnLQ2RuGQQEEizjy2GzA" # From dev.twitter.com
  api_secret <- "fEnlXSOzuMWUAcg9x9g2AAWjT3mxMQ4l4ZbeLnfcH7S4IEIV4L" # From dev.twitter.com
  token <- "4835171254-cMJUm81pHUMRNZCYd0xX0q8ZHzPQqDeqBaoCkM4" # From dev.twitter.com
  token_secret <- "NKhbXctNNEbdKGulVtb6hrydq3VXTriZw2kYMKgp7PJZL" # From dev.twitter.com
  setup_twitter_oauth(api_key, api_secret, token, token_secret)
  tweets <- searchTwitter("Mascherano", n=100, lang="en", since="2016-01-20")
  tweets.df <- twListToDF(tweets)
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  #Render ?
  output$tweets_list = renderDataTable({
    tweets.df
    })
  
  # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
})