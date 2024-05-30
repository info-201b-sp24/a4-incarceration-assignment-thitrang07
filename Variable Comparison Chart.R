# Aggregate data for comparison
black_white_jail_pop_over_time <- us_jail_pop2 %>%
  group_by(year) %>%
  summarize(black_jail_pop = sum(black_jail_pop, na.rm = TRUE),
            white_jail_pop = sum(white_jail_pop, na.rm = TRUE))

# Plot the comparison chart
ggplot(black_white_jail_pop_over_time, aes(x = year)) +
  geom_line(aes(y = black_jail_pop, color = "Black Jail Population")) +
  geom_line(aes(y = white_jail_pop, color = "White Jail Population")) +
  geom_point(aes(y = black_jail_pop, color = "Black Jail Population")) +
  geom_point(aes(y = white_jail_pop, color = "White Jail Population")) +
  ggtitle("Comparison of Black and White Jail Population Over Time") +
  xlab("Year") +
  ylab("Jail Population") +
  scale_color_manual(values = c("Black Jail Population" = "blue", "White Jail Population" = "green")) +
  theme_minimal() +
  labs(color = "Population Type")
