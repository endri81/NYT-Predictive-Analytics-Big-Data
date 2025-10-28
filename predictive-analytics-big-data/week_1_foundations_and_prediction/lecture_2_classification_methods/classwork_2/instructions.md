# Classwork 2: Building Ridge Models

**Time Allocation:** 30-40 minutes

## Business Context

You are continuing your analysis for **TechMart's** pricing team. In Classwork 1, you diagnosed severe overfitting in the OLS model with 75 features. The VP of Pricing has greenlit a Ridge regression approach to stabilize the model.

Your task is to implement Ridge regression, optimize the regularization parameter through cross-validation, and determine whether the resulting model is ready for production deployment.

## Dataset Description

**File:** `product_features_extended.csv` (same dataset from Classwork 1)

**Observations:** 400 products  
**Features:** 75 predictor variables + 1 target variable

You should already be familiar with this dataset from your overfitting diagnosis.

## Your Tasks

### Part 1: Data Preparation (5 minutes)

1. Load the data and handle any missing values (simple median imputation is sufficient)

2. Create the same 70/30 train-test split from Classwork 1 (use `set.seed(123)`)

3. Prepare the data in matrix format required by `glmnet`:
   - Use `model.matrix()` to create design matrices for predictors
   - Extract target variable as vectors
   - Remember to remove the intercept column with `- 1` in the formula

### Part 2: Ridge Regression Implementation (10 minutes)

4. Fit a Ridge regression model using `glmnet()`:
   - Set `alpha = 0` for Ridge (L2 penalty)
   - Set `standardize = TRUE` (critical for fair penalization)
   - Let `glmnet` automatically select a sequence of lambda values

5. Examine the model object:
   - How many lambda values were tested?
   - What is the range of lambda values?
   - Plot the regularization path using `plot(model, xvar = "lambda")`

6. Interpret the regularization path:
   - What happens to coefficients as lambda increases?
   - Do any coefficients ever reach exactly zero?

### Part 3: Cross-Validation for Optimal Lambda (10 minutes)

7. Perform 10-fold cross-validation using `cv.glmnet()`:
   - Set `alpha = 0`
   - Set `nfolds = 10`
   - Set `type.measure = "mse"`
   - Use `set.seed(42)` for reproducibility

8. Plot the cross-validation results and identify:
   - `lambda.min`: lambda with minimum CV error
   - `lambda.1se`: lambda within 1 standard error of minimum
   - The corresponding CV errors

9. Extract the minimum CV MSE and convert to RMSE

### Part 4: Model Evaluation (10 minutes)

10. Generate predictions using the optimal lambda (`lambda.min`):
    - Training set predictions
    - Testing set predictions

11. Calculate performance metrics for Ridge:
    - Training RMSE and R²
    - Testing RMSE and R²

12. Compare Ridge performance to your OLS results from Classwork 1:
    - Create a comparison table with both models
    - Calculate the train-test gap for both models
    - Compute percentage improvement in generalization

13. Create visualizations:
    - Side-by-side actual vs predicted plots (Ridge training vs testing)
    - Bar chart comparing OLS vs Ridge performance metrics

### Part 5: Coefficient Analysis (5 minutes)

14. Extract Ridge coefficients at optimal lambda

15. Identify the top 10 features by absolute coefficient magnitude

16. Create a visualization comparing OLS vs Ridge coefficients for these top 10 features

17. Calculate the average shrinkage percentage: How much did Ridge reduce coefficient magnitudes on average?

### Part 6: Business Recommendation (5 minutes)

18. Based on your analysis, complete a deployment recommendation using this template:

**Deployment Readiness Assessment**

| Criterion | Threshold | Ridge Model Result | Status |
|-----------|-----------|-------------------|---------|
| Testing RMSE | < $10K | [Your value] | Pass/Fail |
| Train-Test RMSE Gap | < $5K | [Your value] | Pass/Fail |
| Testing R² | > 0.75 | [Your value] | Pass/Fail |
| Coefficient Stability | VIF concerns resolved | [Your assessment] | Pass/Fail |

**Recommendation:** [Deploy / Do Not Deploy / Deploy with Monitoring]

**Justification:** (2-3 sentences explaining your recommendation based on the metrics above)

**Risks:** (1-2 sentences on remaining concerns or monitoring requirements)

## Deliverables

1. Completed `student_workspace.Rmd` with all code, outputs, and visualizations
2. Deployment readiness assessment with clear recommendation
3. Knitted HTML report

## Success Criteria

- ✅ Correct implementation of Ridge regression with cross-validation
- ✅ Accurate performance metrics comparing OLS vs Ridge
- ✅ Clear visualizations of regularization path and coefficient shrinkage
- ✅ Top 10 features identified with interpretable coefficient analysis
- ✅ Professional deployment recommendation based on quantitative criteria
- ✅ Well-commented, reproducible code

## Hints

- `glmnet` requires matrix input, not data frames
- Always standardize features when using regularization
- The regularization path should show all coefficients shrinking but never reaching exactly zero
- Your Ridge model should show substantially better train-test performance than OLS
- If testing RMSE is still > $10K, consider tuning or feature engineering

## Common Pitfalls to Avoid

- Forgetting to use `model.matrix()` for predictor matrix creation
- Not standardizing features (leads to unfair penalization)
- Using wrong alpha value (0 for Ridge, 1 for LASSO)
- Comparing models without consistent train-test splits
- Making deployment recommendations without clear quantitative justification

## Time Check

- 5 min: Data preparation
- 10 min: Ridge implementation and regularization path
- 10 min: Cross-validation
- 10 min: Performance evaluation and comparison
- 5 min: Coefficient analysis
- 5 min: Business recommendation

**Total: 40 minutes (with 5 minutes buffer)**

## Extension (If Time Permits)

- Try different lambda values manually and observe the impact
- Investigate which features are shrunk most aggressively
- Calculate prediction intervals for a few products
- Compare `lambda.min` vs `lambda.1se` performance