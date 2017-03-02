# Webscraping to summarize children's activities from cool progeny

library(rvest)
library(magrittr)
library(reshape2)

# for more general search of website (e.g. "monthly 30 things to do articles")
#site <- "http://coolprogeny.com/out-about/"
#out_about <- read_html(site)
#current_articles <- html_nodes(out_about, ".wp-post-image") %>%
#    html_attr("src")

# scrape activities and details for March
url <- "http://coolprogeny.com/2017/02/30-things-to-do-with-kids-in-baltimore-this-march/"

mult_events <- function(url) {
    start_site <- read_html(url)
    event_urls <- html_nodes(start_site, ".post-content a") %>%
        html_attr("href")
    do.call(rbind, lapply(event_urls, event_info))
}

event_info <- function(url) {
    x <- read_html(url)
    title <- html_nodes(x,".tribe-events-single-event-title") %>% html_text()
    datetime <- html_nodes(x, ".dtstart") %>% html_text()
        if(length(datetime) < 2) datetime <- c(datetime, NA)
    cost <- html_nodes(x, ".tribe-events-event-cost") %>% html_text() %>%
        ifelse(is.null(.), NA, .)
    venue <- html_nodes(x, ".tribe-venue a") %>% html_text() %>%
        ifelse(is.null(.), NA, .)
    event_url <- html_nodes(x, ".tribe-events-event-url a") %>% html_text() %>%
        ifelse(is.null(.), NA, .)

    details <- c(title, datetime, cost, venue, event_url) %>%
        gsub("^ *|\n|[$]|\t| *$", "", .)
    
    details <- data.frame(matrix(details, 1, 6), stringsAsFactors = FALSE)
    names(details) <- c("title", "date", "time", "cost", "venue", "url")
    details
}

# scraping directly from "monthly 30 things to do articles" (lacks COST)
#events <- html_nodes(site, "em:nth-child(2) , em:nth-child(3), strong") %>%
#    html_text() # titles, dates, times, location
#temp <- events[c(FALSE, TRUE)] %>%
#    colsplit(" ?\\| ?" , c("date", "time", "location"))