library(smoof)
library(plyr)
library(ggplot2)

pure_random_search <- function(objective_function, domain, num_points, dimensions) {
  best_point <- numeric(dimensions)
  best_value <- Inf

  for (i in 1:num_points) {
    random_point <- runif(dimensions, min = domain[, 1], max = domain[, 2])
    value <- objective_function(random_point)
    if (value < best_value) {
      best_value <- value
      best_point <- random_point
    }
  }

  result_list <- list(best_point = best_point, best_value = best_value)
  return(result_list)
}

multi_start <- function(objective_function, domain, num_points, dimensions, budget) {
  best_point <- numeric(dimensions)
  best_value <- Inf

  start_points <- matrix(runif(num_points * dimensions, min = domain[, 1], max = domain[, 2]), ncol = dimensions)
  
  results <- lapply(1:num_points, function(i) {
    result <- optim(par = start_points[i, ], fn = objective_function, method = "L-BFGS-B")
    if (result$value < best_value) {
      best_value <- result$value
      best_point <- result$par
    }
    return(result$value)
  })

  return(list(best_point = best_point, best_value = best_value, results = results))
}

statistical_test <- function(results1, results2) {
  t_test_result <- t.test(results1, results2)
  return(t_test_result)
}

plot_results <- function(results_prs, results_ms, dimensions) {
  par(mfrow = c(3, 2))

  for (d in dimensions) {
    hist(unlist(results_prs[[paste("Dimensions_", d)]]$results), main = paste("PRS - Dimensions:", d), col = "lightblue", border = "black", breaks = 30)

    hist(unlist(results_ms[[paste("Dimensions_", d, "_results")]]), main = paste("MS - Dimensions:", d), col = "lightgreen", border = "black", breaks = 30)
  }

  par(mfrow = c(1, 1))
}

main <- function() {
  dimensions <- c(2, 10, 20)
  domain <- matrix(c(rep(0, max(dimensions)), rep(10, max(dimensions))), ncol = 2)
  budget_prs_ga <- 1000
  budget_ms <- 100
  ackley_function <- function(x) smoof::makeAckleyFunction(dimensions = length(x))(x)

  results_prs <- list()
  results_ms <- list()

  for (d in dimensions) {

    results_prs[[paste("Dimensions_", d)]] <- replicate(50, pure_random_search(ackley_function, domain, num_points = 10, dimensions = d))

    ms_results <- replicate(50, multi_start(ackley_function, domain, num_points = 100, dimensions = d, budget = budget_ms))
    results_ms[[paste("Dimensions_", d, "_results")]] <- list(results = ms_results)
  }

  plot_results(results_prs, results_ms, dimensions)

  for (d in dimensions) {
    t_test_result <- statistical_test(unlist(results_prs[[paste("Dimensions_", d)]]$best_value), unlist(results_ms[[paste("Dimensions_", d, "_results")]]$best_value))
    print(paste("Statistical Test for Dimensions", d, ": p-value =", t_test_result$p.value))
  }
}

main()
