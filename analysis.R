# Load your dataset
data <- read.csv("nj_beach_water_quality_2021_2026.csv")

# Look at the data
head(data)

# Convert date column
data$Result_Date <- as.Date(data$Result_Date)

# Basic summary of bacteria levels
summary(data$Result_Measure)

# Plot bacteria levels over time
plot(data$Result_Date, data$Result_Measure,
     main="Enterococcus Levels Over Time",
     xlab="Date", ylab="Bacteria Level")