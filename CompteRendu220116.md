#Compte-rendu
##Séances du 21/01/2016 et du 22/01/2016
###Tâches effectuées

* Création d'un compte Twitter pour assurer la liaison à l'API Twitter
* Commandes de connexion à l'API depuis RStudio
* Déploiement de RStudio sur un serveur distant : [Serveur](http://81.4.125.72:8787/)

###Avancement du projet
####Fait
* Récupération des tweets

####À faire
* Analyse des tweets (graphes, wordcloud)
* Création de l'interface Shiny

###Annexe : Code utilisé
` install.packages("twitteR")`

` library(twitteR)`

` api_key <- "fIZMJKnLQ2RuGQQEEizjy2GzA"`

` api_secret <- "fEnlXSOzuMWUAcg9x9g2AAWjT3mxMQ4l4ZbeLnfcH7S4IEIV4L"`

` token <- "4835171254-cMJUm81pHUMRNZCYd0xX0q8ZHzPQqDeqBaoCkM4"`

` token_secret <- "NKhbXctNNEbdKGulVtb6hrydq3VXTriZw2kYMKgp7PJZL"`

` setup_twitter_oauth(api_key, api_secret, token, token_secret)`

` 1`

` tweets <- searchTwitter("Mascherano", n=100, lang="en", since="2016-01-20")`

` tweets.df <- twListToDF(tweets)`

###Annexe : Sources
[Analyse de tweets](http://francoisguillem.fr/meetup/twitter/#1)

[Collecting Tweets Using R and the Twitter Search API](http://bogdanrau.com/blog/collecting-tweets-using-r-and-the-twitter-search-api/)
