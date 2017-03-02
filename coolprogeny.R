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
    df <- data.frame(lapply(event_urls, event_info))
}

event_info <- function(url) {
    x <- read_html(url)
    details <- html_nodes(x, ".tribe-events-single-event-title, .dtstart,
                        .tribe-events-event-cost, .tribe-venue a,
                        .tribe-events-event-url a") %>%
        html_text() %>%
        gsub("^ *|\n|[$]|\t| *$", "", .)
    details
}


# scraping directly from "monthly 30 things to do articles" (lacks COST)
#events <- html_nodes(site, "em:nth-child(2) , em:nth-child(3), strong") %>%
#    html_text() # titles, dates, times, location
#temp <- events[c(FALSE, TRUE)] %>%
#    colsplit(" ?\\| ?" , c("date", "time", "location"))