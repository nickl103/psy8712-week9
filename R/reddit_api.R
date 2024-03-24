# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(RedditExtractoR)

# Data Import and Cleaning
urls <- find_thread_urls(subreddit='rstats', period='month') #using find_thread_urls to get the specfic subreddit requested and to filter from the posts for at least a month's worth of posts. 
thread <- get_thread_content(urls$url) #using get_thread_urls to create dataframe of data and comments from URL

rstats_tbl <- tibble(post= thread$threads$title,
                     upvotes = thread$threads$upvotes,
                     comments= thread$threads$comments)
# Visualization
#made scatterplot because it's two continuous variables 
rstats_tbl %>% ggplot(aes(upvotes,comments)) +
  geom_point(color="lightpink") +
  labs(title= "Scatterplot of Upvotes and Comments")

# Analysis
rstats_cor <- cor.test(rstats_tbl$upvotes,rstats_tbl$comments)
#ran correlation test as suggested by instructions
cor <- str_remove(formatC(rstats_cor$estimate, format="f", digits=2), "^0")
cor
#called correlation estimate for later use in publication, using code from last week to remove leading zeros and only displaying two decimals. 
p.value <- str_remove(formatC(rstats_cor$p.value, format="f", digits=2), "^0")
p.value
#called p.value for later use in publication
df <-rstats_cor$parameter
#called df using parameter for later use in publication

# Publication
#The correlation between upvotes and comments was r(<df>) = <cor>, p = <p>. This test <was/was not> statistically 

#creating an ifelse test for was/was not if p.value is significant 
was <- ifelse(p.value < .05, "was","was not")

#creating the message using sprintf because it returns a character vector
text <- sprintf("The correlation between upvotes and comments was r(%d) = %s, p = %s. This test %s statistically significant.",df, cor, p.value, was)
cat(text)
#used the cat function to print the text out. 

