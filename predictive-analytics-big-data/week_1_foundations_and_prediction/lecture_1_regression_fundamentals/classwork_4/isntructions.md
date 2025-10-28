# Classwork 4: Model Selection & Comparison

**Duration:** 25 minutes  
**Collaboration:** Work individually or in pairs

## Learning Objectives

- Compare nested models using F-tests
- Apply information criteria (AIC, BIC) for model selection
- Implement k-fold cross-validation
- Understand bias-variance tradeoff
- Make principled model selection decisions

## Dataset

**File:** `data/housing_prices.csv`

**Context:** A real estate agency wants to build a model to estimate house prices. They've collected data on 300 recent sales with 8 potential predictors.

**Variables:**
- `price`: Sale price ($K) - **TARGET**
- `sqft`: Square footage
- `bedrooms`: Number of bedrooms
- `bathrooms`: Number of bathrooms
- `age`: House age (years)
- `lot_size`: Lot size (acres)
- `garage_spaces`: Garage capacity
- `distance_downtown`: Distance to downtown (miles)
- `school_rating`: Local school rating (1-10)

## Tasks

### Task 1: Fit Candidate Models (5 minutes)

Create 5 candidate models of increasing complexity:

**Model 1:** `price ~ sqft` (baseline)

**Model 2:** `price ~ sqft + bedrooms + bathrooms`

**Model 3:** `price ~ sqft + bedrooms + bathrooms + age + lot_size`

**Model 4:** `price ~ sqft + bedrooms + bathrooms + age + lot_size + garage_spaces + distance_downtown`

**Model 5:** All 8 predictors (full model)

For each model, extract:
- R²
- Adjusted R²
- AIC
- BIC

### Task 2: Nested F-Tests (5 minutes)

Perform nested F-tests comparing:
- Model 1 vs. Model 2
- Model 2 vs. Model 3
- Model 3 vs. Model 4
- Model 4 vs. Model 5

For each comparison:
- Report F-statistic and p-value
- Decide: Is the more complex model justified?

### Task 3: Information Criteria (5 minutes)

Create a comparison table showing all models with:
- Number of predictors
- R²
- Adjusted R²
- AIC
- BIC

Identify:
- Which model has lowest AIC?
- Which model has lowest BIC?
- Do they agree?

### Task 4: Cross-Validation (7 minutes)

Perform 10-fold cross-validation on all 5 models.

For each model, calculate:
- Mean CV RMSE
- Standard deviation of CV RMSE
- Mean CV R²

Create a boxplot showing CV RMSE distribution for all models.

### Task 5: Final Selection & Justification (3 minutes)

Based on all evidence:

1. Select your final model
2. Write a 3-4 sentence justification explaining:
   - Why you chose this model
   - What criteria were most important
   - What trade-offs you considered

## Bonus Challenges (Optional)

1. **Overfitting check:** Split data 70/30, fit all models on training set, compare training RMSE vs. test RMSE. Which models overfit most?

2. **Interaction testing:** Does the effect of `sqft` depend on `bedrooms`? Add interaction term and test.

3. **Polynomial features:** Try adding `I(sqft^2)`. Does it improve fit without overfitting?

## Deliverable

Completed R Markdown report with:
- Model comparison table
- F-test results
- CV performance visualization
- Final model selection with justification

## Discussion Questions

1. If AIC and BIC disagree, which would you trust and why?

2. When might you choose a simpler model even if a complex model has better CV performance?

3. How would your model selection process change if you had 10,000 observations instead of 300?