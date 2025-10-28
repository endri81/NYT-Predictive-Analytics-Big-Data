# Generate store_performance.csv for Classwork 3
set.seed(2025)
n <- 200

store_performance <- tibble(
  store_id = 1:n,
  foot_traffic = rnorm(n, 500, 100),
  employee_training_hours = rnorm(n, 40, 15),
  local_income = rnorm(n, 70, 20),
  store_age = rpois(n, lambda = 8) + 1,
  parking_spaces = sample(20:100, n, replace = TRUE)
) %>%
  mutate(
    # True relationship with varying effect sizes
    profit = 50 + 
      0.15 * foot_traffic +           # Large effect (β* ≈ 0.60)
      0.8 * employee_training_hours + # Medium effect (β* ≈ 0.35)
      0.3 * local_income +             # Medium effect (β* ≈ 0.30)
      -1.2 * store_age +               # Small effect (β* ≈ -0.20)
      0.05 * parking_spaces +          # Very small but sig (β* ≈ 0.08)
      rnorm(n, 0, 12),
    across(where(is.numeric), ~round(., 2))
  ) %>%
  select(-store_id)

write_csv(store_performance,
          "./predictive-analytics-big-data/week_1_foundations_and_prediction/lecture_1_regression_fundamentals/classwork_3_advanced_interpretation/data/store_performance.csv")