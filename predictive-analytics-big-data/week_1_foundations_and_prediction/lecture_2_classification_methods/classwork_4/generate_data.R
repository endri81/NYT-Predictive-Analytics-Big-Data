# Generate synthetic product pricing dataset for Classwork 4
# This creates realistic e-commerce pricing data with 47 features

set.seed(42)
n <- 800

# Generate features with realistic correlations and structures
product_data <- data.frame(
  
  # Physical attributes (correlated group 1)
  weight = rnorm(n, 500, 200),
  length = rnorm(n, 30, 10),
  width = rnorm(n, 20, 8),
  height = rnorm(n, 15, 6),
  volume = NA,  # will calculate
  
  # Material properties (correlated group 2)
  material_plastic = rbinom(n, 1, 0.3),
  material_metal = rbinom(n, 1, 0.25),
  material_wood = rbinom(n, 1, 0.15),
  material_fabric = rbinom(n, 1, 0.2),
  material_glass = rbinom(n, 1, 0.1),
  
  # Category indicators (one-hot encoded)
  category_electronics = rbinom(n, 1, 0.2),
  category_furniture = rbinom(n, 1, 0.15),
  category_kitchen = rbinom(n, 1, 0.2),
  category_sports = rbinom(n, 1, 0.15),
  category_toys = rbinom(n, 1, 0.1),
  category_home = rbinom(n, 1, 0.2),
  
  # Brand strength
  brand_premium = rbinom(n, 1, 0.2),
  brand_midrange = rbinom(n, 1, 0.5),
  brand_budget = rbinom(n, 1, 0.3),
  
  # Product age and lifecycle
  product_age_months = rpois(n, 12),
  is_new_release = rbinom(n, 1, 0.15),
  is_discontinued = rbinom(n, 1, 0.05),
  
  # Market conditions
  competitor_avg_price = rnorm(n, 100, 40),
  market_demand_index = rnorm(n, 100, 20),
  seasonal_factor = rnorm(n, 1, 0.15),
  
  # Quality indicators
  warranty_months = sample(c(0, 6, 12, 24, 36), n, replace = TRUE),
  customer_rating = runif(n, 2.5, 5),
  num_reviews = rpois(n, 50),
  return_rate = runif(n, 0.01, 0.15),
  
  # Shipping and logistics
  free_shipping = rbinom(n, 1, 0.4),
  shipping_weight_kg = NA,  # will calculate
  fulfillment_days = sample(1:10, n, replace = TRUE),
  
  # Inventory
  stock_quantity = rpois(n, 100),
  restock_frequency_days = sample(c(7, 14, 30, 60, 90), n, replace = TRUE),
  
  # Marketing
  featured_product = rbinom(n, 1, 0.1),
  sale_active = rbinom(n, 1, 0.2),
  discount_percentage = runif(n, 0, 0.3),
  
  # Complexity indicators
  num_components = rpois(n, 5) + 1,
  assembly_required = rbinom(n, 1, 0.3),
  num_accessories = rpois(n, 2),
  
  # Noise features (irrelevant)
  noise_1 = rnorm(n),
  noise_2 = rnorm(n),
  noise_3 = rnorm(n),
  noise_4 = rnorm(n),
  noise_5 = rnorm(n)
)

# Calculate derived features
product_data$volume <- product_data$length * product_data$width * product_data$height
product_data$shipping_weight_kg <- product_data$weight / 1000

# Generate target variable (price) with realistic relationships
product_data$price <- with(product_data, 
  50 +  # baseline
  
  # Strong predictors
  0.15 * weight +
  2.5 * volume / 1000 +
  45 * brand_premium +
  20 * brand_midrange -
  15 * brand_budget +
  
  # Category effects
  80 * category_electronics +
  120 * category_furniture +
  30 * category_kitchen +
  40 * category_sports +
  25 * category_toys +
  35 * category_home +
  
  # Market factors
  0.5 * competitor_avg_price +
  0.3 * market_demand_index +
  20 * seasonal_factor +
  
  # Quality signals
  2 * warranty_months +
  15 * customer_rating -
  100 * return_rate +
  
  # Material effects
  25 * material_metal +
  15 * material_wood -
  10 * material_plastic +
  
  # Logistics
  -5 * fulfillment_days +
  10 * free_shipping +
  
  # Age effects
  -0.5 * product_age_months +
  20 * is_new_release -
  30 * is_discontinued +
  
  # Complexity
  5 * num_components +
  -10 * assembly_required +
  
  # Marketing
  30 * featured_product -
  40 * discount_percentage +
  
  # Random noise
  rnorm(n, 0, 15)
)

# Ensure reasonable price range
product_data$price <- pmax(10, product_data$price)
product_data$price <- round(product_data$price, 2)

# Verify structure
cat("Dataset dimensions:", dim(product_data), "\n")
cat("Number of features:", ncol(product_data) - 1, "\n")
cat("Price range: $", round(min(product_data$price), 2), " to $", 
    round(max(product_data$price), 2), "\n")
cat("Mean price: $", round(mean(product_data$price), 2), "\n")

# Save dataset
write.csv(product_data, "product_pricing.csv", row.names = FALSE)
cat("\nDataset saved as 'product_pricing.csv'\n")

# Create data dictionary
data_dictionary <- data.frame(
  Variable = names(product_data),
  Type = c(
    rep("Physical", 5),
    rep("Material", 5),
    rep("Category", 6),
    rep("Brand", 3),
    rep("Lifecycle", 3),
    rep("Market", 3),
    rep("Quality", 4),
    rep("Logistics", 3),
    rep("Inventory", 2),
    rep("Marketing", 3),
    rep("Complexity", 3),
    rep("Noise", 5),
    "Target"
  ),
  Description = c(
    "Product weight in grams",
    "Product length in cm",
    "Product width in cm",
    "Product height in cm",
    "Calculated volume in cm³",
    "Binary: plastic material",
    "Binary: metal material",
    "Binary: wood material",
    "Binary: fabric material",
    "Binary: glass material",
    "Binary: electronics category",
    "Binary: furniture category",
    "Binary: kitchen category",
    "Binary: sports category",
    "Binary: toys category",
    "Binary: home goods category",
    "Binary: premium brand tier",
    "Binary: mid-range brand tier",
    "Binary: budget brand tier",
    "Months since product launch",
    "Binary: released in last 3 months",
    "Binary: discontinued product",
    "Average competitor pricing ($)",
    "Market demand index (0-150)",
    "Seasonal adjustment factor",
    "Warranty period in months",
    "Average customer rating (1-5)",
    "Number of customer reviews",
    "Product return rate (0-1)",
    "Binary: free shipping eligible",
    "Shipping weight in kg",
    "Fulfillment time in days",
    "Current stock quantity",
    "Restock frequency in days",
    "Binary: featured on homepage",
    "Binary: currently on sale",
    "Discount percentage (0-1)",
    "Number of product components",
    "Binary: requires assembly",
    "Number of included accessories",
    "Random noise variable 1",
    "Random noise variable 2",
    "Random noise variable 3",
    "Random noise variable 4",
    "Random noise variable 5",
    "Product price in dollars (TARGET)"
  )
)

write.csv(data_dictionary, "./predictive-analytics-big-data/week_1_foundations_and_prediction/lecture_1_regression_fundamentals/classwork_4/data/data_dictionary.csv", row.names = FALSE)
cat("Data dictionary saved as 'data_dictionary.csv'\n")
