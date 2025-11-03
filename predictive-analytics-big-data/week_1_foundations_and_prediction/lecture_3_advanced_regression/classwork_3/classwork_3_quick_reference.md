# Regularization Quick Reference Guide
## Classwork 3 Companion

---

## 📊 Key Concepts

### Overfitting
- **Definition:** Model performs well on training data but poorly on test data
- **Symptoms:** Large train/test performance gap (>10-15%)
- **Cause:** Model too complex, learns noise instead of signal

### Multicollinearity
- **Definition:** Predictor variables are highly correlated
- **Detection:** VIF > 5 is concerning, VIF > 10 is severe
- **Problem:** Unstable coefficients, can't trust feature importance

---

## 🛠️ Essential R Code Patterns

### 1. Train/Test Split
```r
set.seed(123)
train_idx <- createDataPartition(data$outcome, p = 0.8, list = FALSE)
train_data <- data[train_idx, ]
test_data <- data[-train_idx, ]
```

### 2. Check VIF
```r
library(car)
model <- lm(y ~ ., data = train_data)
vif_values <- vif(model)
print(vif_values)
```

### 3. Calculate RMSE
```r
predictions <- predict(model, newdata = test_data)
rmse <- sqrt(mean((test_data$y - predictions)^2))
```

### 4. Prepare Matrices for glmnet
```r
X_train <- model.matrix(y ~ . - id, data = train_data)[, -1]
y_train <- train_data$y

X_test <- model.matrix(y ~ . - id, data = test_data)[, -1]
y_test <- test_data$y
```

### 5. Ridge Regression
```r
# Cross-validation
cv_ridge <- cv.glmnet(X_train, y_train, alpha = 0, nfolds = 10)

# Fit final model
ridge_model <- glmnet(X_train, y_train, alpha = 0, 
                      lambda = cv_ridge$lambda.1se)

# Predict
predictions <- predict(ridge_model, newx = X_test, 
                      s = cv_ridge$lambda.1se)
```

### 6. LASSO Regression
```r
# Cross-validation
cv_lasso <- cv.glmnet(X_train, y_train, alpha = 1, nfolds = 10)

# Fit final model
lasso_model <- glmnet(X_train, y_train, alpha = 1,
                      lambda = cv_lasso$lambda.1se)

# Predict
predictions <- predict(lasso_model, newx = X_test,
                      s = cv_lasso$lambda.1se)
```

### 7. Extract Selected Features (LASSO)
```r
coefs <- coef(lasso_model)
selected <- data.frame(
  Feature = rownames(coefs)[-1],
  Coefficient = as.vector(coefs)[-1]
) %>%
  filter(Coefficient != 0)
```

---

## 🎯 Decision Tree: Which Method?

```
Start: Do you have multicollinearity or overfitting?
│
├─ NO → Use OLS (simple linear regression)
│
└─ YES → Need regularization
    │
    ├─ Want to keep ALL features? → Use Ridge (alpha = 0)
    │
    └─ Want automatic feature selection? → Use LASSO (alpha = 1)
```

---

## 📈 Ridge vs LASSO Comparison

| Aspect | Ridge (L2) | LASSO (L1) |
|--------|-----------|------------|
| **Alpha parameter** | 0 | 1 |
| **Penalty formula** | λ Σβ² | λ Σ\|β\| |
| **Feature selection** | NO | YES |
| **Coefficients** | All shrunk, none zero | Some exactly zero |
| **Use when** | All features relevant | Want interpretability |
| **Best for** | High correlation | Many irrelevant features |

---

## 🔢 Lambda Selection

**Two options from cv.glmnet:**

1. **lambda.min** 
   - Gives best CV performance
   - More complex model
   - May overfit slightly

2. **lambda.1se** ✅ (RECOMMENDED)
   - Within 1 SE of best performance
   - Simpler model
   - Better generalization
   - More stable

**Rule:** Always use `lambda.1se` unless you have a specific reason not to.

---

## 🚫 Common Mistakes to Avoid

1. ❌ **Forgetting to set seed**
   ```r
   set.seed(123)  # Always do this before train/test split!
   ```

2. ❌ **Using data frames instead of matrices for glmnet**
   ```r
   # WRONG
   model <- glmnet(train_data, y_train, alpha = 0)
   
   # RIGHT
   X_train <- model.matrix(y ~ . - id, data = train_data)[, -1]
   model <- glmnet(X_train, y_train, alpha = 0)
   ```

3. ❌ **Not specifying lambda when predicting**
   ```r
   # WRONG
   predict(model, newx = X_test)
   
   # RIGHT
   predict(model, newx = X_test, s = cv_model$lambda.1se)
   ```

4. ❌ **Forgetting to remove ID column**
   ```r
   # Include: - id_column in formula
   model.matrix(y ~ . - house_id, data = train_data)
   ```

5. ❌ **Comparing models on training data**
   ```r
   # WRONG: Comparing on training set
   train_rmse_ols vs train_rmse_ridge
   
   # RIGHT: Compare on test set
   test_rmse_ols vs test_rmse_ridge
   ```

---

## 💡 Pro Tips

### Interpreting CV Plot
- **Y-axis:** Mean-Squared Error
- **X-axis:** log(Lambda)
- **Red line:** lambda.min
- **Blue line:** lambda.1se
- **Top axis (LASSO only):** Number of features
- **Error bars:** Standard error across folds

### Reading Coefficient Paths
- **Left side:** Small lambda (like OLS)
- **Right side:** Large lambda (heavy penalty)
- **Ridge:** All lines approach zero but never touch
- **LASSO:** Lines hit zero axis (feature dropped)

### Judging Overfitting
- **< 5% degradation:** Excellent
- **5-10% degradation:** Acceptable
- **10-20% degradation:** Concerning (use regularization!)
- **> 20% degradation:** Severe overfitting

---

## 🎓 Conceptual Understanding

### Why Does Ridge Help?
- Penalizes large coefficients
- Forces model to spread weight across features
- Reduces sensitivity to multicollinearity
- More stable predictions

### Why Does LASSO Select Features?
- L1 penalty creates "corners" at axes
- Optimization tends to hit these corners
- When coefficient hits corner → exactly zero
- Automatic feature selection!

### When Models Improve
- **Training RMSE goes UP:** ✅ Good! Less overfitting
- **Test RMSE goes DOWN:** ✅ Good! Better generalization
- **Smaller train/test gap:** ✅ Good! More stable

---

## 📝 Checklist for Each Exercise

### Before Starting:
- [ ] Load all required libraries
- [ ] Set random seed
- [ ] Understand what the exercise asks

### During Analysis:
- [ ] Check data dimensions
- [ ] Verify no missing values
- [ ] Inspect first few rows
- [ ] Check that code runs without errors

### After Analysis:
- [ ] Interpret the results
- [ ] Answer the question in comments
- [ ] Create visualizations
- [ ] Compare to previous exercises

---

## 🔍 Troubleshooting

**Error: "x should be a matrix"**
→ Use `model.matrix()` to create X_train/X_test

**Error: "object 'lambda' not found"**
→ Specify `s = cv_model$lambda.1se` in predict()

**Warning: "variables are collinear"**
→ This is expected! That's why we use regularization

**All LASSO coefficients zero**
→ Lambda too large, try lambda.min instead

**Ridge and LASSO give same results**
→ Check alpha parameter (0 = Ridge, 1 = LASSO)

---

## 📚 Additional Resources

**Documentation:**
- `?glmnet` - Main function help
- `?cv.glmnet` - Cross-validation help
- `?predict.glmnet` - Prediction help

**Key Functions:**
- `createDataPartition()` - Smart train/test split
- `vif()` - Check multicollinearity
- `glmnet()` - Fit Ridge/LASSO
- `cv.glmnet()` - Cross-validation
- `coef()` - Extract coefficients
- `predict()` - Make predictions

---

## 🎯 Learning Goals Checklist

By end of Classwork 3, you should be able to:

- [ ] Split data into train/test sets
- [ ] Diagnose overfitting using RMSE
- [ ] Calculate and interpret VIF
- [ ] Prepare data matrices for glmnet
- [ ] Fit Ridge regression with CV
- [ ] Fit LASSO regression with CV
- [ ] Compare model performance
- [ ] Identify selected features in LASSO
- [ ] Make business recommendations
- [ ] Create effective visualizations

---

## 🤔 Self-Check Questions

1. What does alpha control in glmnet?
   - **Answer:** 0 = Ridge, 1 = LASSO

2. Why use lambda.1se instead of lambda.min?
   - **Answer:** Simpler model, better generalization

3. How do you know if overfitting exists?
   - **Answer:** Test RMSE >> Training RMSE

4. What does VIF measure?
   - **Answer:** Multicollinearity among predictors

5. Main difference between Ridge and LASSO?
   - **Answer:** LASSO does feature selection (sets coefs to 0)

---

**Good luck with your exercises! 🚀**

*Remember: Understanding > Memorization*
*If stuck, re-read the lecture slides or check the solutions!*
