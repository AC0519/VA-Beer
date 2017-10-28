#Top 100 VA beers data scrape

# Load required libraries
library(rvest)
library(magrittr)

#Set URL
url <- "https://www.beeradvocate.com/lists/state/va/"
  
  #Scrape data
  Rank <- url %>%
  read_html() %>%
  html_nodes(".hr_bottom_light:nth-child(3) b") %>%
  html_text() %>%
  as.numeric()

Ratings <- url %>%
  read_html() %>%
  html_nodes(".hr_bottom_light:nth-child(4) b") %>%
  html_text() %>%
  as.numeric()

Beer <- url %>%
  read_html() %>%
  html_nodes(".hr_bottom_light a b") %>%
  html_text() %>%
  as.factor()

Brewery <- url %>%
  read_html() %>%
  html_nodes("#extendedInfo a:nth-child(1)") %>%
  html_text() %>%
  as.factor()

Style <- url %>%
  read_html() %>%
  html_nodes("#extendedInfo br+ a") %>%
  html_text() %>%
  as.factor()

ABV <- url %>%
  read_html() %>%
  html_nodes("#extendedInfo") %>%
  html_text() %>%
  gsub(".*/","",.) %>%
  gsub("%.*","",.) %>%
  as.numeric()

#Turn scraped info into data frame
Breweries.df <- data.frame(Beer, Style, ABV, Rank, Ratings, Brewery)

#Merge address spreadsheet with Breweries.df
Breweries <- merge(Breweries.df, Brewery_address_and_geocoords, by = "Brewery")
