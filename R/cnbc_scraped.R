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

#savings urls and section headers for later use in the loop, couldn't figure out how to make the for loop work if urls and sections were together. 

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
  cnbc_tbl <- rbind(cnbc_tbl, tbl)  #combining tbls
}
# Visualization
#created a boxplot to show the length across each source
cnbc_tbl %>% ggplot(aes(source, length)) +
  geom_boxplot(fill="lightpink") +
  labs(title= "Boxplot of Length and Source")

# Data Analysis
aov <- aov(cnbc_tbl$length ~ cnbc_tbl$source) #running aov as suggested
aov_summary <- summary(aov) #creating summary table to later extract values for publication section


p.value <- str_remove(formatC(aov_summary[[1]]$Pr[1], format="f", digits=2), "^0") #extracting p.value from anova summary and formating it as required
F <- str_remove(formatC(aov_summary[[1]]$`F value`[1], format="f", digits=2), "^0") #extracting F from anova summary and formating it as 
dfn <- aov_summary[[1]]$Df[1] #extracting dfn from anova summary 
dfd <- aov_summary[[1]]$Df[2] #extracting dfd from anova summary
# Publication

#creating an ifelse test for was/was not if p.value is significant 
was <- ifelse(p.value < .05, "was","was not")

#creating the message using sprintf because it returns a character vector
text <- sprintf("The results of an ANOVA comparing lengths across sources F(%d,%d) = %s,p = %s. This test %s statistically significant.",dfn,dfd,F, p.value, was)
cat(text)
#used the cat function to print the text out. 