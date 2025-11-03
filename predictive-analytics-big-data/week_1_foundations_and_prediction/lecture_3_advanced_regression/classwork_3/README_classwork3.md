# Classwork 3: Regularization Practice Materials

## 📦 Package Contents

This package contains everything needed for Classwork 3 on Regularization (Ridge & LASSO Regression):

### 1. **classwork_3_regularization.Rmd** 
   - **For:** Students
   - **Contains:** 12 exercises with instructions
   - **Format:** RMarkdown with empty code chunks
   - **Purpose:** Hands-on practice with overfitting diagnosis and regularization

### 2. **classwork_3_solutions.Rmd**
   - **For:** Instructors
   - **Contains:** Complete solutions to all 12 exercises
   - **Format:** RMarkdown with full code and explanations
   - **Purpose:** Answer key and grading reference

### 3. **classwork_3_quick_reference.md**
   - **For:** Students
   - **Contains:** Cheat sheet with code patterns and tips
   - **Format:** Markdown reference guide
   - **Purpose:** Quick lookup during exercises

### 4. **README.md** (this file)
   - **For:** Everyone
   - **Contains:** Overview and instructions
   - **Purpose:** Getting started guide

---

## 🎯 Learning Objectives

By completing these exercises, students will be able to:

1. ✅ Diagnose overfitting using train/test splits
2. ✅ Detect multicollinearity using VIF
3. ✅ Implement Ridge regression with cross-validation
4. ✅ Implement LASSO regression for feature selection
5. ✅ Compare regularization methods systematically
6. ✅ Interpret coefficient paths and feature importance
7. ✅ Make data-driven business recommendations

---

## 📋 Exercise Structure

### Part 1: Overfitting Diagnosis (Exercises 1-4)
- Train/test splitting
- Building baseline OLS model
- Calculating RMSE metrics
- VIF analysis for multicollinearity

### Part 2: Ridge Regression (Exercises 5-8)
- Data preparation for glmnet
- Cross-validation for lambda
- Fitting final Ridge model
- Performance evaluation

### Part 3: LASSO Regression (Exercises 9-12)
- Cross-validation for LASSO
- Feature selection identification
- Visualization of results
- Comprehensive model comparison

### Bonus Challenges (Optional)
- Coefficient stability analysis
- Coefficient path plotting
- Business recommendation writing

---

## 💻 Technical Requirements

### Required R Packages:
```r
install.packages(c(
  "tidyverse",    # Data manipulation and visualization
  "car",          # VIF calculation
  "caret",        # Train/test splitting
  "glmnet",       # Ridge and LASSO regression
  "knitr"         # Table formatting
))
```

### System Requirements:
- R version ≥ 4.0.0
- RStudio (recommended)
- 4GB RAM minimum
- ~100MB disk space

---

## 🚀 Getting Started

### For Students:

1. **Open** `classwork_3_regularization.Rmd` in RStudio

2. **Install packages** (run once):
   ```r
   install.packages(c("tidyverse", "car", "caret", "glmnet", "knitr"))
   ```

3. **Complete exercises** in order (1-12)
   - Read instructions carefully
   - Fill in code chunks marked "YOUR CODE HERE"
   - Answer questions in comments
   - Run code frequently to check

4. **Reference** `classwork_3_quick_reference.md` when stuck
   - Contains code patterns
   - Common mistakes to avoid
   - Troubleshooting tips

5. **Knit to HTML** when finished:
   - Click "Knit" button in RStudio
   - Verify all code runs without errors
   - Check that all outputs display correctly

6. **Submit** the HTML file to Canvas

### For Instructors:

1. **Review** `classwork_3_solutions.Rmd` for answers

2. **Grading rubric** (included in solutions):
   - Part 1: 25 points
   - Part 2: 35 points
   - Part 3: 35 points
   - Bonus: +15 points
   - **Total: 100 points (115 with bonus)**

3. **Expected completion time:** 90-120 minutes

4. **Common student errors** to watch for:
   - Not setting random seed
   - Using data frames instead of matrices for glmnet
   - Forgetting lambda parameter in predict()
   - Comparing models on training instead of test data

---

## 📊 Dataset Information

**Scenario:** HomeSmart Realty housing price prediction

**Data Characteristics:**
- 500 observations (houses)
- 12 predictor variables
- 1 outcome variable (price)
- Synthetic data (generated with known relationships)
- Includes multicollinearity by design
- Contains noise to induce overfitting

**Variables:**
- `house_id` - Unique identifier
- `square_feet` - Living area in sq ft
- `bedrooms` - Number of bedrooms
- `bathrooms` - Number of bathrooms
- `lot_size` - Lot size in sq ft
- `age_years` - Age of house
- `garage_spaces` - Number of garage spaces
- `school_rating` - School district rating (1-10)
- `crime_index` - Neighborhood crime index
- `distance_downtown` - Miles to downtown
- `nearby_parks` - Number of parks within 1 mile
- `hoa_fees` - Monthly HOA fees
- `property_tax` - Annual property tax
- `price` - Sale price (TARGET)

---

## ✅ Validation Checklist

### Before Starting:
- [ ] All packages installed
- [ ] RStudio open
- [ ] Quick reference guide accessible
- [ ] Understand the business scenario

### During Exercises:
- [ ] Read each question carefully
- [ ] Check code runs without errors
- [ ] Verify outputs make sense
- [ ] Compare results to expected ranges
- [ ] Save frequently

### Before Submitting:
- [ ] All 12 exercises completed
- [ ] All questions answered
- [ ] Code chunks run successfully
- [ ] Document knits to HTML
- [ ] Graphs display correctly
- [ ] No placeholder text like "___" remains
- [ ] File size reasonable (<10MB)

---

## 🎓 Key Concepts Covered

### Overfitting
- **Definition:** Model memorizes training data, fails on new data
- **Detection:** Large train/test performance gap
- **Solution:** Regularization (Ridge/LASSO)

### Multicollinearity
- **Definition:** Predictors are highly correlated
- **Detection:** VIF > 5
- **Impact:** Unstable coefficients
- **Solution:** Ridge or LASSO regression

### Regularization
- **Purpose:** Add penalty to prevent overfitting
- **Ridge (L2):** Shrinks all coefficients, keeps all features
- **LASSO (L1):** Sets some coefficients to zero, does feature selection
- **Lambda:** Controls penalty strength (choose via CV)

---

## 📈 Expected Results

### Typical Findings:

**OLS Model:**
- Training RMSE: ~$28,000-32,000
- Test RMSE: ~$35,000-42,000
- Overfitting: 15-25%
- VIF: 2-3 variables >5

**Ridge Model:**
- Training RMSE: ~$30,000-34,000
- Test RMSE: ~$32,000-38,000
- Overfitting: 5-10%
- All 12 features retained

**LASSO Model:**
- Training RMSE: ~$30,000-34,000
- Test RMSE: ~$31,000-37,000
- Overfitting: 5-10%
- 8-10 features selected

*Note: Exact values vary with random seed*

---

## 🔧 Troubleshooting

### Common Issues:

**Issue:** "Package 'X' not found"
- **Solution:** Run `install.packages("X")`

**Issue:** "Object not found"
- **Solution:** Run previous code chunks first

**Issue:** "x should be a matrix"
- **Solution:** Use `model.matrix()` for glmnet

**Issue:** Different results than solutions
- **Solution:** Check random seed `set.seed(123)`

**Issue:** Can't knit to HTML
- **Solution:** Install pandoc, check all chunks run

**Issue:** Plots not displaying
- **Solution:** Install ggplot2, check figure dimensions

---

## 💡 Teaching Tips

### For Instructors:

**Pacing:**
- Allow 90-120 minutes for completion
- Check progress at exercises 4, 8, and 12
- Address common mistakes as they arise

**Key Teaching Points:**
1. Emphasize train/test split importance
2. Show VIF interpretation clearly
3. Demonstrate glmnet matrix conversion
4. Explain lambda.1se vs lambda.min choice
5. Highlight LASSO's automatic feature selection

**Extension Activities:**
- Elastic Net (mixing Ridge and LASSO)
- Real-world dataset application
- Hyperparameter tuning strategies
- Cross-validation fold number impact

**Discussion Questions:**
1. When would you prefer Ridge over LASSO?
2. How do you explain regularization to non-technical stakeholders?
3. What if lambda.1se drops important features?
4. How do you balance interpretability vs. performance?

---

## 📚 Additional Resources

### Recommended Reading:
- **An Introduction to Statistical Learning** (James et al.)
  - Chapter 6: Linear Model Selection and Regularization
- **The Elements of Statistical Learning** (Hastie et al.)
  - Chapter 3.4: Shrinkage Methods

### Online Resources:
- glmnet vignette: https://glmnet.stanford.edu/
- Ridge vs LASSO comparison: https://stats.stackexchange.com/q/866
- Cross-validation guide: scikit-learn.org/stable/modules/cross_validation.html

### Video Tutorials:
- StatQuest: Ridge Regression
- StatQuest: LASSO Regression
- Josh Starmer's regularization series

---

## 📧 Support

**For Students:**
- Review quick reference guide
- Check solutions for hints (don't copy!)
- Ask questions in office hours
- Form study groups

**For Instructors:**
- Solutions file has detailed explanations
- Grading rubric included
- Common errors documented
- Extension activities suggested

---

## 📝 File Formats

### Input Files:
- `.Rmd` - RMarkdown source files
- `.md` - Markdown reference guide

### Output Files:
- `.html` - Knitted exercise results (students submit this)
- `.pdf` - Alternative output format (optional)

---

## ⚖️ Assessment

### Grading Breakdown:

**Part 1 (25%):** Overfitting Diagnosis
- Exercises 1-4
- Understanding train/test split
- VIF interpretation

**Part 2 (35%):** Ridge Regression
- Exercises 5-8
- Matrix preparation
- Cross-validation implementation
- Performance evaluation

**Part 3 (35%):** LASSO Regression
- Exercises 9-12
- Feature selection
- Model comparison
- Business interpretation

**Code Quality (5%):** Throughout
- Clean, readable code
- Appropriate comments
- Proper variable names

**Bonus (+15%):** Optional Challenges
- Advanced techniques
- Deeper analysis
- Creative extensions

---

## 🎯 Learning Outcomes Alignment

This classwork supports the following course learning outcomes:

1. **Technical Skills**
   - Implement advanced regression techniques
   - Use cross-validation for model selection
   - Apply regularization to real problems

2. **Analytical Thinking**
   - Diagnose model problems
   - Compare alternative approaches
   - Interpret statistical output

3. **Communication**
   - Explain technical concepts
   - Make business recommendations
   - Visualize results effectively

4. **Professional Practice**
   - Use industry-standard tools (glmnet)
   - Follow reproducible workflows
   - Document analysis clearly

---

## 🔄 Version History

- **v1.0** (2024) - Initial release
  - 12 core exercises
  - 3 bonus challenges
  - Complete solutions
  - Quick reference guide

---

## 📄 License

These materials are provided for educational use only.

---

## 🙏 Acknowledgments

- Based on Lecture 3: Advanced Regression & Regularization
- Uses glmnet package by Friedman, Hastie, and Tibshirani
- Synthetic data generation inspired by real estate datasets

---

**Questions? Issues? Suggestions?**

Contact course instructor or TA for support.

**Ready to start? Open `classwork_3_regularization.Rmd` and begin!** 🚀

---

*Last updated: 2024*
*Part of: Predictive Analytics and Big Data course materials*
