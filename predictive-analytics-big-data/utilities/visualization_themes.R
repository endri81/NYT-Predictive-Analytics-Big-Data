################################################################################
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

