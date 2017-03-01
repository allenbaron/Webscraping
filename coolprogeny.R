# Webscraping to summarize children's activities from cool progeny

library(rvest)
library(magrittr)

# for more general search of website (e.g. "monthly 30 things to do articles")
#site <- "http://coolprogeny.com/out-about/"
#out_about <- read_html(site)
#current_articles <- html_nodes(out_about, ".wp-post-image") %>%
#    html_attr("src")

# scrape activities and details for March
address <- "http://coolprogeny.com/2017/02/30-things-to-do-with-kids-in-baltimore-this-march/"
site <- read_html(address)
events <- html_nodes(site, "em:nth-child(2) , em:nth-child(3), strong") %>%
    html_text() # titles, dates, times, location
n <- length(events)
events_df <- data.frame(event = events[c(TRUE, FALSE)], temp = events[c(FALSE, TRUE)])
event_sites <- html_nodes(site, ".post-content a") %>%
    html_attr("href")

x <- 
".tribe-events-event-cost"