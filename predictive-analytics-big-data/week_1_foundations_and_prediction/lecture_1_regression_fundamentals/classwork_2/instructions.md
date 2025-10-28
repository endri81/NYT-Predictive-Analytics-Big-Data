# Classwork 2: Multiple Regression Model Building

**Duration:** 20 minutes  
**Collaboration:** Work in pairs or small groups

## Learning Objectives

- Fit and interpret multiple regression models in R
- Make predictions for specific scenarios
- Communicate results to business stakeholders
- Understand limitations of regression models

## Dataset

Continue using the marketing data from Lecture 1 with all three channels:
  - `google_spend`
- `facebook_spend`
- `email_spend`
- `sales`

## Tasks

### Task 1: Fit Multiple Regression Model (5 minutes)

Build a model predicting sales from all three marketing channels:
  ```r
model_full <- lm(sales ~ google_spend + facebook_spend + email_spend, 
                 data = marketing_data)
```

Extract and interpret:
  - Coefficients
- R-squared
- Residual standard error

**Question:** Which channel has the highest return per dollar spent?
  
  ### Task 2: Coefficient Interpretation (5 minutes)
  
  Write a 2-3 sentence interpretation of EACH coefficient for the CMO.

Use the template:
  > "Holding [other variables] constant, a $1K increase in [channel] is associated with $XXK [increase/decrease] in sales, on average."

**Critical:** Include the "holding constant" phrase for each interpretation.

### Task 3: Budget Scenario Analysis (6 minutes)

Create a data frame with 5 different budget scenarios:
  
  1. **Current baseline:** $30K Google, $25K Facebook, $15K Email
2. **Google heavy:** $50K Google, $20K Facebook, $10K Email
3. **Facebook heavy:** $20K Google, $50K Facebook, $10K Email
4. **Email heavy:** $20K Google, $20K Facebook, $40K Email
5. **Your optimal:** Design your own allocation (same $80K total)

For each scenario:
  - Predict sales using `predict()`
- Calculate expected ROI
- Compare total spend vs. predicted return

### Task 4: Business Recommendation (3 minutes)

Based on your analysis:
  
  1. Which scenario maximizes sales?
  2. Which maximizes ROI (return per dollar)?
  3. What would you recommend to the CMO for Q4?
  4. What confidence interval should you communicate?
  
  Write a brief executive summary (3-4 sentences).

### Task 5: Model Limitations (1 minute)

List 3-5 factors that affect sales but are NOT in your model.

Examples to consider:
  - Time/seasonality
- Competitor actions
- Economic conditions
- Brand awareness
- Product quality

## Bonus Challenges (Optional)

1. **Interaction effects:** Try adding `google_spend:facebook_spend` to your model. Does the interaction term improve fit?
  
  2. **Visual comparison:** Create a bar chart comparing predicted sales across your 5 scenarios.

3. **Sensitivity analysis:** How much would Google coefficient need to change to alter your recommendation?
  
  ## Discussion Questions
  
  1. Would you trust this model to make a $1M budget decision? Why or why not?
  
  2. How would you validate this model before presenting to executives?
  
  3. What additional data would you want to collect?
  
  ## Deliverable
  
  Save your completed analysis with:
  - Model summary output
- Scenario comparison table
- Executive summary recommendation
- Discussion of limitations


