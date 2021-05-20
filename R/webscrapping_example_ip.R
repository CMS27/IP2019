###################################################
###################################################

install.packages("rvest")
install.packages("tidyverse")

library("rvest")
library("tidyverse")

###################################################
###################################################

# First exemple: lemonde.fr

url = 'https://www.lemonde.fr/'
webpage = read_html(url)

# Get the value of the accurate markup:
title = html_nodes(webpage, '.old__top-article .article__title')
real_title = html_text(title)
real_title

###################################################
###################################################

# Exercice 1: NYT
url = 'https://www.nytimes.com/'
webpage = read_html(url)
title = html_nodes(webpage, '.css-tub26b .e1voiwgp0')
real_title = html_text(title)
real_title

# Exercise 2: PAP
url = 'https://www.pap.fr/annonce/vente-appartements-paris-75-g439-3-pieces-a-partir-de-2-chambres'
pap = read_html(url)

###################################################################
###################################################################

# Back to the main line: IMDb website: Top 50 at US Box Office 1998

###################################################################
###################################################################

#Specifying the url for desired website to be scraped
url <- 'https://www.imdb.com/search/title/?title_type=feature&release_date=1998-01-01,1998-12-31&sort=boxoffice_gross_us,desc'

#Reading the HTML code from the website
webpage <- read_html(url)
rank_html <- html_nodes(webpage,'.text-primary')
rank <- html_text(rank_html)

#Let's have a look at the rankings
head(rank)

# Convert into numeric data:
rank = as.numeric(rank)

# Same for title
title_html <- html_nodes(webpage,'.lister-item-header a')

#Converting the title data to text
title <- html_text(title_html)
head(title)

#Using CSS selectors to scrape the Movie runtime section
runtime_html <- html_nodes(webpage,'.runtime')

#Converting the runtime data to text
runtime <- html_text(runtime_html)

#Let's have a look at the runtime
head(runtime)

#Data-Preprocessing: removing mins and converting it to numerical
runtime<-gsub(" min","",runtime)
runtime<-as.numeric(runtime)

#Let's have another look at the runtime data
head(runtime)

#Using CSS selectors to scrape the Movie genre section
genre_html <- html_nodes(webpage,'.genre')

#Converting the genre data to text
genre <- html_text(genre_html)

#Let's have a look at the runtime
head(genre)

#Data-Preprocessing: removing \n
genre<-gsub("\n","",genre)

#Data-Preprocessing: removing excess spaces
genre<-gsub(" ","",genre)

#taking only the first genre of each movie
genre<-gsub(",.*","",genre)

#Convering each genre from text to factor
genre<-as.factor(genre)

#Let's have another look at the genre data
head(genre)

#Using CSS selectors to scrape the IMDB rating section
rating_html <- html_nodes(webpage,'.ratings-imdb-rating strong')

#Converting the ratings data to text
rating <- html_text(rating_html)

#Let's have a look at the ratings
head(rating)

#Data-Preprocessing: converting ratings to numerical
rating<-as.numeric(rating)

#Let's have another look at the ratings data
head(rating)
length(rating)

#Using CSS selectors to scrape the metascore section
metascore_html <- html_nodes(webpage,'.metascore')

#Converting the runtime data to text
metascore <- html_text(metascore_html)

#Let's have a look at the metascore 
head(metascore)
#Data-Preprocessing: removing extra space in metascore
metascore_data<-gsub(" ","",metascore)

#Lets check the length of metascore data
length(metascore)

#Using CSS selectors to scrape the gross revenue section
gross_html <- html_nodes(webpage,'.ghost~ .text-muted+ span')

#Converting the gross revenue data to text
gross <- html_text(gross_html)

#Let's have a look at the votes data
head(gross)

#Data-Preprocessing: removing '$' and 'M' signs
gross<-gsub("M","",gross)

gross<-substring(gross,2,6)

gross = as.numeric(gross)

#Let's check the length of gross data
length(gross)


#Combining all the lists to form a data frame
movies_df<-data.frame(Rank = rank, Title = title,
                      Runtime = runtime,
                      Genre = genre, Rating = rating,
                      Revenue = gross)
str(movies_df)                    

library('ggplot2')

qplot(data = movies_df,Runtime,fill = Genre,bins = 30)

ggplot(movies_df,aes(x=Runtime,y=Rating))+
geom_point(aes(size=Revenue,col=Genre))

ggplot(movies_df,aes(x=Runtime,y=Rating))+ geom_point(aes(col=Genre))
ggplot(movies_df,aes(x=Rank,y=Rating))+ geom_point(aes(col=Genre))

movie_revenue = lm(log(Revenue) ~ Rating + Genre + Runtime, data =movies_df)
summary(movie_revenue)



##################################################
#################################################

<!DOCTYPE html>
  <html>
  <head>
  <style>
  h1 {
    color: black;
    font-family: times;
    font-size: 400%;
    
  }

h2 {
  color: navy;
  font-family: verdana;
  font-size: 200%;
  
}

p  {
  color: black;
  font-family: times;
  font-size: 100%;
}

p2  {
  color: gray;
  font-family: times;
  font-size: 70%;
}
</style>
  </head>
  <body>
  
  <h1>Le Monde</h1>
  
  <h2>Euro 2021 : Karim Benzema appelé en équipe de France </h2>
  
  <p>Le sélectionneur des Bleus a dévoilé les noms des 26 joueurs retenus pour le prochain championnat d'Europe de football. Alors qu'il n'était plus convoqué depuis 2015, Karim Benzema fait son grand retour en équipe de France. C'est le grand jour pour Didier Deschamps : le sélectionneur des Bleus a dévoilé sa liste de joueurs pour l'Euro (qui se tiendra du 11 juin au 11 juillet) lors d'une interview en direct, mardi 18 mai, sur TF1 et M6, les deux diffuseurs tricolores du tournoi.

Le « noyau dur », cher au sélectionneur des champions du monde et vice-champions d'Europe en titre, comprendra, autour du gardien et capitaine Hugo Lloris, les réguliers Benjamin Pavard, Raphaël Varane, Lucas Hernandez, N'Golo Kanté, Paul Pogba, Kylian Mbappé et Antoine Griezmann. </p>
  
  <p2> Le Monde avec AFP
Publié le 18 mai 2021 à 20h26, mis à jour hier à 01h07 </p2>
  
  </body>
  </html>