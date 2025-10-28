# Classwork 3: Advanced Interpretation

**Duration:** 25 minutes  
**Collaboration:** Work individually or in pairs

## Learning Objectives

- Create and interpret partial regression plots
- Calculate standardized coefficients for comparison
- Distinguish statistical from practical significance
- Use confidence and prediction intervals appropriately
- Communicate effect sizes to business audiences

## Dataset

**File:** `data/store_performance.csv`

**Context:** A retail chain has 200 stores. The VP of Operations wants to understand what drives quarterly profit so she can allocate resources effectively.

**Variables:**
- `profit`: Quarterly profit ($K)
- `foot_traffic`: Average daily customers
- `employee_training_hours`: Quarterly training per employee
- `local_income`: Median household income in area ($K)
- `store_age`: Years since store opened
- `parking_spaces`: Number of parking spots

## Tasks

### Task 1: Partial Regression Plots (8 minutes)

Create partial regression plots for each of the 5 predictors.

For each plot:
1. Generate the partial regression visualization
2. Verify that the slope matches the coefficient from the full model
3. Write a one-sentence interpretation

**Question:** Which predictor shows the strongest isolated relationship with profit?

### Task 2: Standardized Coefficients (6 minutes)

Calculate standardized coefficients (beta weights) for all predictors.

Create a comparison table showing:
- Raw coefficients
- Standardized coefficients
- Rank by importance

**Question:** Does the ranking change when you use standardized vs. raw coefficients? Why?

### Task 3: Effect Size Classification (5 minutes)

Classify each predictor's effect as Small, Medium, or Large using:
- Small: |β*| < 0.3
- Medium: 0.3 ≤ |β*| < 0.5
- Large: |β*| ≥ 0.5

Create a visualization showing effect sizes.

**Question:** Are any predictors statistically significant (p < 0.05) but have small effect sizes? What does this mean for the VP?

### Task 4: Prediction Scenarios (4 minutes)

For a new store with these characteristics:
- foot_traffic: 500
- employee_training_hours: 40
- local_income: 75
- store_age: 5
- parking_spaces: 50

Calculate:
1. Point prediction
2. 95% confidence interval for mean profit
3. 95% prediction interval for this specific store

**Question:** Which interval should you report to the VP? Why?

### Task 5: Executive Memo (2 minutes)

Write a brief memo (3-4 sentences) answering:

*"VP Martinez, based on your request to understand profit drivers, here's what the data shows..."*

Include:
- Which 1-2 factors matter most (with effect sizes)
- One actionable recommendation
- Appropriate uncertainty statement

## Bonus Challenges (Optional)

1. Create an "importance plot" ranking predictors by standardized coefficient with confidence intervals

2. Calculate how much profit increases if you improve the top predictor by 1 SD

3. Test whether the effect of training varies by store age (interaction)

## Submission

Save your completed Rmd and rendered HTML.

## Discussion Questions

1. Why might a variable be statistically significant but practically unimportant?

2. When would you prefer raw coefficients over standardized coefficients?

3. How would you explain prediction intervals to a non-technical executive?