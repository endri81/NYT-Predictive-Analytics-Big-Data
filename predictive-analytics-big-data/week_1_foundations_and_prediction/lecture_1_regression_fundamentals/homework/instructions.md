# Homework 1: Complete Regression Analysis

**Due:** Before Lecture 2 (November 8, 2025)  
**Points:** 100  
**Format:** R Markdown report rendered to HTML or PDF

## Overview

You will perform a complete regression analysis on a messy retail dataset. This assignment integrates all concepts from Lecture 1: model building, interpretation, diagnostics, remediation, and business communication.

## Learning Objectives

- Conduct exploratory data analysis
- Build and refine regression models
- Perform comprehensive diagnostics
- Address assumption violations
- Communicate findings to business stakeholders

## Dataset

**File:** `data/retail_sales_messy.csv`

**Context:** A retail company wants to understand drivers of monthly sales across 150 stores. They have data on:

- `sales`: Monthly sales revenue ($K)
- `advertising_spend`: Monthly advertising budget ($K)
- `store_size`: Store square footage (sq ft)
- `competitor_distance`: Distance to nearest competitor (miles)
- `staff_count`: Number of employees
- `region`: Geographic region (categorical: North, South, East, West)

**Warning:** This dataset has issues (outliers, non-linearity, etc.). Part of your job is to detect and address them.

## Required Sections

### 1. Exploratory Data Analysis (15 points)

- Load and examine the data structure
- Summary statistics for all variables
- Visualize distributions (histograms, boxplots)
- Create scatterplots: sales vs. each predictor
- Check for missing values
- Preliminary observations about relationships

### 2. Initial Model Building (20 points)

- Fit a multiple regression model with all predictors
- Present model summary output
- Interpret coefficients (using "holding constant" language)
- Report R-squared and interpret
- Make predictions for 3 sample scenarios

### 3. Model Diagnostics (25 points)

**Check all four assumptions:**

a. **Linearity:** Residuals vs. fitted plot, interpretation

b. **Independence:** Durbin-Watson test, interpretation

c. **Normality:** Q-Q plot, interpretation

d. **Homoscedasticity:** Scale-location plot, interpretation

**Additional checks:**

e. **Multicollinearity:** Calculate and interpret VIF

f. **Outliers:** Identify using standardized residuals

g. **Leverage:** Identify high-leverage points

h. **Influence:** Calculate Cook's distance, identify influential points

**Document all violations found.**

### 4. Remedial Measures (20 points)

For each violation identified:

- Explain why it's a problem
- Propose a solution (transformation, removal, different model)
- Implement the solution
- Show that the problem is resolved

**Refit your model** incorporating fixes.

**Re-run diagnostics** on the improved model.

### 5. Model Validation (10 points)

- Split data: 80% training, 20% test
- Fit model on training data
- Predict on test data
- Calculate test set RMSE and R-squared
- Compare to training performance
- Discuss: Is the model overfitting?

### 6. Executive Summary (10 points)

Write a 2-page (maximum) executive summary for the retail company CEO. Include:

- **Business context:** What question are we answering?
- **Key findings:** Which factors drive sales? (non-technical language)
- **Recommendations:** What actions should the company take?
- **Confidence level:** How certain are we? What are the limitations?
- **One visualization:** Include one compelling chart

**Tone:** Professional, accessible to non-technical audience.

**No code or statistical jargon in this section.**

## Submission Requirements

**File structure:**
```
homework_1_[YourName]/
├── homework_report.Rmd
├── homework_report.html (or .pdf)
├── executive_summary.pdf (separate document)
└── data/
    └── retail_sales_messy.csv
```

**Report must include:**
- Your name and date
- Table of contents
- All code visible (echo = TRUE)
- Clear section headers
- Inline comments explaining your reasoning

## Grading Rubric

| Component | Points | Criteria |
|-----------|--------|----------|
| EDA | 15 | Thorough exploration, appropriate visualizations |
| Initial Model | 20 | Correct syntax, proper interpretation |
| Diagnostics | 25 | All checks performed, violations identified |
| Remediation | 20 | Appropriate fixes, successful resolution |
| Validation | 10 | Proper train/test split, honest assessment |
| Executive Summary | 10 | Clear, actionable, appropriate for audience |
| **Total** | **100** | |

**Deductions:**
- Late submission: -10 points per day
- Code doesn't run: -20 points
- Missing sections: -10 points per section

## Tips for Success

1. **Start early:** This is comprehensive and takes time

2. **Use the checklist:** Follow the regression diagnostic checklist from lecture

3. **Show your work:** Even if a diagnostic looks good, show the output

4. **Explain your thinking:** Why did you choose this transformation? Why remove this outlier?

5. **Be honest:** If something doesn't work, say so and explain why

6. **Proofread:** The executive summary should be polished

## Common Pitfalls to Avoid

- Fitting a model without EDA
- Ignoring diagnostic violations
- Removing outliers without justification
- Using technical jargon in executive summary
- Not checking if remedies actually worked
- Forgetting to validate on test data

## Getting Help

- **Office hours:** [Schedule TBD]
- **Discussion forum:** Post questions (no code sharing)
- **Lecture materials:** All code is provided and reproducible

## Academic Integrity

This is an individual assignment. You may:
- Discuss general concepts with classmates
- Use course materials and lecture code
- Consult R documentation and textbooks

You may NOT:
- Share code with classmates
- Copy code from online sources without citation
- Submit work that is not your own

**Violations will result in zero credit and disciplinary action.**