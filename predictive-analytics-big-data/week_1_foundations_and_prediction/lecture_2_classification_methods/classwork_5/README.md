# CLASSWORK 5: COMPREHENSIVE MODEL DIAGNOSTICS

**Course:** Predictive Analytics & Big Data  
**Lecture:** 2 - Advanced Regression & Regularization  
**Topic:** Model Validation and Diagnostics  
**Duration:** 25 minutes

---

## 📁 FILES IN THIS FOLDER

```
classwork_5_diagnostics/
├── README.md           # This file
├── INSTRUCTIONS.md     # Detailed assignment instructions
└── template.Rmd        # Student template to complete
```

**Note:** This classwork uses the model and data from Classwork 4. Ensure you have completed Classwork 4 first.

---

## 🎯 LEARNING OBJECTIVES

1. Perform comprehensive residual analysis on regularized models
2. Identify influential observations using Cook's distance
3. Quantify prediction uncertainty with bootstrap intervals
4. Assess coefficient stability through resampling
5. Create diagnostic dashboards for production readiness
6. Make evidence-based deployment recommendations

---

## 📊 PREREQUISITE

**You must have completed Classwork 4** which trained an elastic net model on the product pricing dataset. This classwork performs diagnostics on that trained model.

**Required from Classwork 4:**
- Trained elastic net model
- Product pricing dataset
- Optimal alpha value
- Train-test split (with seed 123)

---

## 📝 YOUR TASKS

### Task 1: Residual Analysis
- Calculate train and test residuals
- Create residual plot checking for patterns
- Assess randomness of errors

### Task 2: Assumption Checks
- Q-Q plot for normality
- Scale-location plot for constant variance
- Identify any violations

### Task 3: Influence Detection
- Calculate Cook's distance
- Identify influential observations
- Investigate problematic points

### Task 4: Prediction Intervals
- Bootstrap 100-200 models
- Calculate 95% prediction intervals
- Check coverage and width

### Task 5: Coefficient Stability
- Bootstrap coefficient estimates
- Calculate confidence intervals
- Identify stable features

### Task 6: Diagnostic Summary
- Create comprehensive dashboard
- Complete checklist
- Make deployment recommendation

---

## 🔧 TECHNICAL SETUP

### Required Packages

```r
install.packages(c("tidyverse", "glmnet", "knitr", "kableExtra", "broom"))
```

### File Structure

Ensure your folder structure looks like this:

```
your_workspace/
├── classwork_4_elastic_net/
│   └── product_pricing.csv
└── classwork_5_diagnostics/
    ├── template.Rmd  # Work here
    └── ...
```

### Loading Previous Model

The template includes code to:
1. Load data from Classwork 4
2. Recreate the train-test split (same seed)
3. Refit the elastic net model with your optimal alpha

---

## 📚 KEY CONCEPTS

### Residual Diagnostics

**Residual = Actual - Predicted**

Good residuals should:
- Show random scatter (no patterns)
- Be approximately normal
- Have constant variance
- Contain few extreme outliers

### Cook's Distance

Measures influence of each observation:
- D > 4/n suggests influential point
- High influence ≠ automatic removal
- Investigate: data error or real edge case?

### Prediction Intervals

Quantify uncertainty:
- 95% PI should contain ~95% of new observations
- Width indicates prediction reliability
- Business must accept uncertainty level

### Coefficient Stability

Bootstrap confidence intervals show:
- Which features have robust effects
- Which coefficients are uncertain
- Whether key business drivers are stable

---

## ✅ DELIVERABLES

Submit completed `template.Rmd` with:

1. **All code chunks executed**
2. **Six main visualizations:**
   - Residual plot
   - Q-Q plot
   - Scale-location plot
   - Cook's distance
   - Prediction intervals
   - Coefficient stability
3. **Two summary tables:**
   - Diagnostic dashboard
   - Completed checklist
4. **Written components:**
   - Interpretation after each visualization (2-3 sentences)
   - Model strengths (2-3 sentences)
   - Model limitations (2-3 sentences)
   - Go/no-go recommendation (2-3 paragraphs)

---

## 🎓 EVALUATION RUBRIC

| Category | Weight | Criteria |
|----------|--------|----------|
| **Code Quality** | 20% | Correct calculations, proper bootstrap, clear comments |
| **Completeness** | 30% | All tasks done, visualizations labeled, metrics calculated |
| **Interpretation** | 30% | Clear explanations, honest limitations, evidence-based |
| **Recommendation** | 20% | Clear decision, justified by diagnostics, realistic risks |

---

## 💡 TIPS FOR SUCCESS

### Residual Plots
- Look for patterns (curved trend = missing features)
- Check for fan shape (heteroscedasticity)
- Identify extreme points (potential outliers)

### Q-Q Plot
- Points on line = good
- S-curve = skewness
- Deviations at tails = heavy/light tails

### Cook's Distance
- Most points should be well below threshold
- Investigate high-influence points individually
- Don't automatically remove them

### Bootstrap
- Set seed for reproducibility
- Use at least 100 iterations (200+ better)
- Monitor progress with periodic status messages

### Deployment Decision
- Be honest about limitations
- Consider business context
- Recommend monitoring plan

---

## ⚠️ COMMON PITFALLS

1. **Using training residuals:** Always diagnose on test set
2. **Too few bootstrap iterations:** Need 100+ minimum
3. **Ignoring context:** Technical metrics must serve business needs
4. **Auto-removing outliers:** Investigate first, don't blindly delete
5. **Overly optimistic:** Be honest about model weaknesses

---

## 🚀 EXTENSION CHALLENGES

For students who finish early:

1. **Segmented diagnostics:** Analyze separately for low/mid/high price ranges
2. **Feature stability:** What % of bootstrap samples select each feature?
3. **Calibration analysis:** Create binned predicted vs. actual plot
4. **Sensitivity analysis:** Refit without influential points; assess impact
5. **ROI calculation:** Estimate business value vs. prediction uncertainty

---

## 📖 REFERENCE MATERIALS

- **Lecture slides:** Batch 5, slides 121-150
- **Classwork 4:** Model training and elastic net selection
- **R documentation:**
  - `?predict.cv.glmnet`
  - `?quantile`
  - `?qqnorm`
- **Statistical concepts:**
  - Cook's distance interpretation
  - Bootstrap confidence intervals
  - Prediction vs. confidence intervals

---

## 🎯 SUCCESS CRITERIA

By the end, you should:

- ✅ Understand whether model assumptions are satisfied
- ✅ Know which observations are influential and why
- ✅ Quantify prediction uncertainty
- ✅ Assess which features have stable effects
- ✅ Make an informed deployment decision
- ✅ Identify what monitoring is needed

---

## ❓ GETTING HELP

- Review lecture slides (Batch 5)
- Check INSTRUCTIONS.md for detailed guidance
- Consult template comments for hints
- Use `?function_name` for R documentation
- Ask instructor during office hours

---

## 📧 SUBMISSION

Submit your completed `template.Rmd` file through the course platform by the deadline.

**File naming:** `classwork5_lastname_firstname.Rmd`

---

**Remember:** The goal is not perfect diagnostics, but honest assessment of model readiness for deployment. Being transparent about limitations is a professional strength, not a weakness.

Good luck! 🎯
