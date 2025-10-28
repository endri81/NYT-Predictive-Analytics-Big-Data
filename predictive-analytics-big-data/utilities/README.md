# SHARED UTILITY FUNCTIONS

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

