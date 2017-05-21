# Extract statistical toolkits from UCBerkely, Earth & Planetary Science course
# by James Kirchner
# Public site = http://seismo.berkeley.edu/~kirchner/eps_120/EPSToolkits.htm

library(rvest)

site <- "http://seismo.berkeley.edu/~kirchner/eps_120/Toolkits/"
sel_gadget_code <- "td a"

# extract web addresses & download toolkits
toolkits_site <- read_html(site)
addresses <- html_nodes(toolkits_site, sel_gadget_code) %>%
    html_attr("href")
file_names <- addresses[-1]
addresses <- paste(site, addresses[-1], sep = "")

# file save location
folder <- "/Users/jbaron/Documents/DataScience/MyProjects/DSpublications/"
for (i in seq_along(file_names)) {
    download.file(addresses[i], destfile = paste(folder, file_names[i], sep = ""), method = "curl")
}