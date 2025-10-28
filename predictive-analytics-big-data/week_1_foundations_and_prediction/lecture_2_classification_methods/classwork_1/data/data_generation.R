# Generate Product Features Extended Dataset
# For Classwork 2A: Diagnosing Overfitting
# Run this once to create product_features_extended.csv

set.seed(123)
library(MASS)

# Parameters
n <- 400  # Number of products
p <- 75   # Number of features

# Create realistic feature names
feature_names <- c(
  # Historical Sales (15)
  paste0("sales_", c("7d", "14d", "30d", "60d", "90d", "180d", "365d",
                     "trend_7d", "trend_30d", "volatility_7d", "volatility_30d",
                     "growth_rate_30d", "growth_rate_90d", "peak_sales_30d", 
                     "min_sales_30d")),
  
  # Competitor Pricing (10)
  paste0("competitor_price_", 1:10),
  
  # Inventory Metrics (10)
  paste0("inventory_", c("level", "days_in_stock", "reorder_point", "safety_stock",
                         "turnover_rate", "stockout_count", "lead_time",
                         "supplier_reliability", "warehouse_location", "handling_cost")),
  
  # Customer Metrics (15)
  paste0("customer_", c("rating_avg", "rating_count", "review_count", 
                        "return_rate", "repeat_purchase_rate", "cart_abandon_rate",
                        "wishlist_count", "click_through_rate", "conversion_rate",
                        "avg_order_value", "lifetime_value", "acquisition_cost",
                        "satisfaction_score", "nps_score", "complaint_count")),
  
  # Product Attributes (10)
  paste0("product_", c("age_days", "category_rank", "brand_strength", 
                       "quality_score", "uniqueness_score", "weight",
                       "size_index", "complexity", "warranty_length", "certification")),
  
  # Seasonality (5)
  paste0("season_", c("index", "trend", "holiday_proximity", "weather_impact", "event_impact")),
  
  # Marketing (10)
  paste0("marketing_", c("ad_spend_7d", "ad_spend_30d", "email_open_rate", 
                         "email_click_rate", "social_engagement", "influencer_mentions",
                         "search_volume", "brand_searches", "promotion_active", 
                         "discount_depth"))
)

# Create correlation structure to simulate real business data
# Features within same category are correlated
correlation_structure <- matrix(0.2, p, p)  # Baseline correlation
diag(correlation_structure) <- 1

# Make features within categories highly correlated
# Historical Sales (highly correlated)
correlation_structure[1:15, 1:15] <- 0.75
diag(correlation_structure[1:15, 1:15]) <- 1

# Competitor Pricing (moderately correlated)
correlation_structure[16:25, 16:25] <- 0.65
diag(correlation_structure[16:25, 16:25]) <- 1

# Inventory Metrics (somewhat correlated)
correlation_structure[26:35, 26:35] <- 0.55
diag(correlation_structure[26:35, 26:35]) <- 1

# Customer Metrics (highly correlated)
correlation_structure[36:50, 36:50] <- 0.70
diag(correlation_structure[36:50, 36:50]) <- 1

# Create some very high correlations (multicollinearity issues)
correlation_structure[1, 2] <- correlation_structure[2, 1] <- 0.92  # sales_7d & sales_14d
correlation_structure[3, 4] <- correlation_structure[4, 3] <- 0.90  # sales_30d & sales_60d
correlation_structure[16, 17] <- correlation_structure[17, 16] <- 0.88  # competitor prices
correlation_structure[36, 37] <- correlation_structure[37, 36] <- 0.91  # ratings

# Generate features from multivariate normal
X <- mvrnorm(n, mu = rep(0, p), Sigma = correlation_structure)
colnames(X) <- feature_names

# Define true model: only 12 features actually matter (sparse ground truth)
true_coefficients <- rep(0, p)
true_features <- c(1, 3, 8, 16, 18, 26, 30, 36, 38, 51, 53, 66)
true_coefficients[true_features] <- c(2.5, 1.8, -1.2, 3.1, 1.5, -0.8, 
                                      2.2, 1.1, -1.5, 1.9, -1.1, 1.3)

# Generate optimal price
intercept <- 45
noise <- rnorm(n, 0, 4)
optimal_price <- intercept + X %*% true_coefficients + noise

# Ensure positive prices
optimal_price <- pmax(optimal_price, 5)

# Create final dataframe
pricing_data <- as.data.frame(cbind(optimal_price, X))

# Add some missing values (realistic scenario) - 2% missing
n_missing <- round(0.02 * n * p)
missing_indices <- sample(1:(n * p), n_missing)
pricing_matrix <- as.matrix(pricing_data[, -1])
pricing_matrix[missing_indices] <- NA
pricing_data[, -1] <- pricing_matrix

# Write to CSV
write.csv(pricing_data, "product_features_extended.csv", row.names = FALSE)

# Create data dictionary
data_dict <- data.frame(
  Variable = c("optimal_price", feature_names),
  Category = c("Target", 
               rep("Historical Sales", 15),
               rep("Competitor Pricing", 10),
               rep("Inventory Metrics", 10),
               rep("Customer Metrics", 15),
               rep("Product Attributes", 10),
               rep("Seasonality", 5),
               rep("Marketing", 10)),
  Description = c(
    "Optimal price for the product ($K) - maximizes profit",
    rep("Various sales metrics over different time periods", 15),
    rep("Prices from different competitors", 10),
    rep("Inventory and supply chain metrics", 10),
    rep("Customer behavior and satisfaction metrics", 15),
    rep("Product characteristics and attributes", 10),
    rep("Seasonal and temporal factors", 5),
    rep("Marketing spend and engagement metrics", 10)
  ),
  True_Coefficient = c(NA, true_coefficients)
)

write.csv(data_dict, "./predictive-analytics-big-data/week_1_foundations_and_prediction/lecture_2_classification_methods/classwork_1/data/data_dictionary.csv", row.names = FALSE)

cat("Data generation complete!\n")
cat("Created:\n")
cat("  - product_features_extended.csv (", n, " observations, ", p+1, " variables)\n")
cat("  - data_dictionary.csv\n")
cat("True non-zero coefficients:", sum(true_coefficients != 0), "\n")
cat("Missing values: ~2%\n")