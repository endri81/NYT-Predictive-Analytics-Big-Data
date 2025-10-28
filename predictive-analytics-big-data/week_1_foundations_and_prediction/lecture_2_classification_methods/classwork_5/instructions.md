# CLASSWORK 5: COMPREHENSIVE MODEL DIAGNOSTICS

**Duration:** 25 minutes  
**Prerequisites:** Completed Classwork 4 (Elastic Net Model)  
**Template:** `template.Rmd`

---

## LEARNING OBJECTIVES

By completing this classwork, you will:

1. Perform comprehensive residual analysis
2. Identify influential observations using Cook's distance
3. Calculate bootstrap prediction intervals
4. Assess coefficient stability through resampling
5. Create a diagnostic summary dashboard
6. Make evidence-based deployment recommendations

---

## YOUR TASKS

### Task 1: Residual Analysis (5 minutes)
- Calculate train and test residuals
- Create residual plot
- Check for patterns or systematic errors
- Identify outliers

### Task 2: Normality and Variance Checks (4 minutes)
- Create Q-Q plot to assess normality
- Generate scale-location plot for heteroscedasticity
- Interpret deviations from assumptions

### Task 3: Influence Analysis (5 minutes)
- Calculate Cook's distance
- Identify influential observations
- Examine characteristics of influential points
- Determine if they are data errors or valid edge cases

### Task 4: Prediction Intervals (6 minutes)
- Bootstrap 100-200 models
- Calculate 95% prediction intervals
- Visualize intervals with actual values
- Check coverage (should be ~95%)

### Task 5: Coefficient Stability (4 minutes)
- Bootstrap coefficient estimates
- Calculate 95% confidence intervals
- Identify stable vs. unstable coefficients
- Visualize top features with error bars

### Task 6: Diagnostic Summary (1 minute)
- Complete diagnostic dashboard
- Fill in checklist
- Review all metrics

---

## KEY QUESTIONS TO ANSWER

1. **Are residuals well-behaved?**
   - Random scatter or patterns?
   - Approximately normal?
   - Constant variance?

2. **Are there problematic observations?**
   - How many influential points?
   - Are they data errors or real?
   - Should they be investigated?

3. **How uncertain are predictions?**
   - What is typical prediction interval width?
   - Is coverage close to 95%?
   - Are intervals acceptable for business use?

4. **Are coefficients stable?**
   - Which features have narrow confidence intervals?
   - Which coefficients cross zero?
   - Are key business drivers stable?

5. **Should this model be deployed?**
   - Do diagnostics pass key thresholds?
   - What are the risks?
   - What monitoring is needed?

---

## DELIVERABLES

Submit completed `template.Rmd` containing:

1. **Code:** All diagnostic analyses with clear comments
2. **Visualizations:**
   - Residual plot
   - Q-Q plot
   - Scale-location plot
   - Cook's distance plot
   - Prediction intervals
   - Coefficient stability plot
3. **Tables:**
   - Diagnostic summary dashboard
   - Checklist with completed status
4. **Narrative:**
   - Interpretation of each diagnostic (2-3 sentences each)
   - Model strengths and limitations
   - Go/no-go recommendation (2-3 paragraphs)

---

## EVALUATION RUBRIC

**Code Quality (20%)**
- Correct calculation of residuals and diagnostics
- Proper bootstrap implementation
- Clear comments explaining each step

**Analysis Completeness (30%)**
- All six tasks completed
- Visualizations properly labeled
- Key metrics calculated correctly

**Interpretation (30%)**
- Clear explanation of diagnostic findings
- Honest assessment of model limitations
- Evidence-based reasoning

**Recommendation (20%)**
- Clear go/no-go decision
- Justification tied to diagnostic results
- Realistic assessment of deployment risks

---

## HINTS

### Residual Calculations
```r
predictions <- predict(model, X_test, s = "lambda.min")
residuals <- y_test - predictions
```

### Bootstrap Pattern
```r
n_boot <- 100
results <- matrix(NA, n_test, n_boot)

for (b in 1:n_boot) {
  boot_idx <- sample(1:nrow(X_train), replace = TRUE)
  # ... fit and predict
  results[, b] <- predictions
}

# Quantiles for intervals
lower <- apply(results, 1, quantile, 0.025)
upper <- apply(results, 1, quantile, 0.975)
```

### Cook's Distance Approximation
```r
# Standardized residuals
std_resid <- residuals / sd(residuals)

# Leverage approximation
leverage <- rowSums(X_train^2) / sum(X_train^2)

# Cook's D
cooks_d <- (std_resid^2 / p) * (leverage / (1 - leverage))
```

---

## COMMON MISTAKES TO AVOID

1. **Using train residuals for diagnostics:** Always use test set
2. **Too few bootstrap iterations:** Minimum 100, prefer 200-1000
3. **Ignoring influential points:** Must investigate, don't auto-remove
4. **Overstating certainty:** Be honest about model limitations
5. **Forgetting business context:** Technical metrics must serve decisions

---

## DIAGNOSTIC THRESHOLDS

**General guidelines (adjust for your context):**

- **RMSE:** <10% of mean price is good
- **R²:** >0.80 is strong for real-world data
- **Max residual:** <3× RMSE
- **% large residuals:** <5% beyond 2σ
- **Influential points:** <5% of training data
- **PI coverage:** 93-97% (target 95%)
- **PI width:** Should align with business tolerance

**Remember:** These are guidelines, not hard rules. Business requirements determine acceptability.

---

## EXTENSION CHALLENGES

If you finish early:

1. **Segment analysis:** Check diagnostics separately for low/mid/high price ranges
2. **Feature importance stability:** Which features are consistently selected across bootstrap samples?
3. **Calibration plot:** Create binned predicted vs. actual comparison
4. **Sensitivity analysis:** Refit without top 3 influential points; how much do results change?

---

## DEPLOYMENT CONSIDERATIONS

**Your recommendation should address:**

1. **Performance:** Is accuracy acceptable for intended use?
2. **Reliability:** Are assumptions reasonably satisfied?
3. **Uncertainty:** Are prediction intervals acceptable?
4. **Stability:** Are coefficients robust?
5. **Monitoring:** What metrics should track in production?
6. **Retraining:** What triggers model refresh?
7. **Limitations:** What are known failure modes?

---

## RESOURCES

- Lecture 2, Batch 5: Slides 121-150
- Classwork 4 for model training
- R documentation: `?glmnet`, `?predict.cv.glmnet`
- Bootstrap references: Efron & Tibshirani

---

Good luck! This diagnostic analysis is critical for responsible model deployment. 🎯
