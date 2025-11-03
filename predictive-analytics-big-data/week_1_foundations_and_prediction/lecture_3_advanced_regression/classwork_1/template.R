# ============================================================
# CLASSWORK 1: Diagnosing Overfitting
# Lecture 3: Advanced Regression & Regularization
# Time: 25-30 minutes
# ============================================================

# LEARNING OBJECTIVE:
# You will diagnose overfitting and multicollinearity in a housing price 
# prediction model to recommend whether regularization is needed.

# BUSINESS CONTEXT:
# HomeLend Financial needs to know if their house price prediction model
# is reliable enough for automated loan valuations. The model works well
# on development data but overvalues properties in new markets by 15%.

# DATA:
# 750 houses with 16 predictors including size, location, and condition

# ============================================================
# SETUP
# ============================================================

# Load required packages
library(tidyverse)
library(car)        # For VIF calculation
library(caret)      # For train/test split

# Set seed for reproducibility
set.seed(123)

# ============================================================
# EXERCISE 1: Load and Explore Data (2 minutes)
# ============================================================

# GOAL: Understand the dataset structure and business problem
# 
# INSTRUCTION: Load the housing data and calculate basic statistics
# HINT: Use read_csv() and summary()

# Load the data
housing_data <- read_csv("data/housing_prices.csv")

# Explore structure
glimpse(housing_data)

# Calculate summary statistics
summary(housing_data)

# How many houses in the dataset?
n_houses <- ___  # YOUR CODE HERE

# What's the average sale price?
avg_price <- ___  # YOUR CODE HERE

# What's the range of prices?
price_range <- ___  # YOUR CODE HERE

cat("Dataset:", n_houses, "houses\n")
cat("Average price: $", format(avg_price, big.mark = ","), "\n", sep = "")
cat("Price range: $", format(min(price_range), big.mark = ","), 
    " to $", format(max(price_range), big.mark = ","), "\n", sep = "")


# ============================================================
# EXERCISE 2: Create Train/Test Split (2 minutes)
# ============================================================

# GOAL: Split data to simulate production deployment
#
# INSTRUCTION: Create 80/20 train/test split
# HINT: Use createDataPartition() with p = 0.8

# Create train/test split
train_indices <- createDataPartition(
  ___, # YOUR CODE: What variable should we stratify on?
  p = ___,  # YOUR CODE: What proportion for training?
  list = FALSE
)

train_data <- ___  # YOUR CODE: Subset training data
test_data <- ___   # YOUR CODE: Subset test data

cat("Training set:", nrow(train_data), "houses\n")
cat("Test set:", nrow(test_data), "houses\n")


# ============================================================
# EXERCISE 3: Fit Full Model (2 minutes)
# ============================================================

# GOAL: Build multiple regression with all predictors
#
# INSTRUCTION: Fit lm() model predicting sale_price from all features
# HINT: Use sale_price ~ . to include all predictors

# Fit multiple regression model
model_full <- lm(
  ___, # YOUR CODE: Formula for the model
  data = ___  # YOUR CODE: Which dataset?
)

# View model summary
summary(model_full)

# How many predictors in the model?
n_predictors <- length(coef(model_full)) - 1  # -1 for intercept
cat("Number of predictors:", n_predictors, "\n")


# ============================================================
# EXERCISE 4: Calculate Training Performance (2 minutes)
# ============================================================

# GOAL: Measure how well the model fits training data
#
# INSTRUCTION: Calculate RMSE and R² on training data
# HINT: RMSE = sqrt(mean((actual - predicted)^2))

# Generate training predictions
train_predictions <- ___  # YOUR CODE: Use predict()

# Calculate training RMSE
train_rmse <- ___  # YOUR CODE: Calculate RMSE

# Calculate training R²
train_r2 <- ___  # YOUR CODE: Extract R² from summary

cat("Training RMSE: $", format(round(train_rmse), big.mark = ","), "\n", sep = "")
cat("Training R²: ", round(train_r2, 3), "\n", sep = "")


# ============================================================
# EXERCISE 5: Calculate Test Performance (2 minutes)
# ============================================================

# GOAL: Measure how well the model generalizes to new data
#
# INSTRUCTION: Calculate RMSE on test data
# HINT: Use predict() with newdata = test_data

# Generate test predictions
test_predictions <- ___  # YOUR CODE: Predict on test data

# Calculate test RMSE
test_rmse <- ___  # YOUR CODE: Calculate RMSE

cat("Test RMSE: $", format(round(test_rmse), big.mark = ","), "\n", sep = "")


# ============================================================
# EXERCISE 6: Compare Train vs Test Performance (2 minutes)
# ============================================================

# GOAL: Quantify the overfitting problem
#
# INSTRUCTION: Calculate performance degradation from train to test
# HINT: Degradation % = (test_rmse - train_rmse) / train_rmse * 100

# Calculate degradation percentage
degradation_pct <- ___  # YOUR CODE: Calculate degradation

cat("\n=== OVERFITTING DIAGNOSIS ===\n")
cat("Training RMSE: $", format(round(train_rmse), big.mark = ","), "\n", sep = "")
cat("Test RMSE:     $", format(round(test_rmse), big.mark = ","), "\n", sep = "")
cat("Degradation:   ", round(degradation_pct, 1), "%\n", sep = "")

# Create visualization
performance_comparison <- tibble(
  Dataset = c("Training", "Test"),
  RMSE = c(train_rmse, test_rmse)
)

ggplot(performance_comparison, aes(x = Dataset, y = RMSE, fill = Dataset)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = paste("$", format(round(RMSE), big.mark = ","), sep = "")),
            vjust = -0.5, size = 5) +
  labs(
    title = "Model Performance: Training vs Test",
    y = "Root Mean Square Error"
  ) +
  scale_y_continuous(labels = scales::dollar) +
  theme_minimal() +
  theme(legend.position = "none")


# ============================================================
# EXERCISE 7: Calculate VIF Values (3 minutes)
# ============================================================

# GOAL: Identify multicollinearity among predictors
#
# INSTRUCTION: Calculate VIF for each predictor
# HINT: Use vif() function from car package

# Calculate VIF
vif_values <- ___  # YOUR CODE: Calculate VIF

# Create VIF data frame for analysis
vif_df <- data.frame(
  Predictor = ___,  # YOUR CODE: Get predictor names
  VIF = ___         # YOUR CODE: Get VIF values
) %>%
  arrange(desc(VIF))

# Display VIF values
print(vif_df)


# ============================================================
# EXERCISE 8: Identify Problematic Predictors (2 minutes)
# ============================================================

# GOAL: Find which predictors have severe multicollinearity
#
# INSTRUCTION: Identify predictors with VIF > 5
# HINT: Use filter() on vif_df

# Find high VIF predictors
high_vif_predictors <- vif_df %>%
  filter(___)  # YOUR CODE: Filter condition for VIF > 5

cat("\n=== MULTICOLLINEARITY DIAGNOSIS ===\n")
cat("Predictors with VIF > 5 (problematic):\n")
print(high_vif_predictors)

# Visualize VIF values
ggplot(vif_df, aes(x = reorder(Predictor, VIF), y = VIF)) +
  geom_col(aes(fill = VIF > 5), width = 0.7) +
  geom_hline(yintercept = 5, linetype = "dashed", color = "red") +
  coord_flip() +
  labs(
    title = "Variance Inflation Factors",
    subtitle = "VIF > 5 indicates problematic multicollinearity",
    x = NULL,
    y = "VIF"
  ) +
  scale_fill_manual(values = c("FALSE" = "steelblue", "TRUE" = "coral")) +
  theme_minimal() +
  theme(legend.position = "none")


# ============================================================
# EXERCISE 9: Calculate Correlation Matrix (3 minutes)
# ============================================================

# GOAL: Understand which features are correlated with each other
#
# INSTRUCTION: Calculate and visualize correlation matrix
# HINT: Use cor() on numeric columns only

# Select numeric predictors (exclude sale_price)
numeric_predictors <- train_data %>%
  select(where(is.numeric), -sale_price)

# Calculate correlation matrix
cor_matrix <- ___  # YOUR CODE: Calculate correlation

# Find high correlations (> 0.7)
high_correlations <- which(
  abs(cor_matrix) > ___ & abs(cor_matrix) < 1,  # YOUR CODE: Threshold
  arr.ind = TRUE
)

# Display high correlations
cat("\n=== HIGH CORRELATIONS (> 0.7) ===\n")
high_cor_df <- data.frame(
  Var1 = rownames(cor_matrix)[high_correlations[,1]],
  Var2 = colnames(cor_matrix)[high_correlations[,2]],
  Correlation = cor_matrix[high_correlations]
) %>%
  distinct(Correlation, .keep_all = TRUE) %>%
  arrange(desc(abs(Correlation)))

print(high_cor_df)

# Optional: Visualize correlation matrix
# Uncomment if you have corrplot package installed
# library(corrplot)
# corrplot(cor_matrix, method = "color", type = "upper")


# ============================================================
# EXERCISE 10: Plot Learning Curves (3 minutes)
# ============================================================

# GOAL: Visualize overfitting across different training set sizes
#
# INSTRUCTION: Calculate train/test error for increasing sample sizes
# HINT: Loop over sample sizes from 100 to nrow(train_data)

# Define sample sizes to test
sample_sizes <- seq(100, nrow(train_data), by = 50)

# Calculate learning curves
learning_data <- map_dfr(sample_sizes, function(n) {
  # Sample n observations
  sample_idx <- sample(1:nrow(train_data), size = n)
  sample_train <- train_data[sample_idx, ]
  
  # Fit model on sample
  model_temp <- lm(sale_price ~ ., data = sample_train)
  
  # Calculate errors
  train_pred <- predict(model_temp, newdata = sample_train)
  test_pred <- predict(model_temp, newdata = test_data)
  
  tibble(
    SampleSize = n,
    TrainingError = sqrt(mean((sample_train$sale_price - train_pred)^2)),
    TestError = sqrt(mean((test_data$sale_price - test_pred)^2))
  )
})

# Plot learning curves
learning_data %>%
  pivot_longer(-SampleSize, names_to = "Dataset", values_to = "RMSE") %>%
  ggplot(aes(x = SampleSize, y = RMSE, color = Dataset)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(
    title = "Learning Curves: Training vs Test Error",
    subtitle = "Persistent gap indicates overfitting",
    x = "Training Sample Size",
    y = "RMSE"
  ) +
  scale_y_continuous(labels = scales::dollar) +
  theme_minimal()


# ============================================================
# EXERCISE 11: Test Coefficient Stability (3 minutes)
# ============================================================

# GOAL: Demonstrate that coefficients are unstable due to multicollinearity
#
# INSTRUCTION: Fit model 5 times on different 90% samples of training data
# HINT: Use sample() to get different subsets

# Fit model on 5 different samples
coef_stability <- map_dfr(1:5, function(i) {
  # Sample 90% of training data
  sample_idx <- sample(1:nrow(train_data), size = 0.9 * nrow(train_data))
  sample_data <- train_data[sample_idx, ]
  
  # Fit model
  model_temp <- lm(sale_price ~ ., data = sample_data)
  
  # Extract coefficients for problematic predictors
  tibble(
    Sample = i,
    Predictor = names(coef(model_temp))[-1],  # Exclude intercept
    Coefficient = coef(model_temp)[-1]
  )
})

# Analyze stability for high VIF predictors
if (nrow(high_vif_predictors) > 0) {
  stability_summary <- coef_stability %>%
    filter(Predictor %in% high_vif_predictors$Predictor) %>%
    group_by(Predictor) %>%
    summarise(
      Mean = mean(Coefficient),
      SD = sd(Coefficient),
      Min = min(Coefficient),
      Max = max(Coefficient),
      Range = Max - Min
    )
  
  cat("\n=== COEFFICIENT STABILITY ANALYSIS ===\n")
  cat("For high VIF predictors:\n")
  print(stability_summary)
  
  # Visualize coefficient variation
  coef_stability %>%
    filter(Predictor %in% high_vif_predictors$Predictor[1:min(4, nrow(high_vif_predictors))]) %>%
    ggplot(aes(x = Sample, y = Coefficient, color = Predictor, group = Predictor)) +
    geom_line(size = 1) +
    geom_point(size = 3) +
    facet_wrap(~ Predictor, scales = "free_y") +
    labs(
      title = "Coefficient Instability Across Samples",
      subtitle = "High VIF predictors show large variation",
      x = "Sample Number",
      y = "Coefficient Value"
    ) +
    theme_minimal() +
    theme(legend.position = "none")
}


# ============================================================
# EXERCISE 12: Make Recommendation (2 minutes)
# ============================================================

# GOAL: Synthesize diagnostics into business recommendation
#
# INSTRUCTION: Fill in the recommendation template based on your findings
# HINT: Use the metrics you calculated in previous exercises

cat("\n=== BUSINESS RECOMMENDATION ===\n\n")

# Summary of findings
cat("DIAGNOSTIC SUMMARY:\n")
cat("1. Performance degradation:", round(degradation_pct, 1), "%\n")
cat("2. Number of predictors with VIF > 5:", nrow(high_vif_predictors), "\n")
cat("3. Training RMSE: $", format(round(train_rmse), big.mark = ","), "\n", sep = "")
cat("4. Test RMSE: $", format(round(test_rmse), big.mark = ","), "\n\n", sep = "")

cat("BUSINESS INTERPRETATION:\n")
# YOUR INTERPRETATION HERE (1-2 sentences)
# Example: "The model shows moderate overfitting with X% degradation..."


cat("\nRECOMMENDATION:\n")
# YOUR RECOMMENDATION HERE (2-3 sentences)
# Should this model be deployed? What should we do instead?


# ============================================================
# REFLECTION QUESTIONS
# ============================================================

# 1. What business decision does this analysis enable?
# YOUR ANSWER:


# 2. Which predictors show the most evidence of multicollinearity?
# YOUR ANSWER:


# 3. What would you recommend to improve model performance?
# YOUR ANSWER:


# ============================================================
# END OF CLASSWORK 1
# ============================================================

cat("\n✓ Classwork 1 complete!\n")
cat("Next: Batch 2 - Ridge Regression will show how to address these issues\n")
