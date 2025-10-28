# Classwork 7: Production Deployment Planning

**Time Allocation:** 35-40 minutes

## Business Context

You are a senior data scientist at **TechMart**. After six weeks of model development, you've selected Ridge regression with λ=0.05 as your production pricing model. The model achieves RMSE=$8.20 on validation data using 75 features.

The VP of Engineering has scheduled a production deployment review meeting tomorrow. Your manager has asked you to prepare a comprehensive deployment plan addressing data pipelines, monitoring, retraining, and risk mitigation. Engineering teams need concrete specifications, not theoretical discussions.

The VP specifically mentioned: *"Last year's recommendation model failed three weeks into production because we didn't monitor feature drift. I won't approve this deployment without a concrete monitoring and maintenance plan."*

## Dataset Description

**File:** `production_simulation.csv`

**Observations:** 500 products (simulating 30 days of production data)

**Features:** Same 75 features as development, but with production realities:
- Missing values increased from 2% to 12% 
- Feature distributions shifted from training data
- Some features show correlation structure changes
- New product categories not in training data

**Your model:** Pre-trained Ridge model (`production_model.rds`)

## Your Tasks

### Part 1: Production Performance Evaluation (10 minutes)

Load the production simulation data and pre-trained Ridge model. Score the production data and calculate performance metrics (RMSE, MAE, R²) compared to validation performance. Production RMSE was $8.20 during validation.

Identify which product segments show significant performance degradation. Calculate performance by product category, price tier, and brand. Use quantile-based analysis to find where predictions fail most severely (e.g., 95th percentile absolute errors).

Document the performance gap. Compute the percentage RMSE increase from validation. Identify the top 5 worst-performing segments with their specific RMSE values. Determine if degradation is uniform or concentrated in specific subgroups.

### Part 2: Feature Drift Analysis (8 minutes)

Compare feature distributions between training and production data. For continuous features, calculate mean shifts and standard deviation changes. For each feature, compute the percentage change in mean and standard deviation.

Identify features with severe drift (>20% mean shift or >30% SD change). Flag these as high-risk features requiring immediate attention. Calculate the number of features exceeding drift thresholds.

Analyze missing value patterns. Compare missing value rates between training (2%) and production (12%). Identify which specific features have elevated missing rates. Determine if missing patterns correlate with performance degradation.

### Part 3: Monitoring Dashboard Design (8 minutes)

Design a monitoring dashboard with four critical metrics tracked daily: prediction accuracy (RMSE, MAE), feature drift indicators (mean shifts, missing rates), prediction volume and latency (throughput, p95 latency), and business impact (revenue implications, alert frequency).

Establish alert thresholds for each metric. Define yellow alerts (investigation needed) and red alerts (immediate action). RMSE exceeding $10 (22% degradation) should trigger red alerts. Feature drift exceeding 25% mean shift should trigger yellow alerts. Missing value rates exceeding 15% should trigger red alerts.

Create a dashboard mockup showing how these metrics would be displayed. Include time-series plots for trend detection and comparison tables showing training versus production distributions.

### Part 4: Retraining Strategy (5 minutes)

Develop a retraining protocol. Define the retraining schedule (weekly, monthly, triggered). Specify the training window (rolling 90 days, expanding window). Determine the validation approach (time-based holdout, walk-forward).

Establish retraining triggers beyond scheduled updates. RMSE degradation exceeding 15% should trigger immediate retraining. Feature drift in critical features exceeding 30% should trigger retraining. New product categories representing more than 10% of volume should trigger retraining.

Calculate retraining costs. Training takes 2 hours of data scientist time ($150/hour) plus 30 minutes of computational resources ($50). Weekly retraining costs $10,400 annually. Monthly retraining costs $2,600 annually. Triggered retraining adds unpredictable costs depending on drift frequency.

### Part 5: Risk Mitigation Plan (5 minutes)

Identify deployment risks and mitigation strategies. Data pipeline failures could prevent feature availability (mitigation: implement fallback to safe default predictions). Feature drift could degrade accuracy silently (mitigation: automated drift detection with alerts). Model bugs could produce nonsensical predictions (mitigation: sanity checks rejecting predictions outside $10-$500 range).

Define rollback procedures. Maintain previous model version in production-ready state. Implement A/B testing infrastructure to compare new and old models on 10% of traffic before full rollout. Establish decision criteria for rollback (RMSE exceeds old model by 5%, business metrics degrade, alert frequency exceeds 10 per day).

Create an incident response plan. Define escalation paths (model owner → data science manager → VP Engineering). Establish communication protocols (Slack channel for alerts, email for daily summaries, dashboard for stakeholders). Specify response time commitments (yellow alerts investigated within 4 hours, red alerts addressed within 1 hour).

### Part 6: Deployment Documentation (4 minutes)

Write a one-page deployment summary for the VP of Engineering including model specifications (Ridge regression, λ=0.05, 75 features, trained on 90 days of data), performance benchmarks (validation RMSE=$8.20, expected production RMSE=$8-9, acceptable threshold RMSE<$10), monitoring plan (daily metrics, automated alerts, weekly reviews), and retraining strategy (monthly scheduled, triggered by drift or degradation).

Document feature requirements. List the 10 most important features (highest coefficient magnitudes) with their expected ranges and acceptable missing rates. Specify latency requirements for each feature source (database queries <50ms, API calls <200ms, computed features <100ms).

Create a maintenance calendar. Schedule weekly performance reviews, monthly retraining, quarterly model audits, and annual architecture reviews. Assign responsibilities for each maintenance activity.

## Deliverables

Complete the provided `student_template.Rmd` with:

1. **Production Performance Report:** Metrics table, segment analysis, degradation summary

2. **Feature Drift Dashboard:** Comparison visualizations, drift calculations, risk flags

3. **Monitoring Specification:** Dashboard mockup, alert thresholds, metric definitions

4. **Retraining Protocol:** Schedule, triggers, cost analysis

5. **Risk Mitigation Plan:** Risk matrix, rollback procedures, incident response

6. **Deployment Memo:** One-page summary for VP Engineering

## Success Criteria

Your deployment plan should demonstrate production readiness through concrete specifications rather than vague commitments. Engineering teams should be able to implement monitoring infrastructure from your specifications. Business stakeholders should understand success metrics and escalation procedures. Your documentation should enable smooth handoff to operations teams.

## Estimated Time Breakdown

- Part 1: Production evaluation (10 min)
- Part 2: Feature drift analysis (8 min)
- Part 3: Monitoring dashboard (8 min)
- Part 4: Retraining strategy (5 min)
- Part 5: Risk mitigation (5 min)
- Part 6: Documentation (4 min)
- **Total: 40 minutes**

## Files Provided

- `instructions.md` (this file)
- `student_template.Rmd` (your workspace)
- `production_simulation.csv` (production data)
- `production_model.rds` (trained Ridge model)
- `training_stats.rds` (training data statistics for comparison)
