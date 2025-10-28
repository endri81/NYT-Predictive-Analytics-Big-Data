# CLASSWORK 4: ELASTIC NET MODEL SELECTION

**Duration:** 25 minutes  
**Dataset:** `product_pricing.csv`  
**Template:** `template.Rmd`

---

## LEARNING OBJECTIVES

By completing this classwork, you will:

1. Implement elastic net regression with systematic alpha tuning
2. Use cross-validation to select optimal hyperparameters
3. Compare regularization methods on consistent test sets
4. Interpret feature selection and coefficient magnitudes
5. Make evidence-based model deployment recommendations

---

## DATASET DESCRIPTION

**File:** `product_pricing.csv`

**Structure:**
- 800 products (rows)
- 47 predictor features (columns)
- 1 target variable: `price` (in dollars)

**Features include:**
- Physical attributes: weight, dimensions, materials
- Product metadata: category, brand, age
- Market data: competitor prices, demand indicators
- Engineered features: interactions, ratios

**Split:**
- Training set: 560 products (70%)
- Test set: 240 products (30%)

---

## YOUR TASKS

### Task 1: Data Preparation (5 minutes)
- Load `product_pricing.csv`
- Split into 70% train, 30% test (use `set.seed(123)`)
- Examine data structure and distributions
- Check for missing values

### Task 2: Alpha Grid Search (8 minutes)
- Define alpha grid: `c(0, 0.25, 0.5, 0.75, 1.0)`
- For each alpha value:
  - Fit elastic net with 10-fold cross-validation
  - Record optimal lambda and CV RMSE
- Identify which alpha minimizes CV error

### Task 3: Model Comparison (7 minutes)
- Extract coefficients for optimal elastic net
- Compare to pure ridge (α=0) and pure LASSO (α=1)
- Calculate train RMSE, CV RMSE, and test RMSE for all three
- Count non-zero features in each model

### Task 4: Feature Analysis (3 minutes)
- Identify top 10 features by absolute coefficient magnitude
- Determine which features have positive vs. negative effects
- Note which features were eliminated (set to zero)

### Task 5: Model Recommendation (2 minutes)
- Write 2-3 paragraph justification for your model choice
- Address: accuracy, interpretability, feature count, stability
- State whether you'd recommend deployment

---

## KEY QUESTIONS TO ANSWER

1. **What is the optimal α value?**
   - Which alpha minimized cross-validation RMSE?
   - How does this compare to pure ridge or LASSO?

2. **How many features are selected?**
   - How does feature count differ across α values?
   - Is there a reasonable balance between accuracy and simplicity?

3. **Does elastic net outperform ridge and LASSO?**
   - Compare test set RMSE across all three methods
   - Is the improvement meaningful (>5% reduction)?

4. **Which features matter most?**
   - What are the strongest predictors (largest |coefficients|)?
   - Do the selected features make business sense?

5. **Would you deploy this model?**
   - Is test RMSE acceptable for production use?
   - Can stakeholders understand the selected features?
   - Are there concerning patterns in residuals?

---

## DELIVERABLES

Submit a completed `template.Rmd` file containing:

1. **Code:** All analysis steps with clear comments
2. **Tables:** Model comparison metrics
3. **Visualizations:** 
   - CV error across alpha values
   - Coefficient paths
   - Predicted vs. actual prices
   - Top features bar chart
4. **Narrative:** Model selection justification (2-3 paragraphs)

---

## EVALUATION RUBRIC

**Code Quality (25%)**
- Proper data splitting with reproducible seed
- Correct glmnet syntax for elastic net
- Appropriate cross-validation setup

**Analysis Completeness (35%)**
- Alpha grid search implemented correctly
- All three models compared on same test set
- Feature importance identified and visualized

**Interpretation (25%)**
- Clear explanation of optimal alpha selection
- Business-relevant feature interpretation
- Honest assessment of model limitations

**Communication (15%)**
- Well-formatted tables and figures
- Logical flow of analysis
- Professional model recommendation

---

## HINTS

**Data splitting:**
```r
set.seed(123)
train_idx <- sample(1:nrow(data), 0.7 * nrow(data))
train <- data[train_idx, ]
test <- data[-train_idx, ]
```

**Alpha grid search structure:**
```r
alpha_grid <- c(0, 0.25, 0.5, 0.75, 1)
cv_results <- lapply(alpha_grid, function(a) {
  cv.glmnet(X, y, alpha = a, nfolds = 10)
})
```

**Coefficient extraction:**
```r
coef(cv_model, s = "lambda.min")
```

**RMSE calculation:**
```r
sqrt(mean((actual - predicted)^2))
```

---

## COMMON MISTAKES TO AVOID

1. **Fitting on full dataset:** Always split before any modeling
2. **Inconsistent test sets:** Use same test set for all model comparisons
3. **Forgetting to scale:** glmnet standardizes automatically, but document this
4. **Overfitting to CV results:** Final evaluation must use holdout test set
5. **Ignoring business context:** Features must make sense, not just minimize error

---

## EXTENSION CHALLENGES (Optional)

If you finish early:

1. **Nested CV:** Implement outer CV loop to get honest estimate of entire pipeline
2. **Stability analysis:** Refit with different random seeds; how stable are selected features?
3. **Business metric:** Convert RMSE to percentage error for different price ranges
4. **Interaction terms:** Add engineered features; does model improve?

---

## RESOURCES

- glmnet vignette: `vignette("glmnet")`
- R documentation: `?cv.glmnet`
- Lecture slides: Batch 4, slides 91-120
