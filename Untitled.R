#install packages 
install.packages("sf")

# Load libraries
library(dplyr)
library(ggplot2)
library(sf)


# Load the datasets
us_jail_pop2 <- read.csv("Desktop/INFO201A/a4-incarceration-assignment-thitrang07/us-jail-pop.csv")
us_prison_jail_rates2 <- read.csv("Desktop/INFO201A/a4-incarceration-assignment-thitrang07/us-prison-jail-rates.csv")

# Calculate summary statistics
latest_year_jail <- max(us_jail_pop2$year, na.rm = TRUE)
latest_year_prison_rate <- max(us_prison_jail_rates2$year, na.rm = TRUE)

total_jail_pop_latest <- us_jail_pop2 %>% filter(year == latest_year_jail) %>% summarize(total_jail_pop = sum(total_jail_pop, na.rm = TRUE))
black_jail_pop_latest <- us_jail_pop2 %>% filter(year == latest_year_jail) %>% summarize(black_jail_pop = sum(black_jail_pop, na.rm = TRUE))
total_prison_pop_rate_latest <- us_prison_jail_rates2 %>% filter(year == latest_year_prison_rate) %>% summarize(total_prison_pop_rate = mean(total_prison_pop_rate, na.rm = TRUE))
latinx_prison_pop_rate_latest <- us_prison_jail_rates2 %>% filter(year == latest_year_prison_rate) %>% summarize(latinx_prison_pop_rate = mean(latinx_prison_pop_rate, na.rm = TRUE))

summary_stats <- data.frame(
  Variable = c("Total Jail Population", "Black Jail Population", "Total Prison Population Rate", "Latinx Prison Population Rate"),
  Value = c(total_jail_pop_latest$total_jail_pop, black_jail_pop_latest$black_jail_pop, total_prison_pop_rate_latest$total_prison_pop_rate, latinx_prison_pop_rate_latest$latinx_prison_pop_rate)
)

print(summary_stats)
 

# Aggregate data for trend over time
jail_pop_over_time <- us_jail_pop2 %>% group_by(year) %>% summarize(total_jail_pop = sum(total_jail_pop, na.rm = TRUE))

# Plot the trend over time
ggplot(jail_pop_over_time, aes(x = year, y = total_jail_pop)) +
  geom_line() +
  geom_point() +
  ggtitle("Total Jail Population Over Time") +
  xlab("Year") +
  ylab("Total Jail Population") +
  theme_minimal()


# Aggregate data for comparison
black_jail_pop_over_time <- us_jail_pop2 %>% group_by(year) %>% summarize(black_jail_pop = sum(black_jail_pop, na.rm = TRUE))
total_jail_pop_over_time <- us_jail_pop2 %>% group_by(year) %>% summarize(total_jail_pop = sum(total_jail_pop, na.rm = TRUE))

# Merge data for comparison
jail_pop_comparison <- merge(black_jail_pop_over_time, total_jail_pop_over_time, by = "year")

# Plot the comparison chart
ggplot(jail_pop_comparison, aes(x = year)) +
  geom_line(aes(y = black_jail_pop, color = "Black Jail Population")) +
  geom_line(aes(y = total_jail_pop, color = "Total Jail Population")) +
  geom_point(aes(y = black_jail_pop, color = "Black Jail Population")) +
  geom_point(aes(y = total_jail_pop, color = "Total Jail Population")) +
  ggtitle("Comparison of Black and Total Jail Population Over Time") +
  xlab("Year") +
  ylab("Jail Population") +
  scale_color_manual(values = c("Black Jail Population" = "blue", "Total Jail Population" = "red")) +
  theme_minimal()

# Load the shapefile 
counties <- st_read("~/Desktop/tl_2023_us_county/tl_2023_us_county.shp")

# Merge the shapefile with jail population rate data
counties <- merge(counties, us_prison_jail_rates2, by = "fips")

# Plot the map
ggplot(counties) +
  geom_sf(aes(fill = total_prison_pop_rate)) +
  scale_fill_viridis_c() +
  ggtitle("Total Prison Population Rate by County") +
  theme_minimal()


