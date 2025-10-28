# Classwork 3: LASSO Feature Selection

**Time Allocation:** 30-40 minutes

## Business Context

You are continuing your pricing model development for **TechMart**. In Classwork 1, you diagnosed severe overfitting. In Classwork 2, you stabilized the model using Ridge regression. Now, the VP of Pricing has a new requirement:

*"The data engineering team says collecting and maintaining all 75 features costs $500K annually. Can you build an equally good model with fewer features to reduce costs?"*

Your task is to implement LASSO regression for automatic feature selection, compare it with Ridge, and provide a cost-benefit recommendation.

## Dataset Description

**File:** `product_features_extended.csv` (same dataset from Classworks 1 & 2)

**Observations:** 400 products  
**Features:** 75 predictor variables + 1 target variable

**Cost Context:**
- Each feature costs approximately $6,700/year to collect and maintain
- Reducing features by 50% could save $250K annually
- Model performance cannot degrade significantly

## Your Tasks

### Part 1: LASSO Implementation (10 minutes)

1. Load data and create the same train-test split from previous classworks (`set.seed(123)`)

2. Prepare data in matrix format for `glmnet` (you may have this from Classwork 2)

3. Fit LASSO regression using `glmnet()`:
   - Set `alpha = 1` for LASSO (L1 penalty)
   - Set `standardize = TRUE`

4. Examine the LASSO model object:
   - How many lambda values were tested?
   - Plot the regularization path using `plot(model, xvar = "lambda")`
   - Observe coefficients dropping to exactly zero

5. Perform 10-fold cross-validation using `cv.glmnet()`:
   - Set `alpha = 1`
   - Set `nfolds = 10`
   - Use `set.seed(42)` for reproducibility

6. Plot cross-validation results:
   - Note the top axis showing number of features selected
   - Identify `lambda.min` and `lambda.1se`

### Part 2: Feature Selection Analysis (10 minutes)

7. Extract coefficients at optimal lambda (`lambda.min`):
   - Which features were selected (non-zero coefficients)?
   - How many features were eliminated?
   - Calculate percentage of features retained

8. Create a table of selected features with their coefficients:
   - Sort by absolute coefficient magnitude
   - Display top 15 selected features

9. Analyze which feature categories were preserved:
   - How many historical sales features selected?
   - How many competitor pricing features selected?
   - How many customer metrics selected?
   - What does this tell you about feature importance?

10. Visualize feature selection:
    - Create a bar chart showing all 75 features
    - Color-code: selected vs eliminated
    - Show coefficient magnitudes for selected features

### Part 3: Performance Comparison (10 minutes)

11. Generate predictions using LASSO at `lambda.min`:
    - Training set predictions
    - Testing set predictions

12. Calculate LASSO performance metrics:
    - Training and testing RMSE
    - Training and testing R²
    - Train-test gap

13. Create a comprehensive comparison table:

| Model | Features Used | Train RMSE | Test RMSE | Test R² | Train-Test Gap |
|-------|---------------|------------|-----------|---------|----------------|
| OLS | 75 | [value] | [value] | [value] | [value] |
| Ridge | 75 (shrunk) | [value] | [value] | [value] | [value] |
| LASSO | [X selected] | [value] | [value] | [value] | [value] |

14. Visualize the comparison:
    - Create actual vs predicted plots for LASSO (train and test)
    - Create side-by-side performance bar charts (all three models)

15. Compare regularization paths:
    - Plot Ridge and LASSO paths side-by-side
    - Highlight the key difference (Ridge approaches zero, LASSO hits zero)

### Part 4: Cost-Benefit Analysis (5 minutes)

16. Calculate cost savings from feature reduction:
    - Features eliminated: [75 - selected features]
    - Annual cost per feature: $6,700
    - Total annual savings: [eliminated features × $6,700]

17. Assess performance trade-off:
    - How much did test RMSE change vs Ridge?
    - How much did test R² change vs Ridge?
    - Is the performance trade-off acceptable?

18. Calculate "cost per model quality":
    - Ridge: $500K for R² = [value]
    - LASSO: $[cost] for R² = [value]
    - Which model gives better cost-efficiency?

### Part 5: Deployment Recommendation (5 minutes)

19. Complete the following decision matrix:

**Model Selection Criteria**

| Criterion | Weight | OLS Score | Ridge Score | LASSO Score |
|-----------|--------|-----------|-------------|-------------|
| Predictive Performance (Test R²) | 40% | [0-10] | [0-10] | [0-10] |
| Cost Efficiency (fewer features) | 30% | [0-10] | [0-10] | [0-10] |
| Interpretability (simplicity) | 20% | [0-10] | [0-10] | [0-10] |
| Deployment Speed (computation) | 10% | [0-10] | [0-10] | [0-10] |
| **Weighted Total** | 100% | [total] | [total] | [total] |

Scoring guide: 0=Poor, 5=Average, 10=Excellent

20. Write your recommendation (200-250 words):

**TO:** VP of Pricing  
**FROM:** [Your Name], Data Science Team  
**RE:** Regularization Model Selection & Deployment Recommendation

**Recommended Model:** [OLS / Ridge / LASSO]

**Performance Summary:**  
[2-3 sentences on predictive performance across models]

**Cost-Benefit Analysis:**  
[2-3 sentences on feature costs and savings with LASSO]

**Justification:**  
[3-4 sentences explaining why your recommended model is optimal given business constraints]

**Implementation Plan:**  
[2-3 sentences on next steps for deployment]

**Risks & Mitigation:**  
[2 sentences on potential concerns and how to address them]

## Deliverables

1. Completed `student_workspace.Rmd` with all code, visualizations, and analysis
2. Comprehensive three-model comparison table
3. Cost-benefit analysis with specific dollar amounts
4. Decision matrix with weighted scores
5. Professional recommendation memo
6. Knitted HTML report

## Success Criteria

- ✅ Correct LASSO implementation with cross-validation
- ✅ Accurate identification of selected features
- ✅ Clear visualizations showing feature selection and performance
- ✅ Quantitative cost-benefit analysis with specific savings
- ✅ Professional recommendation justified by data
- ✅ Three-way comparison (OLS vs Ridge vs LASSO) complete
- ✅ Well-commented, reproducible code

## Hints

- LASSO should select between 10-25 features depending on optimal lambda
- Test R² for LASSO should be within 0.02-0.03 of Ridge
- Cost savings should be substantial ($200K-400K annually)
- LASSO often provides best balance of performance and interpretability
- The regularization path plot should clearly show coefficients hitting zero

## Common Pitfalls to Avoid

- Forgetting to use same train-test split as previous classworks (breaks comparison)
- Not standardizing features (unfair penalization)
- Comparing models without consistent evaluation metrics
- Making deployment recommendation without quantitative justification
- Ignoring business context (cost savings) in analysis

## Time Check

- 10 min: LASSO implementation and cross-validation
- 10 min: Feature selection analysis
- 10 min: Performance comparison with OLS and Ridge
- 5 min: Cost-benefit analysis
- 5 min: Recommendation memo

**Total: 40 minutes**

## Extension (If Time Permits)

- Compare `lambda.min` vs `lambda.1se` feature selection
- Investigate which correlated features LASSO chose to keep vs eliminate
- Analyze coefficient stability across different lambda values
- Calculate confidence intervals for cost savings estimate