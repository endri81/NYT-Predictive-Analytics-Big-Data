# Classwork 8: Advanced Regularization Methods

**Time Allocation:** 25-30 minutes

## Business Context

You are a data scientist at **MedTech Analytics** developing a risk prediction model for hospital readmission. The clinical team has identified 200 potential predictor variables organized into natural groups: vital signs (15 variables), laboratory results (45 variables), medications (60 variables), diagnoses (50 variables), and procedures (30 variables).

Standard LASSO selects variables inconsistently across retraining cycles, sometimes including just one medication from a therapeutic class while excluding related medications. Clinicians find this confusing and question model reliability when retrained models select different variables despite similar performance.

Your task is to explore group LASSO enforcing group-level feature selection where entire clinical feature groups are retained or eliminated together, creating more interpretable and stable models.

## Dataset Description

**File:** `hospital_readmission.csv`

**Observations:** 5,000 patients (3,500 not readmitted, 1,500 readmitted within 30 days)

**Features:** 200 clinical variables organized into 5 groups:
- Vital signs: 15 variables (heart_rate, blood_pressure_sys, temperature, etc.)
- Labs: 45 variables (hemoglobin, creatinine, glucose, etc.)
- Medications: 60 variables (beta_blockers, ACE_inhibitors, antibiotics, etc.)
- Diagnoses: 50 variables (diabetes, hypertension, heart_failure, etc.)
- Procedures: 30 variables (surgery_cardiac, dialysis, ventilation, etc.)

**Outcome:** Binary readmission indicator (0 = not readmitted, 1 = readmitted)

**Group structure file:** `feature_groups.csv` mapping each feature to its group

## Your Tasks

### Part 1: Standard LASSO Baseline (8 minutes)

Fit standard LASSO logistic regression using cv.glmnet() with alpha=1 and family="binomial". Perform 10-fold cross-validation to select optimal lambda using set.seed(123) for reproducibility. Extract selected features at lambda.1se (more conservative than lambda.min, preferred for clinical applications prioritizing model simplicity).

Evaluate baseline performance calculating AUC on validation set, number of selected features, and which feature groups are represented among selected variables. Examine coefficient stability by fitting LASSO on 5 bootstrap samples and calculating coefficient variance across samples. Features with high coefficient variance indicate selection instability.

Document baseline results creating a summary table showing model performance (AUC, number of features), feature group representation (count of selected features from each group), and stability metrics (median coefficient variance across bootstrap samples). This baseline enables comparison with group LASSO.

### Part 2: Group LASSO Implementation (10 minutes)

Implement group LASSO using the gglasso package (install if needed with install.packages("gglasso")). Prepare data in format required by gglasso() which takes feature matrix X, outcome vector y, and group indicator vector showing which group each feature belongs to.

Fit group LASSO model using cv.gglasso() for cross-validation with same fold structure as baseline LASSO (set.seed(123)). The function automatically searches over lambda values testing different regularization strengths. Extract optimal lambda using lambda.1se for consistency with baseline approach.

Examine group selection pattern determining which of the 5 feature groups (vital signs, labs, medications, diagnoses, procedures) were retained at optimal lambda. Within retained groups, note that group LASSO retains all features from selected groups rather than performing within-group selection. Calculate how many groups selected and total feature count.

Evaluate group LASSO performance on same validation set used for baseline calculating AUC for direct comparison. Assess whether enforcing group structure reduced performance relative to standard LASSO and whether the reduction (if any) seems justified by improved interpretability.

### Part 3: Comparative Analysis (7 minutes)

Create comparison table contrasting standard LASSO versus group LASSO across multiple dimensions: predictive performance (AUC on validation), model complexity (number of features, number of groups), interpretability (whether selected features form coherent clinical story), and stability (coefficient variance across bootstrap samples for group LASSO).

Analyze feature selection differences identifying which groups were selected by group LASSO and whether standard LASSO's selected features concentrated in same groups or scattered across all groups. If standard LASSO selected features from all 5 groups while group LASSO selected only 2-3 groups, this suggests group LASSO identified truly important clinical domains.

Evaluate clinical interpretability asking whether group LASSO selections make clinical sense. If the model selected vital signs and diagnoses while excluding procedures and medications, does this align with clinical expectations about readmission risk factors? Consult domain knowledge (or use medical reasoning) to assess plausibility.

Generate visualizations comparing coefficient patterns across methods. For standard LASSO, create coefficient plot showing selected features colored by group membership. For group LASSO, create grouped coefficient plot showing coefficients within each selected group. Visual comparison reveals whether group LASSO produces more interpretable coefficient structure.

## Deliverables

Complete the provided `student_template.Rmd` with:

1. **Baseline LASSO Analysis:** Model performance, selected features by group, stability assessment

2. **Group LASSO Implementation:** Group selection results, performance evaluation, within-group coefficients

3. **Comparative Evaluation:** Side-by-side comparison table, selection pattern analysis, interpretability assessment

4. **Clinical Recommendation:** 2-3 paragraphs recommending which approach (standard or group LASSO) for clinical deployment with justification based on performance-interpretability tradeoff

## Success Criteria

Your analysis should demonstrate understanding of when and why group structure matters in feature selection. Successful submissions compare methods fairly on identical validation sets, interpret results in clinical context rather than purely statistical terms, and provide actionable recommendations considering both performance metrics and operational constraints (model interpretability, clinician trust, retraining stability).

## Estimated Time Breakdown

- Part 1: Standard LASSO baseline (8 min)
- Part 2: Group LASSO implementation (10 min)
- Part 3: Comparative analysis (7 min)
- **Total: 25 minutes**

## Technical Notes

**Installation:** If gglasso not installed, run install.packages("gglasso") before starting analysis.

**Group specification:** The group indicator vector for gglasso() should be integer vector where each element indicates group membership (e.g., c(1,1,1,2,2,2,3,3) means first 3 features in group 1, next 3 in group 2, last 2 in group 3).

**Cross-validation:** Both cv.glmnet() and cv.gglasso() perform cross-validation but with slightly different interfaces. Pay attention to returned object structure when extracting optimal lambda.

**Bootstrap stability:** For stability assessment, use boot package or manual implementation drawing random samples with replacement, fitting models, extracting coefficients, and calculating variance across bootstrap replicates.

## Files Provided

- `instructions.md` (this file)
- `student_template.Rmd` (your workspace)
- `hospital_readmission.csv` (patient data)
- `feature_groups.csv` (group structure)
