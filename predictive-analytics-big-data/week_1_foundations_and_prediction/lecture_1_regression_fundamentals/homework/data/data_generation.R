# Generate retail_sales_messy.csv for Homework 1
set.seed(2024)
n <- 150

retail_sales <- tibble(
  store_id = 1:n,
  region = sample(c("North", "South", "East", "West"), n, replace = TRUE),
  advertising_spend = runif(n, 5, 50),
  store_size = runif(n, 3000, 15000),
  competitor_distance = rexp(n, rate = 0.2) + 1,  # Right-skewed
  staff_count = rpois(n, lambda = 15) + 5
) %>%
  mutate(
    # Non-linear relationship with store_size
    sales = 20 + 
      2.5 * advertising_spend + 
      0.015 * store_size - 0.000001 * store_size^2 +  # Quadratic
      3 * log(competitor_distance) +
      1.5 * staff_count +
      case_when(
        region == "North" ~ 10,
        region == "South" ~ 15,
        region == "East" ~ 5,
        region == "West" ~ 0
      ) +
      rnorm(n, 0, 8)
  ) %>%
  mutate(
    # Add heteroscedasticity (variance increases with sales)
    sales = sales + rnorm(n, 0, sales * 0.1)
  )

# Inject some outliers
outlier_indices <- sample(1:n, 5)
retail_sales$sales[outlier_indices] <- retail_sales$sales[outlier_indices] + rnorm(5, 50, 10)

# Round for realism
retail_sales <- retail_sales %>%
  mutate(across(where(is.numeric), ~round(., 2)))

# Save
write_csv(retail_sales, 
          "./predictive-analytics-big-data/week_1_foundations_and_prediction/lecture_1_regression_fundamentals/homework/data/retail_sales_messy.csv")