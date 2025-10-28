# CLASSWORK 6: SYSTEMATIC MODEL COMPARISON

**Course:** Predictive Analytics & Big Data  
**Lecture:** 2 - Advanced Regression & Regularization  
**Topic:** Model Comparison and Selection  
**Duration:** 25 minutes

---

## 🎯 LEARNING OBJECTIVES

1. Train multiple models with consistent methodology
2. Compare models using statistical tests
3. Calculate and interpret information criteria (AIC/BIC)
4. Visualize performance differences across models
5. Conduct cost-benefit analysis
6. Make evidence-based model selection decisions

---

## 📝 YOUR TASKS

### Task 1: Train All Models (8 minutes)
Train four models using the same 10-fold CV:
- Linear regression (baseline)
- Ridge regression
- LASSO regression
- Elastic net

### Task 2: Performance Comparison (4 minutes)
Calculate for each model:
- Train RMSE
- CV RMSE
- Test RMSE, MAE, R²
- Number of selected features

### Task 3: Statistical Testing (4 minutes)
- Perform paired t-tests between models
- Assess statistical significance
- Interpret p-values

### Task 4: Visualizations (3 minutes)
Create:
- CV RMSE boxplots
- Predicted vs actual scatter plots
- Error distribution plots

### Task 5: Information Criteria (2 minutes)
- Calculate AIC and BIC for each model
- Compare and rank models

### Task 6: Cost-Benefit Analysis (2 minutes)
- Estimate 3-year costs
- Factor in development and maintenance
- Calculate net benefit

### Task 7: Final Selection (2 minutes)
- Create scorecard
- Write justification (3-4 paragraphs)
- Make recommendation

---

## 📊 DELIVERABLES

Submit completed `template.Rmd` containing:

1. **Code:** All four models trained with same CV folds
2. **Tables:**
   - Performance comparison
   - Feature counts
   - Statistical test results
   - Information criteria
   - Cost-benefit analysis
   - Selection scorecard
3. **Visualizations:**
   - CV RMSE distributions
   - Prediction scatter plots
   - Error distributions
4. **Narrative:**
   - Model recommendation (3-4 paragraphs)
   - Justification of selection
   - Discussion of trade-offs

---

## 🔧 REQUIRED PACKAGES

```r
install.packages(c("tidyverse", "glmnet", "caret", "knitr", "kableExtra"))
```

---

## 💡 KEY CONCEPTS

### Fair Comparison

**Critical requirements:**
- Same train-test split
- Same CV folds for all models
- Consistent performance metrics
- Same random seed

### Statistical vs Practical Significance

**Statistical:** p < 0.05 (difference is real)  
**Practical:** Difference matters for business

A 0.5% improvement might be:
- Statistically insignificant (p > 0.05)
- Worth millions at scale

### Model Selection Criteria

Balance multiple factors:
- **Performance:** Test RMSE, R²
- **Complexity:** Number of features
- **Stability:** CV variance
- **Cost:** Development, maintenance
- **Interpretability:** Business needs
- **Speed:** Training and prediction time

---

## ⚠️ COMMON MISTAKES

1. **Different data splits:** Using different train/test for each model
2. **Different CV folds:** Not using consistent folds
3. **Overfitting to CV:** Choosing model that performs best on CV set
4. **Ignoring practical significance:** Focusing only on p-values
5. **Forgetting business context:** Optimizing wrong metric

---

## 🎓 EVALUATION RUBRIC

| Category | Weight | Criteria |
|----------|--------|----------|
| **Fair Comparison** | 25% | Same CV folds, consistent methodology |
| **Analysis Completeness** | 30% | All models trained, all metrics calculated |
| **Statistical Rigor** | 20% | Correct tests, proper interpretation |
| **Recommendation Quality** | 25% | Clear justification, evidence-based, considers trade-offs |

---

## 📚 TIPS FOR SUCCESS

### Training Models
```r
# Use same train_control for ALL models
train_control <- trainControl(
  method = "cv",
  number = 10,
  savePredictions = "final"
)

# Then train each model with this control
model1 <- train(..., trControl = train_control)
model2 <- train(..., trControl = train_control)
```

### Paired t-Test
```r
# Extract CV fold RMSE for each model
model1_cv <- model1$resample$RMSE
model2_cv <- model2$resample$RMSE

# Paired test (same folds)
t.test(model1_cv, model2_cv, paired = TRUE)
```

### Scorecard Approach
Assign points (4=best, 1=worst) for each criterion, then weight by importance.

---

## 🚀 EXTENSION CHALLENGES

1. **Ensemble:** Create weighted average of top models
2. **Sensitivity analysis:** How does split ratio affect ranking?
3. **Nested CV:** Implement outer loop for hyperparameter tuning
4. **Bootstrap comparison:** Compare stability of coefficient estimates
5. **Domain-specific metrics:** Create custom business metric

---

## ❓ KEY QUESTIONS TO ANSWER

1. **Which model has best test performance?**
2. **Are differences statistically significant?**
3. **Is improvement practically meaningful?**
4. **What are the trade-offs?**
5. **Which model would you deploy and why?**

---

Good luck! Remember: The best model on paper isn't always the best model for production. 🎯
