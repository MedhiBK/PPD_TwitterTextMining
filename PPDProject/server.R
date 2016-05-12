function(input, output, session) {
  terms <- reactive({
    input$update
    isolate({
      withProgress({
        setProgress(message = "Analyse en cours...")
        getTermMatrix(input$term, input$lang, input$cant, input$search_date[1], input$search_date[2])
      })
    })
  })
  wordcloud_rep <- repeatable(wordcloud)
  output$plot <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = 0, max.words=50,
                  colors=brewer.pal(8, "Dark2"))
  })
  
  
  output$table <- renderTable({
    v <- terms()
    head(cbind(v, names(v)),n=input$cant)
  })
#  
  #output$download <- downloadHandler(filename = function() {paste(input$term, '.csv', sep='')},
  #                                   content = function(file){
  #                                     write.csv(names(v), file)
  #                                   }
  #)
}