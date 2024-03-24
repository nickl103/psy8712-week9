# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(rvest)

# Data Import and Cleaning
urls <- c(Business = "https://www.cnbc.com/business/",
          Investing = "https://www.cnbc.com/investing/",
          Tech = "https://www.cnbc.com/technology/",
          Politics= "https://www.cnbc.com/politics/")
#savings urls and headers for later use in the loop 

#making an empty tibble to put into the loop later
cbnc_tbl <- tibble(headline= character(),
                     length= integer(),
                     source= character())
# Visualization

# Data Analysis

# Publication
