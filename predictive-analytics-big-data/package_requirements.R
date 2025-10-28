################################################################################
# R PACKAGE REQUIREMENTS CHECKER
# Run this script to verify all necessary packages are installed
################################################################################

cat('Checking R package requirements for Predictive Analytics & Big Data...\n\n')

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
  cat('✓ All required packages are installed!\n')
} else {
  cat('⚠ The following packages need to be installed:\n')
  cat(paste(' -', missing, collapse = '\n'), '\n\n')
  
  cat('To install missing packages, run:\n')
  cat(sprintf('install.packages(c(%s))\n', 
              paste(shQuote(missing), collapse = ', ')))
  
  # Special note for keras/tensorflow
  if ('keras' %in% missing || 'tensorflow' %in% missing) {
    cat('\n⚠ Special installation required for keras/tensorflow:\n')
    cat('  install.packages("keras")\n')
    cat('  library(keras)\n')
    cat('  install_keras()\n')
  }
}

# Check R version
r_version <- as.numeric(paste(R.version$major, R.version$minor, sep = '.'))
if (r_version < 4.0) {
  cat('\n⚠ Warning: R version', r_version, 'detected.\n')
  cat('  This course requires R >= 4.0. Please update R.\n')
} else {
  cat('\n✓ R version', r_version, 'is compatible.\n')
}

cat('\n========================================\n')
cat('Setup check complete. Review any warnings above.\n')
cat('========================================\n')

