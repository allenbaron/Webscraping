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
start_site <- read_html(url)
event_urls <- html_nodes(site, ".post-content a") %>%
    html_attr("href")

mult_events <- function(event_urls) {
    # urls (as character vector)
    do.call(rbind, lapply(event_urls, event_info)))
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

    info <- c(title, datetime, cost, venue, event_url) %>%
        gsub("^ *|\n|[$]|\t| *$", "", .)
    
    data.frame(title = info[1], date = info[2], time = info[3],
                     cost = as.numeric(info[4]), venu = info[5], url = info[6],
                     stringsAsFactors = FALSE)
}

# scraping directly from "monthly 30 things to do articles" (lacks COST)
#events <- html_nodes(site, "em:nth-child(2) , em:nth-child(3), strong") %>%
#    html_text() # titles, dates, times, location
#temp <- events[c(FALSE, TRUE)] %>%
#    colsplit(" ?\\| ?" , c("date", "time", "location"))