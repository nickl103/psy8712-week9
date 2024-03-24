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
  
