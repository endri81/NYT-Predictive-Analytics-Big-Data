################################################################################
# Generate facebook_marketing.csv for Classwork 1
# Location: lecture_1_regression_fundamentals/classwork_1_gradient_descent/data/
################################################################################
library(tidyverse)
set.seed(123)
n <- 100

facebook_data <- tibble(
  week = 1:n,
  facebook_spend = runif(n, 5, 40)
) %>%
  mutate(
    # True relationship: sales = 60 + 1.8*facebook_spend + noise
    sales = 60 + 1.8 * facebook_spend + rnorm(n, 0, 12),
    # Round for realism
    facebook_spend = round(facebook_spend, 1),
    sales = round(sales, 1)
  )

# Save to data folder
write_csv(facebook_data, 
          "./predictive-analytics-big-data/week_1_foundations_and_prediction/lecture_1_regression_fundamentals/classwork_1/data/facebook_marketing.csv")

cat("✓ Generated facebook_marketing.csv for Classwork 1\n")