# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(rvest)

# Data Import and Cleaning
sections <- c(Business="https://www.cnbc.com/business/",
          Investing="https://www.cnbc.com/investing/",
          Tech= "https://www.cnbc.com/technology/",
         Politics= "https://www.cnbc.com/politics/")


#savings urls and section headers for later use in the loop 

#making an empty tibble to put into the loop later
cbnc_tbl <- tibble(headline= character(),
                     length= integer(),
                     source= character())
for(i in 1: length(sections)){
  url <- sections[i]
  pages <- read_html(url) #reading in html pages
  elements <- html_elements(pages,".Card-title") #extracting elements
  text <- html_text(elements) #converting elements to text
  length <- str_count(text, "\\S+") # counting number of words for string
  source <- sections[i]
  tbl <- tibble(headline= elements,
                legnth= length,
                source= source)
  cnbc_tbl <- rbind(cnbc_tbl, tbl)
}
# Visualization

# Data Analysis

# Publication
