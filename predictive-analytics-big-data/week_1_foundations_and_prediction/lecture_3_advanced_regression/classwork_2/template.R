# ============================================================
# CLASSWORK 2: Building Ridge Models
# Lecture 3: Advanced Regression & Regularization
# Time: 25-30 minutes
# ============================================================

# LEARNING OBJECTIVE:
# You will build and tune Ridge regression models using cross-validation
# to improve prediction accuracy and reduce overfitting.

# BUSINESS CONTEXT:
# HomeLend Financial's model has multicollinearity and overfitting issues.
# You need to apply Ridge regression to stabilize predictions and improve
# performance on new houses.

# DATA:
# Same housing data from Classwork 1 (750 houses, 16 predictors)

# ============================================================
# SETUP
# ============================================================

# Load required packages
library(tidyverse)
library(glmnet)    # For Ridge regression
library(caret)     # For train/test split

# Set seed for reproducibility
set.seed(123)


# ============================================================
# EXERCISE 1: Load and Explore Data (2 minutes)
# ============================================================

# GOAL: Load the housing data and verify structure
# 
# INSTRUCTION: Load the data and check dimensions
# HINT: Use read_csv() and dim()

# Load the data
housing_data <- read_csv("data/housing_prices.csv")

# Check structure
glimpse(housing_data)

# How many observations and variables?
n_obs <- ___  # YOUR CODE HERE
n_vars <- ___ # YOUR CODE HERE

cat("Dataset:", n_obs, "houses,", n_vars, "variables\n")


# ============================================================
# EXERCISE 2: Create Train/Test Split (2 minutes)
# ============================================================

# GOAL: Split data the same way as Classwork 1
#
# INSTRUCTION: Create 80/20 train/test split
# HINT: Use createDataPartition() with p = 0.8

# Create train/test split
train_indices <- createDataPartition(
  ___,  # YOUR CODE: What variable to stratify on?
  p = ___, # YOUR CODE: What proportion for training?
  list = FALSE
)

train_data <- ___  # YOUR CODE: Subset training data
test_data <- ___   # YOUR CODE: Subset test data

cat("Training set:", nrow(train_data), "houses\n")
cat("Test set:", nrow(test_data), "houses\n")


# ============================================================
# EXERCISE 3: Prepare Matrix Format (3 minutes)
# ============================================================

# GOAL: Convert data to matrix format for glmnet
#
# INSTRUCTION: Create predictor matrices (X) and outcome vectors (y)
# HINT: Use model.matrix() and remove the intercept column with [, -1]

# Create predictor matrix for training data
X_train <- model.matrix(
  sale_price ~ . -1,  # -1 removes intercept
  data = train_data
)

# Create outcome vector for training data
y_train <- ___  # YOUR CODE: Extract sale_price from train_data

# Create predictor matrix for test data
X_test <- model.matrix(
  sale_price ~ . -1,
  data = test_data
)

# Create outcome vector for test data
y_test <- ___  # YOUR CODE: Extract sale_price from test_data

# Verify dimensions
cat("X_train dimensions:", dim(X_train), "\n")
cat("y_train length:", length(y_train), "\n")


# ============================================================
# EXERCISE 4: Fit Basic Ridge Model (2 minutes)
# ============================================================

# GOAL: Fit a Ridge model with lambda = 1000
#
# INSTRUCTION: Use glmnet() with alpha = 0 (Ridge) and lambda = 1000
# HINT: glmnet(x = X_train, y = y_train, alpha = 0, lambda = 1000)

# Fit Ridge model
ridge_basic <- glmnet(
  x = ___,      # YOUR CODE: Training predictors
  y = ___,      # YOUR CODE: Training outcome
  alpha = ___,  # YOUR CODE: 0 for Ridge, 1 for LASSO
  lambda = ___  # YOUR CODE: Try lambda = 1000
)

# Look at coefficients
print(coef(ridge_basic))

# How many non-zero coefficients? (Should be all of them for Ridge!)
n_nonzero <- sum(coef(ridge_basic) != 0)
cat("Non-zero coefficients:", n_nonzero, "\n")


# ============================================================
# EXERCISE 5: Compare Ridge to OLS (3 minutes)
# ============================================================

# GOAL: See how Ridge shrinks coefficients compared to OLS
#
# INSTRUCTION: Fit OLS model and compare coefficients
# HINT: Use lm() for OLS, then compare to Ridge coefficients

# Fit OLS model
ols_model <- lm(sale_price ~ ., data = train_data)

# Extract OLS coefficients (remove intercept)
ols_coefs <- ___  # YOUR CODE: coef(ols_model)[-1]

# Extract Ridge coefficients (remove intercept)
ridge_coefs <- as.vector(coef(ridge_basic))[-1]

# Create comparison
comparison <- tibble(
  Predictor = names(ols_coefs),
  OLS = ols_coefs,
  Ridge = ridge_coefs,
  Shrinkage_Pct = round((1 - abs(Ridge/OLS)) * 100, 1)
)

# Show predictors with most shrinkage
comparison %>%
  arrange(desc(Shrinkage_Pct)) %>%
  head(5)


# ============================================================
# EXERCISE 6: Cross-Validation for Lambda (3 minutes)
# ============================================================

# GOAL: Find the optimal lambda using cross-validation
#
# INSTRUCTION: Use cv.glmnet() with 10-fold CV
# HINT: cv.glmnet(x = X_train, y = y_train, alpha = 0, nfolds = 10)

# Run cross-validation
set.seed(42)
cv_ridge <- cv.glmnet(
  x = ___,       # YOUR CODE: Training predictors
  y = ___,       # YOUR CODE: Training outcome
  alpha = ___,   # YOUR CODE: 0 for Ridge
  nfolds = ___   # YOUR CODE: Use 10 folds
)

# Extract optimal lambda values
lambda_min <- ___  # YOUR CODE: cv_ridge$lambda.min
lambda_1se <- ___  # YOUR CODE: cv_ridge$lambda.1se

cat("Lambda min (best performance):", lambda_min, "\n")
cat("Lambda 1se (simpler model):   ", lambda_1se, "\n")


# ============================================================
# EXERCISE 7: Interpret CV Plot (2 minutes)
# ============================================================

# GOAL: Visualize how lambda affects cross-validation error
#
# INSTRUCTION: Plot the CV results
# HINT: Use plot(cv_ridge)

# Plot cross-validation results
plot(cv_ridge, 
     main = "Cross-Validation for Lambda Selection",
     xlab = "Log(Lambda)", 
     ylab = "Mean-Squared Error")

# Add vertical lines for lambda.min and lambda.1se
abline(v = log(lambda_min), col = "red", lty = 2)
abline(v = log(lambda_1se), col = "blue", lty = 2)

legend("topleft", 
       legend = c("Lambda min", "Lambda 1se"),
       col = c("red", "blue"), 
       lty = 2)


# ============================================================
# EXERCISE 8: Fit Final Ridge Model (2 minutes)
# ============================================================

# GOAL: Fit Ridge model with optimal lambda
#
# INSTRUCTION: Fit Ridge using lambda.1se (simpler model)
# HINT: glmnet(x = X_train, y = y_train, alpha = 0, lambda = lambda_1se)

# Fit final Ridge model
ridge_final <- glmnet(
  x = ___,       # YOUR CODE: Training predictors
  y = ___,       # YOUR CODE: Training outcome
  alpha = ___,   # YOUR CODE: 0 for Ridge
  lambda = ___   # YOUR CODE: Use lambda_1se
)

# Display final coefficients
print(coef(ridge_final))

# Are all predictors still in the model?
n_predictors <- sum(coef(ridge_final)[-1] != 0)
cat("Number of predictors in final model:", n_predictors, "\n")


# ============================================================
# EXERCISE 9: Calculate Training Performance (2 minutes)
# ============================================================

# GOAL: Measure how well Ridge fits training data
#
# INSTRUCTION: Calculate training RMSE
# HINT: Use predict() with newx = X_train, then calculate RMSE

# Generate training predictions
ridge_train_pred <- predict(
  ridge_final, 
  newx = ___,  # YOUR CODE: Use X_train
  s = ___      # YOUR CODE: Use lambda_1se
)

# Calculate training RMSE
ridge_train_rmse <- ___  # YOUR CODE: sqrt(mean((y_train - ridge_train_pred)^2))

cat("Ridge Training RMSE: $", format(round(ridge_train_rmse), big.mark = ","), "\n", sep = "")


# ============================================================
# EXERCISE 10: Calculate Test Performance (2 minutes)
# ============================================================

# GOAL: Measure how well Ridge generalizes to new data
#
# INSTRUCTION: Calculate test RMSE
# HINT: Use predict() with newx = X_test

# Generate test predictions
ridge_test_pred <- predict(
  ___,         # YOUR CODE: Use ridge_final
  newx = ___,  # YOUR CODE: Use X_test
  s = ___      # YOUR CODE: Use lambda_1se
)

# Calculate test RMSE
ridge_test_rmse <- ___  # YOUR CODE: Calculate RMSE

cat("Ridge Test RMSE: $", format(round(ridge_test_rmse), big.mark = ","), "\n", sep = "")


# ============================================================
# EXERCISE 11: Compare to OLS (2 minutes)
# ============================================================

# GOAL: Quantify Ridge improvement over OLS
#
# INSTRUCTION: Compare OLS and Ridge performance
# HINT: Calculate improvement in test error

# OLS performance (from Classwork 1 - use your actual values)
ols_train_rmse <- 95000  # Approximate - use your actual value
ols_test_rmse <- 110000  # Approximate - use your actual value

# Calculate improvements
train_change <- ridge_train_rmse - ols_train_rmse
test_improvement <- ols_test_rmse - ridge_test_rmse
test_improvement_pct <- (test_improvement / ols_test_rmse) * 100

cat("\n=== PERFORMANCE COMPARISON ===\n")
cat("OLS Training RMSE:   $", format(round(ols_train_rmse), big.mark = ","), "\n", sep = "")
cat("Ridge Training RMSE: $", format(round(ridge_train_rmse), big.mark = ","), "\n", sep = "")
cat("Change:              $", format(round(train_change), big.mark = ","), 
    "(Ridge has higher training error - less overfitting!)\n\n", sep = "")

cat("OLS Test RMSE:       $", format(round(ols_test_rmse), big.mark = ","), "\n", sep = "")
cat("Ridge Test RMSE:     $", format(round(ridge_test_rmse), big.mark = ","), "\n", sep = "")
cat("Improvement:         $", format(round(test_improvement), big.mark = ","), 
    " (", round(test_improvement_pct, 1), "%)\n", sep = "")

# Visualize comparison
performance_data <- tibble(
  Model = rep(c("OLS", "Ridge"), each = 2),
  Dataset = rep(c("Training", "Test"), 2),
  RMSE = c(ols_train_rmse, ols_test_rmse, 
           ridge_train_rmse, ridge_test_rmse)
)

ggplot(performance_data, aes(x = Dataset, y = RMSE, fill = Model)) +
  geom_col(position = "dodge", width = 0.7) +
  geom_text(aes(label = paste("$", format(round(RMSE/1000), big.mark = ","), "K", sep = "")),
            position = position_dodge(width = 0.7), vjust = -0.5) +
  labs(title = "OLS vs Ridge: Performance Comparison",
       subtitle = "Ridge reduces test error and train/test gap",
       y = "RMSE") +
  scale_y_continuous(labels = scales::dollar) +
  theme_minimal()


# ============================================================
# EXERCISE 12: Make Recommendation (2 minutes)
# ============================================================

# GOAL: Synthesize results into business recommendation
#
# INSTRUCTION: Fill in the recommendation template
# HINT: Use the metrics you calculated above

cat("\n=== BUSINESS RECOMMENDATION ===\n\n")

cat("FINDINGS:\n")
cat("1. Test error improvement: $", format(round(test_improvement), big.mark = ","), 
    " (", round(test_improvement_pct, 1), "%)\n", sep = "")
cat("2. Training error change: $", format(round(train_change), big.mark = ","), 
    " (acceptable trade-off)\n", sep = "")
cat("3. All", n_predictors, "predictors retained with stable coefficients\n")
cat("4. Optimal lambda selected via 10-fold cross-validation\n\n")

cat("INTERPRETATION:\n")
# YOUR INTERPRETATION HERE (2-3 sentences)
# Example: "Ridge regression successfully reduces overfitting..."


cat("\nRECOMMENDATION:\n")
# YOUR RECOMMENDATION HERE (2-3 sentences)
# Should HomeLend deploy this Ridge model?
# What advantages does it have over OLS?
# What should they monitor in production?


# ============================================================
# BONUS: Coefficient Path Visualization (Optional)
# ============================================================

# If you have extra time, visualize how coefficients change with lambda

# Fit Ridge across many lambda values
ridge_path <- glmnet(
  x = X_train, 
  y = y_train, 
  alpha = 0,
  lambda = 10^seq(5, -2, length = 100)
)

# Plot coefficient paths
plot(ridge_path, xvar = "lambda", label = TRUE,
     main = "Ridge Coefficient Paths")
abline(v = log(lambda_1se), lty = 2, col = "red")
text(x = log(lambda_1se), y = 0, labels = "Optimal λ", 
     pos = 4, col = "red")


# ============================================================
# REFLECTION QUESTIONS
# ============================================================

# 1. Why does Ridge have HIGHER training error but LOWER test error than OLS?
# YOUR ANSWER:


# 2. Would you use lambda.min or lambda.1se for production? Why?
# YOUR ANSWER:


# 3. All features are still in the model. Is this an advantage or disadvantage?
# YOUR ANSWER:


# 4. What would you monitor if this model goes to production?
# YOUR ANSWER:


# ============================================================
# END OF CLASSWORK 2
# ============================================================

cat("\n✓ Classwork 2 complete!\n")
cat("You've learned how Ridge regression controls overfitting!\n")
cat("Next: Batch 3 - LASSO regression for automatic feature selection\n")
