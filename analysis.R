# Load your dataset
beach_data <- read.csv("nj_beach_water_quality_2021_2026.csv")

# Look at the data
head(beach_data)

# Convert date column
beach_data$Result_Date <- as.Date(beach_data$Result_Date)

# Basic summary of bacteria levels
summary(beach_data$Result_Measure)

# Plot bacteria levels over time
plot(beach_data$Result_Date, beach_data$Result_Measure,
     main="Enterococcus Levels Over Time",
     xlab="Date", ylab="Bacteria Level")

beach_data$Result_Date <- as.Date(beach_data$Result_Date, format="%m/%d/%Y")
class(beach_data$Result_Date)

plot(beach_data$Result_Date, beach_data$Result_Measure,
     main="Enterococcus Levels Over Time",
     xlab="Date", ylab="Bacteria Level",
     pch=16, cex=0.5)
names(beach_data)

unsafe_samples <- beach_data$Result_Measure > 104

sum(unsafe_samples)

# Create logical vector (TRUE/FALSE)
unsafe_samples <- beach_data$Result_Measure > 104

# Count unsafe samples
sum(unsafe_samples)

# Total samples
total_samples <- nrow(beach_data)

# Percentage unsafe
percent_unsafe <- sum(unsafe_samples) / total_samples * 100

percent_unsafe

summary(beach_data$Result_Measure)
head(beach_data[beach_data$Result_Measure > 104, ])

beach_data$Result_Measure <- as.numeric(beach_data$Result_Measure)
sum(is.na(beach_data$Result_Measure))
clean_data <- beach_data[!is.na(beach_data$Result_Measure), ]

unsafe_samples <- clean_data$Result_Measure > 104

sum(unsafe_samples)

total_samples <- nrow(clean_data)

percent_unsafe <- sum(unsafe_samples) / total_samples * 100

percent_unsafe




clean_data$Year <- format(clean_data$Result_Date, "%Y")

aggregate(Result_Measure ~ Year, data=clean_data, mean)


install.packages("dplyr")
library(dplyr)

clean_data %>%
  group_by(Year) %>%
  summarise(
    total = n(),
    unsafe = sum(Result_Measure > 104),
    percent_unsafe = unsafe / total * 100
  )



install.packages("ggplot2")
library(ggplot2)

year_summary <- clean_data %>%
  group_by(Year) %>%
  summarise(
    percent_unsafe = sum(Result_Measure > 104) / n() * 100
  )

ggplot(year_summary, aes(x=Year, y=percent_unsafe)) +
  geom_line(group=1) +
  geom_point(size=3) +
  labs(
    title="Percentage of Unsafe Enterococcus Levels by Year",
    x="Year",
    y="Percent Unsafe (%)"
  )




ggplot(year_summary, aes(x=Year, y=percent_unsafe)) +
  geom_line(group=1, linewidth=1) +
  geom_point(size=3) +
  labs(
    title="Percentage of Unsafe Enterococcus Levels by Year (2021–2025)",
    x="Year",
    y="Percent of Samples Exceeding 104 CFU/100mL"
  ) +
  theme_minimal()

ggsave("percent_unsafe_by_year.png", width=8, height=5)
