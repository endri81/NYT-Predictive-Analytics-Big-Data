# Classwork 2: Building Ridge Models

## Learning Objective
You will **build and tune Ridge regression models** using cross-validation to **improve prediction accuracy** and **reduce overfitting** in housing price forecasts.

## Business Context
After diagnosing overfitting in Classwork 1, HomeLend Financial needs you to fix the model. The current multiple regression model has:
- High multicollinearity (VIF > 5 on several features)
- 15% test error degradation
- Unstable coefficients across samples

**Your task:** Apply Ridge regression to stabilize the model and improve generalization to new markets.

## Dataset: housing_prices.csv
Same dataset from Classwork 1:
- **750 houses** from various neighborhoods
- **Target:** sale_price (in dollars)
- **16 predictors:** size, location, condition, etc.

## Time Required
25-30 minutes

## Setup
1. Open RStudio
2. Create a new R script
3. Navigate to: `lecture_3_advanced_regression/classwork_2/`
4. Open `template.R`
5. Work through exercises 1-12 in order

## Exercises Overview
1. **Load packages and data** (2 min) - Setup Ridge environment
2. **Create train/test split** (2 min) - Prepare for validation
3. **Prepare matrix format** (3 min) - Convert data for glmnet
4. **Fit basic Ridge model** (2 min) - Try one lambda value
5. **Compare Ridge to OLS** (3 min) - See coefficient shrinkage
6. **Cross-validation for lambda** (3 min) - Find optimal penalty
7. **Interpret CV plot** (2 min) - Understand lambda selection
8. **Fit final Ridge model** (2 min) - Use optimal lambda
9. **Calculate training performance** (2 min) - Measure fit
10. **Calculate test performance** (2 min) - Measure generalization
11. **Compare to OLS** (2 min) - Quantify improvement
12. **Make recommendation** (2 min) - Business decision

## Success Criteria
By the end, you will have:
- [ ] Successfully fit Ridge models with glmnet
- [ ] Used cross-validation to select optimal lambda
- [ ] Compared Ridge to OLS performance
- [ ] Demonstrated improvement in test error
- [ ] Made data-driven deployment recommendation

## Common Issues & Solutions

**Issue:** glmnet package not installed
- **Solution:** Run `install.packages("glmnet")`

**Issue:** Matrix format error
- **Solution:** Make sure you're using `model.matrix()` to create X

**Issue:** Lambda too large (all coefficients zero)
- **Solution:** Check cv_ridge$lambda.min and lambda.1se values

**Issue:** Predictions have wrong dimensions
- **Solution:** Use `predict(model, newx = X_test, s = lambda)`

**Issue:** Can't compare to OLS
- **Solution:** Make sure you saved OLS RMSE from Classwork 1

## Key Functions to Use

### glmnet
```r
# Fit Ridge regression
model <- glmnet(x = X_train, y = y_train, 
                alpha = 0,      # 0 = Ridge, 1 = LASSO
                lambda = 100)   # Penalty strength
```

### cv.glmnet
```r
# Cross-validation for lambda
cv_model <- cv.glmnet(x = X_train, y = y_train,
                      alpha = 0,
                      nfolds = 10)
```

### predict
```r
# Make predictions
predictions <- predict(model, newx = X_test, s = lambda)
```

## Resources
- **Lecture slides:** Slides 31-60 (Batch 2)
- **R documentation:** 
  - `?glmnet` for Ridge regression
  - `?cv.glmnet` for cross-validation
  - `?predict.glmnet` for predictions
- **Further reading:**
  - [glmnet vignette](https://glmnet.stanford.edu/articles/glmnet.html)
  - James et al., "An Introduction to Statistical Learning", Chapter 6.2

## What You'll Learn

### Technical Skills
- Converting data frames to matrices
- Fitting Ridge models with glmnet
- Using cross-validation for hyperparameter tuning
- Interpreting coefficient shrinkage
- Comparing regularized to standard regression

### Business Skills
- Explaining Ridge to non-technical stakeholders
- Quantifying model improvement
- Making deployment recommendations
- Understanding bias-variance tradeoff in practice

## Reflection Questions
After completing all exercises, consider:

1. **Performance Trade-off:** Ridge has slightly higher training error but lower test error. Why is this acceptable?

2. **Lambda Selection:** You found optimal lambda via CV. Would you use lambda.min or lambda.1se for production? Why?

3. **Feature Importance:** All features are still in the model (just shrunken). Is this better or worse than removing features entirely?

4. **Production Readiness:** Based on your results, would you recommend deploying this Ridge model? What monitoring would you suggest?

## Expected Results

**Before (OLS from Classwork 1):**
- Training RMSE: ~$95,000
- Test RMSE: ~$110,000
- Degradation: ~15%
- VIF issues: Multiple predictors > 5

**After (Ridge):**
- Training RMSE: ~$98,000 (slightly higher - less overfitting!)
- Test RMSE: ~$102,000 (improved!)
- Degradation: ~4% (much better!)
- Stability: Coefficients stable across samples

**Improvement:** ~$8,000 reduction in test error

---

**Remember:** The goal is to build models that work well on NEW houses, not just the training data. Ridge helps us achieve this by controlling model complexity.

**Ready?** Open `template.R` and begin with Exercise 1!
