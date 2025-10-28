################################################################################
# PREDICTIVE ANALYTICS & BIG DATA COURSE STRUCTURE SETUP
# MSc in Data Science and Business Analytics
# November 2025
# 
# PURPOSE: This script creates the complete folder structure, template files,
#          and documentation for the 9-lecture course. Run this once at the
#          beginning of the course to establish the organizational framework.
#
# USAGE: 
#   1. Set your working directory to where you want the course folder
#   2. Run this entire script
#   3. The folder "predictive-analytics-big-data" will be created
#   4. All subfolders, templates, and README files will be generated
#
# PHILOSOPHY: Professional data science requires reproducible project structure.
#             This script embodies best practices in project organization.
################################################################################

# Create the main course directory
course_dir <- "predictive-analytics-big-data"
if (!dir.exists(course_dir)) {
  dir.create(course_dir)
  cat("✓ Created main course directory\n")
} else {
  cat("! Course directory already exists\n")
}

# Set working directory to course folder
setwd(course_dir)

################################################################################
# SECTION 1: ROOT LEVEL STRUCTURE
################################################################################

# Create root-level directories
root_dirs <- c(
  "foundations/mathematical_derivations",
  "utilities",
  "data/retail",
  "data/healthcare", 
  "data/finance",
  "data/social_media",
  "big_data_concepts",
  "resources/case_studies",
  "resources/ethics_frameworks",
  "resources/career_resources"
)

for (dir in root_dirs) {
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
}
cat("✓ Created root-level directory structure\n")

################################################################################
# SECTION 2: WEEK AND LECTURE STRUCTURE
################################################################################

# Define the three weeks with their lectures
weeks <- list(
  week_1 = list(
    name = "week_1_foundations_and_prediction",
    project = "project_1_sales_forecasting",
    lectures = c(
      "lecture_1_regression_fundamentals",
      "lecture_2_classification_methods", 
      "lecture_3_advanced_regression"
    )
  ),
  week_2 = list(
    name = "week_2_advanced_models_and_text",
    project = "project_2_customer_segmentation_and_churn",
    lectures = c(
      "lecture_4_clustering_techniques",
      "lecture_5_recommendation_systems",
      "lecture_6_text_analytics"
    )
  ),
  week_3 = list(
    name = "week_3_neural_networks_and_integration",
    project = "project_3_integrated_prediction_system",
    lectures = c(
      "lecture_7_neural_network_fundamentals",
      "lecture_8_deep_learning_applications",
      "lecture_9_model_deployment_and_ethics"
    )
  )
)

# Create week folders and their contents
for (week in weeks) {
  week_path <- week$name
  dir.create(week_path, showWarnings = FALSE)
  
  # Create project folder structure
  project_path <- file.path(week_path, week$project)
  project_subdirs <- c(
    "data",
    "exploratory_analysis",
    "model_development",
    "evaluation",
    "business_recommendations",
    "presentation"
  )
  
  for (subdir in project_subdirs) {
    dir.create(file.path(project_path, subdir), recursive = TRUE, showWarnings = FALSE)
  }
  
  # Create lecture folders with classwork and homework
  for (lecture in week$lectures) {
    lecture_path <- file.path(week_path, lecture)
    dir.create(lecture_path, showWarnings = FALSE)
    dir.create(file.path(lecture_path, "data"), showWarnings = FALSE)
    
    # Each lecture has multiple classwork exercises
    for (i in 1:3) {
      cw_path <- file.path(lecture_path, paste0("classwork_", i))
      dir.create(file.path(cw_path, "data"), recursive = TRUE, showWarnings = FALSE)
      dir.create(file.path(cw_path, "solutions"), recursive = TRUE, showWarnings = FALSE)
    }
    
    # Each lecture has one homework
    hw_path <- file.path(lecture_path, "homework")
    dir.create(file.path(hw_path, "data"), recursive = TRUE, showWarnings = FALSE)
    dir.create(file.path(hw_path, "solutions"), recursive = TRUE, showWarnings = FALSE)
  }
}

cat("✓ Created week, lecture, and project directory structures\n")

################################################################################
# SECTION 3: TEMPLATE FILES GENERATION
################################################################################

# START_HERE.md - The first file students should read
start_here_content <- "# PREDICTIVE ANALYTICS & BIG DATA
## MSc in Data Science and Business Analytics | November 2025

Welcome to the course! This document provides your roadmap for the next three weeks.

## 📋 Course Overview

This 9-lecture course transforms you from data science student to job-ready predictive analytics professional. You will build three substantial portfolio projects that demonstrate end-to-end capability in:

- Supervised learning (regression and classification)
- Unsupervised learning (clustering and dimensionality reduction)
- Text analytics and natural language processing
- Neural networks and deep learning
- Model deployment and ethical AI

## 🗓️ Schedule

**Week 1: Foundations and Prediction (Nov 7-9)**
- Lecture 1: Regression Fundamentals
- Lecture 2: Classification Methods
- Lecture 3: Advanced Regression
- **Project 1: E-Commerce Sales Optimization**

**Week 2: Advanced Models and Text (Nov 14-16)**
- Lecture 4: Clustering Techniques
- Lecture 5: Recommendation Systems
- Lecture 6: Text Analytics
- **Project 2: Customer Segmentation and Churn**

**Week 3: Neural Networks and Integration (Nov 20-22)**
- Lecture 7: Neural Network Fundamentals
- Lecture 8: Deep Learning Applications
- Lecture 9: Model Deployment and Ethics
- **Project 3: Integrated Predictive System**

## 📁 Folder Structure

- `utilities/` - Shared R functions for preprocessing, visualization, evaluation
- `data/` - Course datasets organized by domain
- `foundations/` - Mathematical derivations and deeper theory
- `big_data_concepts/` - How these techniques scale to production systems
- `week_X_*/` - Weekly content including lectures and projects
- `resources/` - Case studies, ethics frameworks, career materials

## 🚀 Getting Started

1. **Review course_progress.md** - Your checklist for the entire course
2. **Check package_requirements.R** - Install necessary R packages
3. **Read decision_framework_guide.md** - Understand the decision-first approach
4. **Explore Week 1 folder** - Begin with lecture_1_regression_fundamentals

## 💡 Learning Philosophy

This course emphasizes **decision intelligence**: models exist to enable better decisions. Every assignment requires you to:

1. Define the business decision being made
2. Specify the cost of being wrong
3. Articulate the action driven by the model
4. Document your modeling choices and assumptions

## 📧 Questions?

Refer to the README.md files in each folder for specific guidance. Each lecture folder contains a lecture_guide.md with learning objectives.

**Let's build something extraordinary together.**
"

writeLines(start_here_content, "START_HERE.md")

# Course progress tracking file
progress_content <- "# COURSE PROGRESS TRACKER

Track your completion of all course components. Check off items as you complete them.

## Week 1: Foundations and Prediction

### Lecture 1: Regression Fundamentals (Nov 7)
- [ ] Attended lecture
- [ ] Completed Classwork 1: Gradient Descent
- [ ] Completed Classwork 2: Assumption Checking  
- [ ] Completed Classwork 3: Model Diagnostics
- [ ] Submitted Homework 1

### Lecture 2: Classification Methods (Nov 8)
- [ ] Attended lecture
- [ ] Completed Classwork 1: Logistic Regression
- [ ] Completed Classwork 2: ROC Analysis
- [ ] Completed Classwork 3: Threshold Selection
- [ ] Submitted Homework 2

### Lecture 3: Advanced Regression (Nov 9)
- [ ] Attended lecture
- [ ] Completed Classwork 1: Regularization
- [ ] Completed Classwork 2: Feature Engineering
- [ ] Completed Classwork 3: Interaction Terms
- [ ] Submitted Homework 3

### Project 1: Sales Forecasting
- [ ] Completed exploratory analysis
- [ ] Built regression models
- [ ] Built classification models
- [ ] Prepared business recommendations
- [ ] Created stakeholder presentation
- [ ] Submitted complete project

---

## Week 2: Advanced Models and Text

### Lecture 4: Clustering Techniques (Nov 14)
- [ ] Attended lecture
- [ ] Completed Classwork 1: K-means Implementation
- [ ] Completed Classwork 2: Hierarchical Clustering
- [ ] Completed Classwork 3: Cluster Validation
- [ ] Submitted Homework 4

### Lecture 5: Recommendation Systems (Nov 15)
- [ ] Attended lecture
- [ ] Completed Classwork 1: Collaborative Filtering
- [ ] Completed Classwork 2: Content-Based Filtering
- [ ] Completed Classwork 3: Hybrid Approaches
- [ ] Submitted Homework 5

### Lecture 6: Text Analytics (Nov 16)
- [ ] Attended lecture
- [ ] Completed Classwork 1: Text Preprocessing
- [ ] Completed Classwork 2: TF-IDF Analysis
- [ ] Completed Classwork 3: Sentiment Classification
- [ ] Submitted Homework 6

### Project 2: Customer Segmentation and Churn
- [ ] Completed customer segmentation
- [ ] Built churn prediction models
- [ ] Analyzed sentiment from reviews
- [ ] Conducted fairness audit
- [ ] Created executive presentation
- [ ] Submitted complete project

---

## Week 3: Neural Networks and Integration

### Lecture 7: Neural Network Fundamentals (Nov 20)
- [ ] Attended lecture
- [ ] Completed Classwork 1: Backpropagation
- [ ] Completed Classwork 2: Activation Functions
- [ ] Completed Classwork 3: Network Architecture
- [ ] Submitted Homework 7

### Lecture 8: Deep Learning Applications (Nov 21)
- [ ] Attended lecture
- [ ] Completed Classwork 1: CNNs for Images
- [ ] Completed Classwork 2: RNNs for Sequences
- [ ] Completed Classwork 3: Transfer Learning
- [ ] Submitted Homework 8

### Lecture 9: Model Deployment and Ethics (Nov 22)
- [ ] Attended lecture
- [ ] Completed Classwork 1: Model Serving
- [ ] Completed Classwork 2: Bias Detection
- [ ] Completed Classwork 3: Monitoring Systems
- [ ] Submitted Homework 9

### Project 3: Integrated Prediction System
- [ ] Designed system architecture
- [ ] Implemented neural network models
- [ ] Created ensemble pipeline
- [ ] Conducted ethical assessment
- [ ] Prepared board presentation
- [ ] Submitted complete project

---

## 🎯 Final Checklist
- [ ] All 9 lectures attended
- [ ] All 27 classwork exercises completed
- [ ] All 9 homework assignments submitted
- [ ] All 3 major projects submitted
- [ ] Portfolio ready for job applications
"

writeLines(progress_content, "course_progress.md")

# Decision Framework Template
decision_framework_template <- "# DECISION FRAMEWORK TEMPLATE

Complete this framework before building any model. Models serve decisions, not the other way around.

## 1. THE DECISION

**What specific decision is being made?**


**Who makes this decision?**


**How frequently is this decision made?**


## 2. THE STAKES

**What happens if we make the right decision?**


**What happens if we make the wrong decision?**


**What is the cost of a false positive?**


**What is the cost of a false negative?**


**Are these costs symmetric or asymmetric?**


## 3. THE ACTION

**What concrete action will be taken based on the model output?**


**What is the intervention threshold?**


**Who implements the action?**


**Is the action reversible?**


## 4. THE CONSTRAINTS

**What are the time constraints for this decision?**


**What are the resource constraints?**


**What are the ethical constraints?**


**What regulatory requirements must be met?**


## 5. THE METRICS

**What metric should we optimize?**


**Why is this the right metric for the decision?**


**What other metrics should we monitor?**


**What is the baseline performance without a model?**


## 6. THE DATA

**What data do we have access to?**


**What data would we need in an ideal world?**


**What are the data quality issues?**


**Are there privacy or security concerns?**


## 7. THE RISKS

**What could go wrong if we deploy this model?**


**How might the model be gamed or manipulated?**


**What are the fairness and bias concerns?**


**What is our plan for monitoring and auditing?**


## 8. THE ALTERNATIVES

**What would we do without a predictive model?**


**What simpler approaches should we try first?**


**When should we revisit this decision framework?**

"

writeLines(decision_framework_template, "decision_framework_template.md")

# Copy decision framework template to each project folder
for (week in weeks) {
  project_path <- file.path(week$name, week$project)
  file.copy("decision_framework_template.md", 
            file.path(project_path, "decision_framework.md"))
  
  # Create decision log template for each project
  decision_log_template <- paste0("# DECISION LOG: ", toupper(gsub("_", " ", week$project)), "

Record every significant modeling decision with justification.

## Date: [YYYY-MM-DD]

### Decision Made:


### Rationale:


### Alternatives Considered:


### Expected Impact:


### How to Verify:


---

## Date: [YYYY-MM-DD]

### Decision Made:


### Rationale:


### Alternatives Considered:


### Expected Impact:


### How to Verify:


---

*Continue adding entries as you make modeling decisions throughout the project.*
")
  
  writeLines(decision_log_template, 
             file.path(project_path, "decision_log.md"))
}

# Create week overview templates
week_overviews <- list(
  week_1 = "# WEEK 1: FOUNDATIONS AND PREDICTION

## Theme
**Democratizing Prediction with Supervised Learning**

## Learning Objectives
By the end of this week, you will:
- Understand gradient descent and optimization fundamentals
- Build and validate linear regression models
- Implement logistic regression for classification
- Master model diagnostics and assumption checking
- Apply regularization techniques (Ridge, Lasso, Elastic Net)
- Communicate predictive insights to business stakeholders

## Business Context
You are a data scientist at an e-commerce company. Leadership wants to optimize marketing spend and improve customer conversion rates. Your task is to build predictive models that inform budget allocation decisions.

## Lectures
1. **Regression Fundamentals** (Nov 7) - Linear regression, gradient descent, assumptions
2. **Classification Methods** (Nov 8) - Logistic regression, ROC curves, threshold selection
3. **Advanced Regression** (Nov 9) - Regularization, feature engineering, interactions

## Project 1: E-Commerce Sales Optimization
**Decision:** Which marketing channels merit increased investment?
**Due:** End of Week 1 (Nov 9)

### Deliverables
- Exploratory data analysis report
- Sales forecasting regression model
- Customer conversion classification model  
- Business recommendations presentation
- Complete decision log

## Big Data Connection
This week, we explore how laptop-scale regression models conceptually map to distributed systems processing billions of transactions. Every technique you learn has a distributed computing equivalent.

## Success Metrics
- Models achieve validation R² > 0.75 for regression
- Classification models achieve AUC > 0.80
- Business recommendations are actionable and data-driven
- Decision framework is thoroughly documented
",
  
  week_2 = "# WEEK 2: ADVANCED MODELS AND UNSTRUCTURED DATA

## Theme
**Personalization at Scale**

## Learning Objectives
By the end of this week, you will:
- Implement k-means and hierarchical clustering algorithms
- Apply dimensionality reduction with PCA
- Build recommendation systems using collaborative filtering
- Process and analyze text data
- Perform sentiment analysis on customer reviews
- Handle imbalanced datasets in churn prediction
- Conduct fairness audits on predictive models

## Business Context
Your e-commerce company wants to personalize customer experiences. You must segment the customer base, predict which customers are at risk of churning, and analyze sentiment from product reviews to inform retention strategies.

## Lectures
4. **Clustering Techniques** (Nov 14) - K-means, hierarchical, validation methods
5. **Recommendation Systems** (Nov 15) - Collaborative filtering, content-based, hybrid
6. **Text Analytics** (Nov 16) - Preprocessing, TF-IDF, sentiment analysis

## Project 2: Customer Segmentation and Churn
**Decision:** Which customer segments should we target for retention, and with what interventions?
**Due:** End of Week 2 (Nov 16)

### Deliverables
- Customer segmentation analysis with business interpretation
- Churn prediction model with fairness audit
- Sentiment analysis dashboard from reviews
- Executive presentation on retention strategy
- Complete decision log

## Big Data Connection
This week examines how clustering and text analytics scale to millions of customers and billions of text documents. You'll understand the architectural patterns behind systems like Spotify's recommendation engine.

## Success Metrics
- Identify 4-6 distinct, actionable customer segments
- Churn model achieves AUC > 0.85 with fair performance across segments
- Sentiment analysis provides clear business insights
- Retention strategy is prioritized and resourced
",
  
  week_3 = "# WEEK 3: NEURAL NETWORKS AND INTEGRATED SYSTEMS

## Theme
**Deploying Intelligence Responsibly**

## Learning Objectives
By the end of this week, you will:
- Understand backpropagation and neural network training
- Implement deep learning models using Keras in R
- Recognize connections between classical ML and neural networks
- Build ensemble models combining multiple approaches
- Design model monitoring and evaluation frameworks
- Conduct ethical assessments of AI systems
- Prepare models for production deployment

## Business Context
Your company is ready to deploy an integrated predictive analytics system. You must combine regression, classification, clustering, and text analytics into a unified pipeline, implement neural networks that improve upon earlier models, and establish governance frameworks for responsible deployment.

## Lectures
7. **Neural Network Fundamentals** (Nov 20) - Architectures, backpropagation, training
8. **Deep Learning Applications** (Nov 21) - CNNs, RNNs, transfer learning, advanced topics
9. **Model Deployment and Ethics** (Nov 22) - Serving, monitoring, bias detection, governance

## Project 3: Integrated Predictive Analytics System
**Decision:** How do we deploy a multi-model system that makes thousands of daily decisions with appropriate oversight?
**Due:** End of Week 3 (Nov 22)

### Deliverables
- System architecture documentation
- Neural network performance comparison
- Ensemble model pipeline
- Ethical assessment and audit framework
- Board-level presentation on AI governance
- Complete decision log with monitoring plan

## Big Data Connection
This week addresses real-time inference at scale, model serving architecture, and MLOps principles. You'll understand how integrated systems handle streaming data and serve predictions to millions of users simultaneously.

## Success Metrics
- Neural network outperforms classical models by >5% on key metrics
- Ensemble approach demonstrates improved robustness
- Ethical assessment identifies and mitigates bias
- Monitoring framework enables ongoing accountability
- Presentation demonstrates executive-level communication

## The Big Picture
Upon completing this project, you have a portfolio demonstrating end-to-end capability: from exploratory analysis through model development to production deployment with ethical safeguards. This is the maturity curve of professional data science.
"
)

# Write week overview files
for (i in 1:3) {
  week_name <- weeks[[i]]$name
  writeLines(week_overviews[[i]], 
             file.path(week_name, "week_overview.md"))
}

cat("✓ Created template and overview files\n")

################################################################################
# SECTION 4: UTILITY FILES AND SHARED RESOURCES
################################################################################

# Create utilities README
utilities_readme <- "# SHARED UTILITY FUNCTIONS

This folder contains R functions used across multiple lectures and projects. Source these files at the beginning of your analysis scripts.

## Files

- `preprocessing_functions.R` - Data cleaning, missing value imputation, scaling
- `visualization_themes.R` - Consistent ggplot2 themes for all course visualizations
- `evaluation_metrics.R` - Model performance metrics and validation functions

## Usage Example
```r
# Source all utility functions
source('utilities/preprocessing_functions.R')
source('utilities/visualization_themes.R')
source('utilities/evaluation_metrics.R')

# Use them in your analysis
clean_data <- preprocess_data(raw_data)
model_performance <- calculate_metrics(predictions, actuals)
plot + course_theme()
```

## Philosophy

Professional data science requires reusable, well-documented functions. These utilities demonstrate best practices in code organization and reproducibility.
"

writeLines(utilities_readme, "utilities/README.md")

# Create placeholder utility files
preprocessing_template <- "################################################################################
# PREPROCESSING FUNCTIONS
# Shared data cleaning and preparation utilities
################################################################################

#' Preprocess dataset with standard cleaning steps
#'
#' @param data Raw dataframe
#' @param numeric_impute Method for numeric missing values ('mean', 'median', 'knn')
#' @param categorical_impute Method for categorical missing values ('mode', 'new_level')
#' @return Cleaned dataframe
preprocess_data <- function(data, 
                            numeric_impute = 'median',
                            categorical_impute = 'mode') {
  # Implementation will be provided in lectures
  # Students will build this incrementally
  return(data)
}

#' Scale numeric features
#'
#' @param data Dataframe with numeric columns
#' @param method Scaling method ('standardize', 'normalize', 'robust')
#' @return Scaled dataframe with scaling parameters as attributes
scale_features <- function(data, method = 'standardize') {
  # Implementation during lecture
  return(data)
}

# Additional functions will be added as course progresses
"

writeLines(preprocessing_template, "utilities/preprocessing_functions.R")

visualization_template <- "################################################################################
# VISUALIZATION THEMES
# Consistent ggplot2 styling for all course materials
################################################################################

library(ggplot2)

#' Course standard ggplot2 theme
#'
#' Professional, publication-ready theme used across all visualizations
#' @return ggplot2 theme object
course_theme <- function() {
  theme_minimal() +
    theme(
      plot.title = element_text(size = 14, face = 'bold'),
      plot.subtitle = element_text(size = 11, color = 'gray30'),
      axis.title = element_text(size = 10),
      axis.text = element_text(size = 9),
      legend.position = 'bottom',
      panel.grid.minor = element_blank()
    )
}

#' Color palette for categorical variables
course_colors <- function() {
  c('#2E86AB', '#A23B72', '#F18F01', '#C73E1D', '#6A994E', '#BC4B51')
}

# Additional visualization utilities will be added
"

writeLines(visualization_template, "utilities/visualization_themes.R")

evaluation_template <- "################################################################################
# EVALUATION METRICS
# Model performance assessment functions
################################################################################

#' Calculate comprehensive regression metrics
#'
#' @param predictions Predicted values
#' @param actuals Actual values
#' @return Named list of performance metrics
regression_metrics <- function(predictions, actuals) {
  # Implementation during lecture
  metrics <- list(
    rmse = NULL,
    mae = NULL,
    r_squared = NULL,
    mape = NULL
  )
  return(metrics)
}

#' Calculate classification metrics
#'
#' @param predictions Predicted probabilities or classes
#' @param actuals Actual classes
#' @param threshold Classification threshold (default 0.5)
#' @return Named list of performance metrics
classification_metrics <- function(predictions, actuals, threshold = 0.5) {
  # Implementation during lecture
  metrics <- list(
    accuracy = NULL,
    precision = NULL,
    recall = NULL,
    f1 = NULL,
    auc = NULL
  )
  return(metrics)
}

# Additional evaluation functions will be added
"

writeLines(evaluation_template, "utilities/evaluation_metrics.R")

################################################################################
# SECTION 5: BIG DATA CONCEPTS FILES
################################################################################

big_data_files <- c(
  "scaling_regression.md",
  "distributed_clustering.md", 
  "production_deployment.md"
)

for (file in big_data_files) {
  placeholder <- paste0("# ", toupper(gsub("_", " ", gsub(".md", "", file))), "

This document explains how the techniques learned on your laptop scale to production big data systems.

*Content will be developed during relevant lectures.*

## Topics Covered
- Conceptual architecture
- Distributed computing frameworks
- Performance considerations
- Real-world examples
")
  writeLines(placeholder, file.path("big_data_concepts", file))
}

################################################################################
# SECTION 6: RESOURCES AND CASE STUDIES
################################################################################

case_studies <- list(
  "astronomy_classification.md" = "# CASE STUDY: ASTRONOMICAL OBJECT CLASSIFICATION

*How clustering and classification techniques scale to billions of celestial objects*

Content will reference real applications from projects like SDSS and LSST.
",
  "healthcare_prediction.md" = "# CASE STUDY: HEALTHCARE PREDICTION AND DIAGNOSIS

*The ethics and impact of AI in medical decision-making*

Content will examine real healthcare AI deployments, successes, and failures.
",
  "climate_modeling.md" = "# CASE STUDY: CLIMATE AND ENVIRONMENTAL PREDICTION

*Big data analytics applied to planetary-scale challenges*

Content will explore how predictive models inform climate science and policy.
"
)

for (file in names(case_studies)) {
  writeLines(case_studies[[file]], 
             file.path("resources/case_studies", file))
}

# Create data README
data_readme <- "# COURSE DATASETS

All datasets used in lectures, classwork, homework, and projects.

## Organization

Datasets are organized by domain:
- `retail/` - E-commerce, sales, transactions
- `healthcare/` - Patient data, outcomes, medical records
- `finance/` - Trading, risk, customer banking
- `social_media/` - User behavior, text, networks

## Data Sources

All datasets are either:
1. Synthetic data generated for pedagogical purposes
2. Publicly available datasets with appropriate licensing
3. Anonymized real-world data with permission

## Ethics and Privacy

Students must treat all data with professional responsibility:
- Do not share datasets outside the course
- Follow all data handling guidelines
- Consider privacy implications in all analyses
- Document data provenance in projects

## Size Considerations

Datasets are sized for laptop computation (typically < 1GB) while remaining pedagogically rich. Big data concepts are taught conceptually alongside practical implementation.
"

writeLines(data_readme, "data/README_data_sources.md")

################################################################################
# SECTION 7: PACKAGE REQUIREMENTS CHECKER
################################################################################

package_checker <- "################################################################################
# R PACKAGE REQUIREMENTS CHECKER
# Run this script to verify all necessary packages are installed
################################################################################

cat('Checking R package requirements for Predictive Analytics & Big Data...\\n\\n')

# Required packages organized by week
packages_week1 <- c(
  'tidyverse',    # Data manipulation and visualization
  'caret',        # Machine learning framework
  'glmnet',       # Regularized regression
  'car',          # Regression diagnostics
  'MASS',         # Statistical functions
  'pROC'          # ROC analysis
)

packages_week2 <- c(
  'cluster',      # Clustering algorithms
  'factoextra',   # Clustering visualization
  'NbClust',      # Cluster validation
  'tm',           # Text mining
  'tidytext',     # Tidy text analysis
  'textdata',     # Sentiment lexicons
  'wordcloud',    # Text visualization
  'randomForest', # Tree-based models
  'xgboost'       # Gradient boosting
)

packages_week3 <- c(
  'keras',        # Deep learning
  'tensorflow',   # Neural network backend
  'reticulate',   # Python integration
  'lime',         # Model interpretability
  'mlr3'          # Modern ML framework
)

all_packages <- unique(c(packages_week1, packages_week2, packages_week3))

# Check which packages are installed
installed <- installed.packages()[, 'Package']
missing <- setdiff(all_packages, installed)

if (length(missing) == 0) {
  cat('✓ All required packages are installed!\\n')
} else {
  cat('⚠ The following packages need to be installed:\\n')
  cat(paste(' -', missing, collapse = '\\n'), '\\n\\n')
  
  cat('To install missing packages, run:\\n')
  cat(sprintf('install.packages(c(%s))\\n', 
              paste(shQuote(missing), collapse = ', ')))
  
  # Special note for keras/tensorflow
  if ('keras' %in% missing || 'tensorflow' %in% missing) {
    cat('\\n⚠ Special installation required for keras/tensorflow:\\n')
    cat('  install.packages(\"keras\")\\n')
    cat('  library(keras)\\n')
    cat('  install_keras()\\n')
  }
}

# Check R version
r_version <- as.numeric(paste(R.version$major, R.version$minor, sep = '.'))
if (r_version < 4.0) {
  cat('\\n⚠ Warning: R version', r_version, 'detected.\\n')
  cat('  This course requires R >= 4.0. Please update R.\\n')
} else {
  cat('\\n✓ R version', r_version, 'is compatible.\\n')
}

cat('\\n========================================\\n')
cat('Setup check complete. Review any warnings above.\\n')
cat('========================================\\n')
"

writeLines(package_checker, "package_requirements.R")

################################################################################
# SECTION 8: FOUNDATIONS AND GLOSSARY
################################################################################

glossary <- "# DATA SCIENCE GLOSSARY

Quick reference for key terms used throughout the course.

## A

**Activation Function**: Non-linear transformation in neural networks that enables learning complex patterns (e.g., ReLU, sigmoid, tanh).

**AUC (Area Under Curve)**: Metric for classification model performance measuring area under ROC curve. Ranges from 0 to 1, with 0.5 being random guessing.

## B

**Backpropagation**: Algorithm for training neural networks by computing gradients of loss with respect to weights.

**Bias (Model)**: Systematic error from overly simplistic assumptions. High bias leads to underfitting.

**Bias (Algorithmic)**: Systematic unfairness in model predictions across different groups.

## C

**Classification**: Supervised learning task predicting categorical outcomes.

**Clustering**: Unsupervised learning task grouping similar observations.

**Confusion Matrix**: Table showing true positives, false positives, true negatives, false negatives.

**Cross-Validation**: Technique for assessing model performance using multiple train-test splits.

## D

**Decision Boundary**: The threshold or surface separating different predicted classes.

**Dimensionality Reduction**: Techniques reducing number of features while preserving information (e.g., PCA).

## E

**Ensemble**: Combining multiple models to improve predictions.

**Epoch**: One complete pass through training data during neural network training.

## F

**F1 Score**: Harmonic mean of precision and recall, useful for imbalanced datasets.

**Feature Engineering**: Creating new input variables from existing data to improve model performance.

## G

**Gradient Descent**: Optimization algorithm iteratively moving toward minimum loss.

## H

**Hyperparameter**: Model configuration set before training (e.g., learning rate, number of clusters).

## I

**Imbalanced Data**: Dataset where classes have very different frequencies.

## L

**Loss Function**: Metric quantifying model error that optimization seeks to minimize.

## M

**MAPE (Mean Absolute Percentage Error)**: Regression metric expressing error as percentage.

**Multicollinearity**: High correlation among predictor variables causing instability.

## N

**Normalization**: Scaling features to common range (e.g., 0 to 1).

## O

**Overfitting**: Model learning training data too well, performing poorly on new data.

**Optimization**: Process of finding model parameters that minimize loss.

## P

**Precision**: Among positive predictions, proportion that are correct. TP/(TP+FP).

**Principal Component Analysis (PCA)**: Dimensionality reduction finding orthogonal directions of maximum variance.

## R

**R-Squared**: Proportion of variance in dependent variable explained by model.

**Recall**: Among actual positives, proportion correctly identified. TP/(TP+FN).

**Regularization**: Techniques penalizing model complexity to prevent overfitting (Ridge, Lasso, Elastic Net).

**RMSE (Root Mean Squared Error)**: Common regression metric, square root of average squared errors.

**ROC Curve**: Plot of true positive rate vs false positive rate across classification thresholds.

## S

**Standardization**: Scaling features to mean 0 and standard deviation 1.

**Stochastic Gradient Descent (SGD)**: Gradient descent using small batches rather than entire dataset.

## T

**TF-IDF (Term Frequency-Inverse Document Frequency)**: Statistic reflecting word importance in document corpus.

**Train-Test Split**: Dividing data into training set for model building and test set for evaluation.

## U

**Underfitting**: Model too simple to capture patterns in data.

## V

**Validation Set**: Data subset used for hyperparameter tuning, separate from test set.

**Variance (Model)**: Error from model sensitivity to training data fluctuations. High variance leads to overfitting.

---

*This glossary will be expanded as course progresses.*
"

writeLines(glossary, "foundations/glossary.md")

################################################################################
# SECTION 9: GENERATE SUMMARY REPORT
################################################################################

cat("\n")
cat("================================================================================\n")
cat("                    COURSE STRUCTURE SETUP COMPLETE\n")
cat("================================================================================\n\n")

cat("✓ Created 3 week directories\n")
cat("✓ Created 9 lecture directories with classwork and homework folders\n")
cat("✓ Created 3 project directories with complete subfolder structure\n")
cat("✓ Generated template files for decision frameworks and decision logs\n")
cat("✓ Created utility function placeholders\n")
cat("✓ Generated README and overview files\n")
cat("✓ Created package requirements checker\n")
cat("✓ Established foundations and glossary\n\n")

cat("NEXT STEPS:\n")
cat("1. Run package_requirements.R to check/install necessary packages\n")
cat("2. Read START_HERE.md for course overview\n")
cat("3. Review course_progress.md to track your completion\n")
cat("4. Explore week_1_foundations_and_prediction to begin\n\n")

cat("FOLDER STRUCTURE AT A GLANCE:\n")
cat("  • 3 weekly folders with 3 lectures each = 9 total lectures\n")
cat("  • Each lecture has 3 classwork exercises + 1 homework\n")
cat("  • Each week has 1 major project with 6 subfolders\n")
cat("  • Shared utilities, data, and resources at root level\n")
cat("  • Complete decision framework templates in each project\n\n")

cat("The course is now ready for content development.\n")
cat("================================================================================\n")

# Return to original directory
setwd('..')
cat("\nReturned to original working directory.\n")
cat("Your course folder is ready at:", file.path(getwd(), course_dir), "\n")