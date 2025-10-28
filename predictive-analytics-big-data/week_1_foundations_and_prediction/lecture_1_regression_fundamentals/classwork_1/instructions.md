# Classwork 1: Gradient Descent Implementation

**Duration:** 20 minutes  
**Collaboration:** Work in pairs or small groups

## Learning Objectives

By completing this exercise, you will:
  - Implement gradient descent optimization from scratch
- Understand how learning rate affects convergence
- Visualize the loss surface and optimization path
- Compare custom implementation to built-in functions
- Think about scalability to big data systems

## Dataset

You will work with `facebook_marketing.csv` containing:
  - `week`: Week number
- `facebook_spend`: Weekly Facebook ad spend ($K)
- `sales`: Weekly sales revenue ($K)

## Tasks

### Task 1: Implement Gradient Descent (10 minutes)

Complete the `gradient_descent_facebook()` function in `template.Rmd`. Your implementation should:
  
  1. Initialize parameters β₀ and β₁ randomly
2. For each iteration:
  - Compute predictions
- Calculate errors
- Compute gradients
- Update parameters
- Record loss
3. Return final parameters and loss history

**Hint:** Review the lecture code for structure.

### Task 2: Experiment with Learning Rates (5 minutes)

Run gradient descent with three different learning rates:
  - α = 0.0001 (slow)
- α = 0.001 (moderate)  
- α = 0.01 (fast)

For each:
  - Plot loss vs. iteration
- Note how many iterations until convergence
- Observe any instability

**Question:** What happens if α is too large (try 0.1)? Why?
  
  ### Task 3: Visualize the Loss Surface (3 minutes)
  
  Create a contour plot showing:
  - β₀ on x-axis (range: 0 to 100)
- β₁ on y-axis (range: 0 to 4)
- Loss as color/contours

Mark the optimal point found by your gradient descent.

### Task 4: Compare to lm() (2 minutes)

Run R's built-in linear regression:
```r
model_builtin <- lm(sales ~ facebook_spend, data = facebook_data)
```

Compare:
- Parameter values (how close are they?)
- Computation time (use `system.time()`)

**Question:** Why is `lm()` faster than gradient descent?

## Submission

Save your completed `template.Rmd` and rendered HTML to your personal folder.

## Bonus Challenge (Optional)

Modify your gradient descent to use **stochastic gradient descent (SGD):**
- Instead of using all data each iteration, use random mini-batches of 10 observations
- How does this affect convergence speed?
- This is how big data systems optimize on massive datasets!

## Discussion Questions

1. How would you parallelize gradient descent across 1000 servers?
2. What if the loss surface had multiple local minima (not convex)?
3. When would you choose gradient descent over closed-form solution?