# Install packages
install.packages("tmap")
install.packages("terra")
install.packages("remotes")
remotes::install_github('r-tmap/tm1ap')
install.packages("viridis")
install.packages("viridisLite")
install.packages("sf")
install.packages("ggplot")

# Load packages
library(tmap)
library(sf)
library(dplyr)
library(ggplot2)
library(ggplot)
library(viridisLite)
library(viridis)

# Load the shapefile
shapefile_path <- "~/Desktop/tl_2023_us_county"
counties <- st_read(shapefile_path)


# Load the dataset
data_path <- "Desktop/INFO201A/a4-incarceration-assignment-thitrang07/us-prison-jail-rates.csv"
us_prison_jail_rates2 <- read.csv(data_path)

# Ensure the fips code matches the GEOID format
us_prison_jail_rates2$fips <- sprintf("%05d", us_prison_jail_rates2$fips)

# Merge the shapefile with jail population rate data
counties <- merge(counties, us_prison_jail_rates2, by.x = "GEOID", by.y = "fips", all.x = TRUE)

ggplot(counties) +
  geom_sf(aes(fill = total_jail_pop_rate)) +
  scale_fill_viridis_c() +
  ggtitle("Total Jail Population Rate by County") +
  theme_minimal() +
  labs(fill = "Jail Population Rate") +
  coord_sf()
