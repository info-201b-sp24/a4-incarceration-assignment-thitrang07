# Load libraries
library(dplyr)
library(ggplot2)

# Load the datasets
us_jail_pop2 <- read.csv("Desktop/INFO201A/a4-incarceration-assignment-thitrang07/us-jail-pop.csv")

# Aggregate data for trend over time
jail_pop_over_time <- us_jail_pop2 %>%
  group_by(year) %>%
  summarize(total_jail_pop = sum(total_jail_pop, na.rm = TRUE),
            black_jail_pop = sum(black_jail_pop, na.rm = TRUE))

# Plot the trend over time with the updated y-axis label
ggplot(jail_pop_over_time, aes(x = year)) +
  geom_line(aes(y = total_jail_pop, color = "Total Jail Population")) +
  geom_line(aes(y = black_jail_pop, color = "Black Jail Population")) +
  geom_point(aes(y = total_jail_pop, color = "Total Jail Population")) +
  geom_point(aes(y = black_jail_pop, color = "Black Jail Population")) +
  ggtitle("Total and Black Jail Population Over Time") +
  xlab("Year") +
  ylab("Number of Inmates") +  # Updated y-axis label
  scale_color_manual(values = c("Total Jail Population" = "red", "Black Jail Population" = "blue")) +
  theme_minimal() +
  labs(color = "Population Type")
