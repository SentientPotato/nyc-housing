## Attach required packages
library(dplyr)
library(readr)
library(ggplot2)

## Read in housing data, pulled from nyc.gov on June 24, 2024
## https://www.nyc.gov/assets/planning/download/pdf/data-maps/nyc-population/historical-population/nyc_total_hu_1940-2010.pdf
## https://www.nyc.gov/assets/planning/download/pdf/planning-level/nyc-population/historical-population/nyc_total_pop_1900-2010.pdf
## https://popfactfinder.planning.nyc.gov/explorer/cities/NYC?compareTo=1&source=decennial-change
dat = read_csv("nyc-housing-info.csv")

## Calculate the ratio
dat = dat %>% mutate(houses_per_person = houses / population)

## Plot the results
ttl = "Houses per person in NYC over time"
cph = "Plot by Sentient Potato (Twitter: @SentientPotato6)"
gh  = "Replication material at https://github.com/SentientPotato/nyc-housing"
cap = paste(cph, gh, sep = "\n")
plt = ggplot(data = dat, mapping = aes(x = year, y = houses_per_person)) +
    geom_line(linewidth = 1) +
    labs(title = ttl, caption = cap) +
    theme_bw() +
    theme(
        axis.title = element_blank(),
        plot.caption = element_text(size = 6, color = "#5f5f5f", hjust = 0)
    )
ggsave(
    plot = plt,
    filename = "nyc-housing.png",
    height = 675 / 300,
    width = 1200 / 300
)
