library(plyr)
library(ggplot2)
library(smoof)

pure_random_search <- function(objective_function, domain, num_points, dimensions) {
  best_point <- numeric(length(domain))
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
  return(best_value)
}

main <- function() {
  ackley_function <- function(x) makeAckleyFunction(dimensions = length(x))(x)
  rastrigin_function <- function(x) makeRastriginFunction(dimensions = length(x))(x)
  
  dimensions <- c(2, 10, 20)

  ackley_results <- rastrigin_results <- numeric(0)
  
  for (dim in dimensions) {
    ackley <- makeAckleyFunction(dim)
    lower_bounds <- getLowerBoxConstraints(ackley)
    upper_bounds <- getUpperBoxConstraints(ackley)
    domain <- matrix(c(lower_bounds, upper_bounds), ncol = 2)
    
    ackley_results <- c(ackley_results, replicate(50, pure_random_search(ackley_function, domain, num_points = 10, dim)))
    
    rastrigin <- makeRastriginFunction(dim)
    lower_bounds <- getLowerBoxConstraints(rastrigin)
    upper_bounds <- getUpperBoxConstraints(rastrigin)
    domain <- matrix(c(lower_bounds, upper_bounds), ncol = 2)
    rastrigin_results <- c(rastrigin_results, replicate(50, pure_random_search(rastrigin_function, domain, num_points = 10, dim)))
  }

  data <- data.frame(
    Dimension = rep(dimensions, each = 100),
    Function = rep(rep(c("Ackley", "Rastrigin"), each = 50), times = 3),
    Value = c(ackley_results, rastrigin_results)
  )
  
  ggplot(data, aes(x = as.factor(Dimension), y = Value, fill = Function)) +
    geom_boxplot(position = position_dodge(width = 0.75), width = 0.7) +
    labs(title = "Pure Random Search Optimization",
         x = "Dimension",
         y = "Optimization Value") +
    theme_minimal() +
    theme(legend.position = "top") +
    scale_fill_manual(values = c("Ackley" = "blue", "Rastrigin" = "red"))
}

main()
