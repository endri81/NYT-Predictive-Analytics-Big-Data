# Classwork 2A: Diagnosing Overfitting and Multicollinearity

**Time Allocation:** 30-40 minutes

## Business Context

You are a data scientist at **TechMart**, an e-commerce company with 50,000 products. The pricing team has asked you to build a predictive model for optimal product pricing. A previous analyst built a model using all available features, but it failed catastrophically in production—recommending $2 prices for $200 products and vice versa.

Your manager has asked you to diagnose what went wrong before the team attempts a new model.

## Dataset Description

**File:** `product_features_extended.csv`

**Observations:** 400 products
**Features:** 75 predictor variables + 1 target variable

**Target Variable:**
- `optimal_price`: The price that maximizes profit for each product (in $K)

**Feature Categories:**
1. **Historical Sales (15 features):** sales_7d, sales_30d, sales_90d, etc.
2. **Competitor Pricing (10 features):** competitor_price_1 through competitor_price_10
3. **Inventory Metrics (10 features):** inventory_level, days_in_stock, reorder_point, etc.
4. **Customer Metrics (15 features):** rating_avg, num_reviews, return_rate, etc.
5. **Product Attributes (10 features):** product_age_days, category_rank, brand_strength, etc.
6. **Seasonality (5 features):** seasonality_index, trend_factor, holiday_flag, etc.
7. **Marketing (10 features):** ad_spend, email_clicks, social_engagement, etc.

**Known Issue:** Many features within categories are highly correlated (e.g., sales_7d and sales_30d).

## Your Tasks

### Part 1: Initial Model Fitting (10 minutes)

1. Load the data and examine its structure
2. Split the data 70% training, 30% testing (use `set.seed(123)`)
3. Fit a linear regression model using ALL 75 features
4. Calculate performance metrics for both training and testing sets:
   - RMSE (Root Mean Squared Error)
   - R² (Coefficient of Determination)
   - MAE (Mean Absolute Error)

### Part 2: Overfitting Diagnosis (10 minutes)

5. Create a 2-panel plot showing:
   - Panel 1: Actual vs Predicted prices for training data
   - Panel 2: Actual vs Predicted prices for testing data
   - Include a diagonal reference line (perfect predictions)

6. Create a bar chart comparing training vs testing performance metrics

7. Calculate the performance degradation:
   - RMSE increase from training to testing (%)
   - R² decrease from training to testing (absolute difference)

### Part 3: Multicollinearity Analysis (10 minutes)

8. Compute the correlation matrix for all 75 features

9. Identify feature pairs with correlation > 0.85

10. Create a correlation heatmap for the first 20 features

11. Calculate Variance Inflation Factors (VIF) for the first 15 features
    - Use the `car` package: `vif(model)`
    - Identify features with VIF > 10 (problematic multicollinearity)

### Part 4: Professional Communication (10 minutes)

12. Write a brief memo (150-200 words) to your VP of Pricing addressing:
    - **Problem Statement:** What went wrong with the model?
    - **Evidence:** Specific metrics demonstrating overfitting
    - **Root Causes:** Why did this happen? (mention sample size, feature count, correlation)
    - **Business Impact:** What could go wrong if this model deploys?
    - **Recommendation:** What approach should the team take next? (preview: regularization)

## Deliverables

1. Completed `student_workspace.Rmd` with all code and outputs
2. Professional memo as a text block in your Rmd file
3. Knitted HTML report showing all visualizations and diagnostics

## Success Criteria

- ✅ Correct train/test split with reproducible seed
- ✅ Accurate calculation of all performance metrics
- ✅ Clear visualizations showing overfitting pattern
- ✅ Identification of highly correlated features
- ✅ Professional memo with business-focused language
- ✅ Code is well-commented and reproducible

## Hints

- The performance gap between training and testing should be substantial
- You should find many feature pairs with correlation > 0.90
- VIF values > 10 indicate problematic multicollinearity
- Your memo should avoid jargon—write for a business audience

## Submission

Save your completed `student_workspace.Rmd` and knitted HTML in the classwork folder.

**Time Check:** Aim to complete Parts 1-3 in first 30 minutes, leaving 10 minutes for the memo.