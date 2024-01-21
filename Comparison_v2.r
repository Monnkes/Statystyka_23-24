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

  return(c(best_value, best_point, total_calls/num_points))
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

  return(c(best_value, best_point))
}

main <- function() {

  # Ogólnie to działa jednak dane są takie aby to się dało jakkolwiek policzyć trzeba zmienić sposób liczenia średniej, dodać wymiary, ustawić poprawne ilosći wywołań

  ackley_function <- function(x) smoof::makeAckleyFunction(dimensions = length(x))(x)
  rastrigin_function <- function(x) smoof::makeRastriginFunction(dimensions = length(x))(x)

  dimensions <- c(10)

  ackley_results <- rastrigin_results <- numeric(0)

  for (dim in dimensions) {
    print(dim)

    ackley <- makeAckleyFunction(dim)
    lower_bounds <- getLowerBoxConstraints(ackley)
    upper_bounds <- getUpperBoxConstraints(ackley)
    domain <- matrix(c(lower_bounds, upper_bounds), ncol = 2)

    MS_ackley_results <- replicate(5, multi_start(ackley_function, domain, num_points = 10, dim))
    print(MS_ackley_results)
    MS_ackley_avg_calls <- mean(MS_ackley_results[dim + 2, ])
    print(MS_ackley_avg_calls)
    PRS_ackley_results <- replicate(5, multi_start(ackley_function, domain, num_points = MS_ackley_avg_calls, dim))
    print(PRS_ackley_results)

    rastrigin <- makeRastriginFunction(dim)
    lower_bounds <- getLowerBoxConstraints(rastrigin)
    upper_bounds <- getUpperBoxConstraints(rastrigin)
    domain <- matrix(c(lower_bounds, upper_bounds), ncol = 2)

    MS_rastrigin_results <- replicate(5, multi_start(rastrigin_function, domain, num_points = 10, dim))
    print(MS_rastrigin_results)
    MS_rastrigin_avg_calls <- mean(MS_rastrigin_results[dim + 2, ])
    print(MS_rastrigin_avg_calls)
    PRS_rastrigin_results <- replicate(5, pure_random_search(rastrigin_function, domain, num_points = MS_rastrigin_avg_calls, dim))
    print(PRS_rastrigin_results)

    MS_ackley_avg <- mean(MS_ackley_results[1, ])
    PRS_ackley_avg <- mean(PRS_ackley_results[1, ])
    MS_rastrigin_avg <- mean(MS_rastrigin_results[1, ])
    PRS_rastrigin_avg <- mean(PRS_rastrigin_results[1, ])

    print(MS_ackley_avg)
    print(PRS_ackley_avg)
    print(MS_rastrigin_avg)
    print(PRS_rastrigin_avg)
  }

}

main()