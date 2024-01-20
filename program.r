library(plyr)
library(ggplot2)


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

  return(list(best_point = best_point, best_value = best_value))
}

multi_start <- function(objective_function, domain, num_points, dimensions) {
  best_point <- numeric(length(domain))
  best_value <- Inf

  for (i in 1:num_points) {
    start_point <- runif(dimensions, min = domain[, 1], max = domain[, 2])
    result <- optim(par = start_point, fn = objective_function, method = "L-BFGS-B")
    
    if (result$value < best_value) {
      best_value <- result$value
      best_point <- result$par
    }
  }

  return(list(best_point = best_point, best_value = best_value))
}



main <- function(){
  ackley_function <- function(x) smoof::makeAckleyFunction(dimensions = length(x))(x)
  rastrigin_function <- function(x) smoof::makeRastriginFunction(dimensions = length(x))(x)

  domain <- matrix(c(0, -2, 100, 1, 2, 1000), ncol = 2)

  ackley_result <- pure_random_search(ackley_function, domain, num_points = 10,dimensions = 3)
  cat("Ackley function results PRS:", "\n")
  print(ackley_result)
 

  rastrigin_result <- pure_random_search(rastrigin_function, domain, num_points = 10,dimensions = 3)
  cat("Rastrigin function results PRS:", "\n")
  print(rastrigin_result)

  ackley_result <- multi_start(ackley_function, domain, num_points = 10,dimensions = 3)
  cat("Ackley function results MS:", "\n")
  print(ackley_result)
 

  rastrigin_result <- multi_start(rastrigin_function, domain, num_points = 10,dimensions = 3)
  cat("Rastrigin function results MS:", "\n")
  print(rastrigin_result)

}

main()