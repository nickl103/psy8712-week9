# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(rvest)

# Data Import and Cleaning
urls <- c("https://www.cnbc.com/business/",
          "https://www.cnbc.com/investing/",
          "https://www.cnbc.com/technology/",
          "https://www.cnbc.com/politics/")
sections <- c("Business","Investing","Tech","Politics")

#savings urls and section headers for later use in the loop 

#making an empty tibble to put into the loop later because when I tried to do it in the loop it wouldn't work properly and was only giving me like 30 observations????
cnbc_tbl <- tibble(headline= character(),
                     length= integer(),
                     source= character())

for(u in 1:length(sections)) { #creating for loop for the four sections
  page <- read_html(urls[u]) #reading in urls
  headline_nodes <- page %>% #reading in the headlines
    html_nodes(".Card-title") %>%
    html_text(trim = TRUE) #converting to text, I tried to combine this with previous line with only one command but it wouldn't convert it properly to text
  length <- str_count(headline_nodes, "\\S+") #counting words in each string
  source <- sections[u] #creating a column for which section was source of urls
  tbl <- tibble(headline = headline_nodes, 
                  length = length,
                  source = source) ##creating a tibble to combine with the other tibble
  cnbc_tbl <- rbind(cnbc_tbl, tbl) 
}
# Visualization

# Data Analysis

# Publication
