library(plyr)
library(ggplot2)
library(smoof)

multi_start <- function(objective_function, domain, num_points, dimensions) {
  best_point <- numeric(length(domain))
  best_value <- Inf
  total_calls <- 0

  monitored_objective_function <- function(x) {
    total_calls <<- total_calls + 1
    return(objective_function(x))
  }

  for (i in 1:num_points) {
    start_point <- runif(dimensions, min = domain[, 1], max = domain[, 2])

    result <- optim(par = start_point, fn = monitored_objective_function, method = "L-BFGS-B")

    if (result$value < best_value) {
      best_value <- result$value
      best_point <- result$par
    }
  }

  return(best_value)
}


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

  return(best_value)
}

statistical_analysis <- function(results1, results2) {
  t_test_result <- t.test(results1, results2)
  confidence_interval <- t_test_result$conf.int
  p_value <- t_test_result$p.value
  
  return(list(confidence_interval = confidence_interval, p_value = p_value))
}

main <- function() {
  
  ackley_function <- function(x) smoof::makeAckleyFunction(dimensions = length(x))(x)
  rastrigin_function <- function(x) smoof::makeRastriginFunction(dimensions = length(x))(x)
  
  dimensions <- c(2, 10, 20)
  
  MS_ackley_avg <- PRS_ackley_avg <- MS_rastrigin_avg <- PRS_rastrigin_avg <- numeric(0)
  dimensions_vector <- c()
  
  for (dim in dimensions) {
    
    ackley <- makeAckleyFunction(dim)
    ackley_lower_bounds <- getLowerBoxConstraints(ackley)
    ackley_upper_bounds <- getUpperBoxConstraints(ackley)
    ackley_domain <- matrix(c(ackley_lower_bounds, ackley_upper_bounds), ncol = 2)
    
    MS_ackley_results <- replicate(5, multi_start(ackley_function, ackley_domain, num_points = 1, dim))
    PRS_ackley_results <- replicate(5, pure_random_search(ackley_function, ackley_domain, num_points = 1, dim))
    
    rastrigin <- makeRastriginFunction(dim)
    rastrigin_lower_bounds <- getLowerBoxConstraints(rastrigin)
    rastrigin_upper_bounds <- getUpperBoxConstraints(rastrigin)
    rastrigin_domain <- matrix(c(rastrigin_lower_bounds, rastrigin_upper_bounds), ncol = 2)
    
    MS_rastrigin_results <- replicate(5, multi_start(rastrigin_function, rastrigin_domain, num_points = 1, dim))
    PRS_rastrigin_results <- replicate(5, pure_random_search(rastrigin_function, rastrigin_domain, num_points = 1, dim))
    
    MS_ackley_avg <- c(MS_ackley_avg, mean(MS_ackley_results))
    MS_rastrigin_avg <- c(MS_rastrigin_avg, mean(MS_rastrigin_results))
    PRS_ackley_avg <- c(PRS_ackley_avg, mean(PRS_ackley_results))
    PRS_rastrigin_avg <- c(PRS_rastrigin_avg, mean(PRS_rastrigin_results))
    
    dimensions_vector <- c(dimensions_vector, rep(dim, times = 4))
    
    
    ackley_analysis <- statistical_analysis(MS_ackley_results, PRS_ackley_results)
    rastrigin_analysis <- statistical_analysis(MS_rastrigin_results, PRS_rastrigin_results)
    
    print(paste("Ackley (", dim, " dimensions):"))
    print(paste("Confidence Interval: ", ackley_analysis$confidence_interval))
    print(paste("P-value: ", ackley_analysis$p_value))
    
    print(paste("Rastrigin (", dim, " dimensions):"))
    print(paste("Confidence Interval: ", rastrigin_analysis$confidence_interval))
    print(paste("P-value: ", rastrigin_analysis$p_value))
    
  }
  
  values <- c()
   for (i in 1:length(dimensions)) {
     values <- c(values, MS_ackley_avg[i], MS_rastrigin_avg[i], PRS_ackley_avg[i], PRS_rastrigin_avg[i])
   }
  
  df <- data.frame(
    Method = rep(rep(c("MS", "PRS"), each = 2), length(dimensions)),
    Dimension = rep(dimensions, each = 4),
    Value = values
  )
  
  plot_point <- ggplot(df, aes(x = as.factor(Dimension), y = Value, color = Method)) +
    geom_point(position = position_dodge(width = 0.8), size = 3) +
    labs(x = "Dimension", y = "Optimization Value", title = "Comparison of MS and PRS") +
    theme_minimal()

  print(plot_point)

  plot_boxplot <- ggplot(df, aes(x = as.factor(Dimension), y = Value, color = Method)) +
    geom_boxplot(position = position_dodge(width = 0.8), width = 0.7, alpha = 0.7) +
    labs(x = "Dimension", y = "Optimization Value", title = "Comparison of MS and PRS") +
    theme_minimal()

  print(plot_boxplot)
}

main()
