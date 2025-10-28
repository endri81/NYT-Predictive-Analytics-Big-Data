# Generate housing_prices.csv for Classwork 4
set.seed(2025)
n <- 300

housing_prices <- tibble(
  sqft = rnorm(n, 2000, 500),
  bedrooms = sample(2:5, n, replace = TRUE, prob = c(0.2, 0.4, 0.3, 0.1)),
  bathrooms = sample(1:4, n, replace = TRUE, prob = c(0.1, 0.5, 0.3, 0.1)),
  age = rpois(n, lambda = 20) + 1,
  lot_size = rgamma(n, shape = 3, scale = 0.15),
  garage_spaces = sample(0:3, n, replace = TRUE, prob = c(0.1, 0.3, 0.4, 0.2)),
  distance_downtown = rexp(n, rate = 0.15) + 1,
  school_rating = sample(1:10, n, replace = TRUE, 
                         prob = c(0.05, 0.05, 0.1, 0.1, 0.15, 0.2, 0.15, 0.1, 0.05, 0.05))
) %>%
  mutate(
    # True relationship (strong effects from sqft, bathrooms, school; moderate from others)
    price = 50 + 
      0.15 * sqft +                    # Strong effect
      8 * bedrooms +                   # Moderate effect  
      25 * bathrooms +                 # Strong effect
      -2 * age +                       # Moderate negative effect
      20 * lot_size +                  # Moderate effect
      15 * garage_spaces +             # Small effect
      -3 * distance_downtown +         # Small effect
      12 * school_rating +             # Large effect
      rnorm(n, 0, 30),                 # Substantial noise
    price = pmax(price, 50),           # Floor at $50K
    across(where(is.numeric), ~round(., 2))
  )

write_csv(housing_prices,
          "./predictive-analytics-big-data/week_1_foundations_and_prediction/lecture_1_regression_fundamentals/classwork_4/data/housing_prices.csv")