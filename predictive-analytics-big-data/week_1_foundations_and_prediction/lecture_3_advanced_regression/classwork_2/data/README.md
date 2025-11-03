# CLASSWORK 2: Building Ridge Models

## Overview
This classwork teaches students how to implement Ridge regression to fix overfitting problems identified in Classwork 1.

## Learning Outcomes
By completing this classwork, students will:
1. ✅ Fit Ridge regression models using glmnet
2. ✅ Use cross-validation to select optimal lambda
3. ✅ Compare Ridge to OLS performance
4. ✅ Interpret coefficient shrinkage
5. ✅ Make deployment recommendations

## Files Included

```
classwork_2/
├── instructions.md          # Full setup guide and context
├── template.R              # 12 micro-exercises with blanks
└── data/
    └── housing_prices.csv  # 750 houses for practice
```

## Time Required
- **Exercises 1-12:** 25-30 minutes
- **Reflection questions:** 5 minutes
- **Total:** ~30-35 minutes

## Prerequisites
Students should have completed:
- Batch 1: When Simple Regression Fails (slides 1-30)
- Batch 2: Ridge Regression (slides 31-60)
- Classwork 1: Diagnosing Overfitting

## Exercise Structure

### Part 1: Setup (Exercises 1-3)
- Load packages and data
- Create train/test split
- Convert to matrix format for glmnet

### Part 2: Basic Ridge (Exercises 4-5)
- Fit Ridge with single lambda
- Compare coefficients to OLS

### Part 3: Optimization (Exercises 6-8)
- Cross-validation for lambda selection
- Interpret CV plot
- Fit final optimized model

### Part 4: Evaluation (Exercises 9-11)
- Calculate training performance
- Calculate test performance
- Compare to OLS baseline

### Part 5: Decision (Exercise 12)
- Synthesize results
- Make business recommendation

## Key Concepts Covered

### Technical
- **glmnet package:** Industry-standard regularization
- **Matrix format:** Converting data frames for glmnet
- **Cross-validation:** Selecting optimal hyperparameters
- **Lambda tuning:** min vs 1se rule
- **Coefficient paths:** Visualizing regularization effect

### Business
- **Overfitting reduction:** Trading training fit for generalization
- **Model stability:** Consistent predictions across samples
- **Deployment readiness:** Production-quality models
- **Stakeholder communication:** Explaining regularization benefits

## Expected Results

Students should find:

**Performance Improvement:**
- OLS test RMSE: ~$110,000
- Ridge test RMSE: ~$102,000
- Improvement: ~$8,000 (7-8%)

**Coefficient Behavior:**
- All predictors retained (unlike LASSO)
- Coefficients shrunk toward zero
- High-VIF features most affected

**Lambda Selection:**
- Optimal lambda.1se: typically 1,000-10,000
- CV curve shows clear minimum
- Trade-off between fit and simplicity

## Common Student Mistakes

### Mistake 1: Wrong Alpha Value
```r
# WRONG
model <- glmnet(X_train, y_train, alpha = 1)  # This is LASSO!

# CORRECT
model <- glmnet(X_train, y_train, alpha = 0)  # Ridge
```

### Mistake 2: Missing 's' Parameter
```r
# WRONG
predict(model, newx = X_test)  # Which lambda?

# CORRECT
predict(model, newx = X_test, s = lambda_1se)
```

### Mistake 3: Comparing Wrong Metrics
```r
# WRONG - comparing training performance
if (ridge_train_rmse < ols_train_rmse) { ... }

# CORRECT - comparing test performance
if (ridge_test_rmse < ols_test_rmse) { ... }
```

### Mistake 4: Not Using Matrix Format
```r
# WRONG
model <- glmnet(train_data, y_train, alpha = 0)  # data frame

# CORRECT
X_train <- model.matrix(sale_price ~ . -1, train_data)
model <- glmnet(X_train, y_train, alpha = 0)  # matrix
```

## Teaching Tips

### Emphasis Points
1. **Exercise 3:** Take time to explain matrix format - students often struggle here
2. **Exercise 6:** Emphasize that CV automates what would be tedious manual testing
3. **Exercise 7:** The CV plot is key - make sure students understand the U-shape
4. **Exercise 11:** The performance comparison is the payoff - celebrate the improvement!

### Discussion Questions
- "Why does Ridge INCREASE training error but DECREASE test error?"
- "When would you NOT want to use Ridge?"
- "How do you explain lambda to a non-technical stakeholder?"

### Common Questions & Answers

**Q:** "Why not just remove correlated variables instead of using Ridge?"
**A:** Ridge keeps all information but reduces instability. Removing variables loses potentially useful information.

**Q:** "Why does Ridge keep all features? Isn't that less interpretable?"
**A:** Yes! That's why we'll learn LASSO next (Batch 3) which does feature selection.

**Q:** "What if I want lambda.min instead of lambda.1se?"
**A:** Lambda.min gives slightly better CV performance but may overfit. Lambda.1se is more conservative and generally better for production.

**Q:** "How often should I retrain the model in production?"
**A:** Monitor test error monthly. Retrain when performance degrades beyond threshold (e.g., 10% worse).

## Grading Rubric (if used for assessment)

| Component | Points | Criteria |
|-----------|--------|----------|
| **Setup (Ex 1-3)** | 15 | Correct matrix format, proper split |
| **Ridge fitting (Ex 4-5)** | 15 | Proper glmnet usage, alpha = 0 |
| **CV optimization (Ex 6-8)** | 25 | Correct CV implementation, lambda selection |
| **Evaluation (Ex 9-11)** | 25 | Accurate RMSE calculation, proper comparison |
| **Recommendation (Ex 12)** | 15 | Data-driven, considers trade-offs |
| **Code quality** | 5 | Clean, commented, reproducible |
| **Total** | 100 | |

## Extensions for Advanced Students

If students finish early:

1. **Try different lambda values manually** and plot performance curve
2. **Create coefficient path visualization** (bonus section in template)
3. **Test Ridge on different train/test splits** to verify stability
4. **Compare multiple alpha values** (0, 0.25, 0.5, 0.75, 1.0)
5. **Add polynomial features** and see how Ridge handles them

## Troubleshooting

### Issue: "Error in glmnet: x should be a matrix"
**Solution:** Use `model.matrix()` to convert data frame to matrix

### Issue: "predict() returns wrong dimensions"
**Solution:** Make sure to use `s = lambda_value` parameter

### Issue: "All coefficients are zero"
**Solution:** Lambda is too large. Check cv_ridge$lambda.min and lambda.1se

### Issue: "Can't install glmnet"
**Solution:** Try `install.packages("glmnet", dependencies = TRUE)`

### Issue: "CV taking too long"
**Solution:** Reduce nfolds to 5 or use fewer lambda values

## Connection to Next Topics

This classwork prepares students for:
- **Batch 3:** LASSO regression (alpha = 1) for feature selection
- **Batch 4:** Elastic Net (alpha between 0 and 1)
- **Homework 3:** Complete regularization project

Students should understand:
- Ridge is one tool in the regularization toolkit
- Different problems need different approaches
- LASSO will address the "which features matter?" question

---

**Instructor Notes:** This is a hands-on, practical exercise. Students learn best by doing, making mistakes, and debugging. Encourage experimentation!

**Version:** 1.0  
**Last Updated:** November 1, 2025  
**Status:** ✅ Ready for classroom use
