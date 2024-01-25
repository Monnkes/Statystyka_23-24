library(ggplot2)
library(smoof)


multi_start <- function(objective_function, num_points, domain) {
  best_point <- numeric(length(domain))
  best_value <- Inf
  total_calls <- 0
  
  for (i in 1:num_points) {
    start_point <- runif(length(domain)/2, min = domain[, 1], max = domain[, 2])
    
    result <- optim(par = start_point, fn = objective_function, method = "L-BFGS-B")
    total_calls <- total_calls + result$counts["function"]
    
    if (result$value < best_value) {
      best_value <- result$value
      best_point <- result$par
    }
  }
  
  return(c(best_value,total_calls))
}


pure_random_search <- function(objective_function, num_points,  domain) {
  best_point <- numeric(length(domain))
  best_value <- Inf
  
  for (i in 1:num_points) {
    random_point <- runif(length(domain)/2, min = domain[, 1], max = domain[, 2])
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
  
  return(t_test_result)
}

main <- function() {
  
  dimensions <- c(2, 10, 20)
  
  MS_ackley_avg <- PRS_ackley_avg <- MS_rastrigin_avg <- PRS_rastrigin_avg <- numeric(0)
  dimensions_vector <- c()
  
  for (dim in dimensions) {
    
    ackley <- makeAckleyFunction(dimensions = dim)
    left <- getParamSet(ackley)$pars$x$lower
    right <- getParamSet(ackley)$pars$x$upper
    ackley_domain <- matrix(c(left, right), ncol = 2)
    
    MS_ackley_vector <- replicate(50, multi_start(ackley, num_points = 100,  ackley_domain))
    MS_ackley_results <- MS_ackley_vector[1, ]
    MS_ackley_mean <- mean(MS_ackley_vector[2, ])
    
    print(MS_ackley_mean)
    
    PRS_ackley_results <- replicate(50, pure_random_search(ackley, num_points = MS_ackley_mean, ackley_domain))
    
    rastrigin <- makeRastriginFunction(dimensions =  dim)
    left <- getParamSet(rastrigin)$pars$x$lower
    right <- getParamSet(rastrigin)$pars$x$upper
    rastrigin_domain <- matrix(c(left, right), ncol = 2)
    
    MS_rastrigin_vector <- replicate(50, multi_start(rastrigin, num_points = 100, rastrigin_domain))
    MS_rastrigin_results <- MS_rastrigin_vector[1, ]
    MS_rastrigin_mean <- mean(MS_rastrigin_vector[2, ])
    
    print(MS_rastrigin_mean)
    
    PRS_rastrigin_results <- replicate(50, pure_random_search(rastrigin, num_points = MS_rastrigin_mean, rastrigin_domain))
    
    MS_ackley_avg <- c(MS_ackley_avg, mean(MS_ackley_results))
    MS_rastrigin_avg <- c(MS_rastrigin_avg, mean(MS_rastrigin_results))
    PRS_ackley_avg <- c(PRS_ackley_avg, mean(PRS_ackley_results))
    PRS_rastrigin_avg <- c(PRS_rastrigin_avg, mean(PRS_rastrigin_results))
    
    dimensions_vector <- c(dimensions_vector, rep(dim, times = 4))
    
    ackley_analysis <- statistical_analysis(MS_ackley_results, PRS_ackley_results)
    rastrigin_analysis <- statistical_analysis(MS_rastrigin_results, PRS_rastrigin_results)
    
    
    par(mfrow=c(1, 2))  
    
    plot_density_comparison <- function(data, title) {
      hist(data, prob=TRUE, main=title, xlab="Value", ylab="Density", col="lightblue", border="black", breaks = 50)
      curve(dnorm(x, mean=mean(data), sd=sd(data)), add=TRUE, col="darkred", lwd=2)
    }
    
    plot_density_comparison(MS_ackley_results, paste("MS Ackley", dim, "D"))
    plot_density_comparison(MS_rastrigin_results, paste("MS Rastrigin", dim, "D"))
    plot_density_comparison(PRS_ackley_results, paste("PRS Ackley", dim, "D"))
    plot_density_comparison(PRS_rastrigin_results, paste("PRS Rastrigin", dim, "D"))
    
    #par(mfrow = c(1, 2))
    #hist(MS_ackley_results, breaks = 30)
    #hist(MS_rastrigin_results, breaks = 30)
    
    #par(mfrow = c(1, 2))
    #hist(PRS_ackley_results, breaks = 30)
    #hist(PRS_rastrigin_results, breaks = 30)
    
    #print(MS_ackley_results)
    #print(MS_rastrigin_results)
    #print(PRS_ackley_results)
    #print(PRS_rastrigin_results)
    
    print(paste("Ackley (", dim, " dimensions):"))
    print(ackley_analysis)
    
    print(paste("Rastrigin (", dim, " dimensions):"))
    print(rastrigin_analysis)
    
  }
  
  #print(MS_ackley_avg)
  #print(MS_rastrigin_avg)
  #print(PRS_ackley_avg)
  #print(PRS_rastrigin_avg)
  
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

