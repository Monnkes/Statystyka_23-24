pure_random_search <- function(objective_function, domain, num_points) {
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

  return(list(best_point = best_point, best_value = best_value))
}

main <- function(){
  ackley_function <- function(x) smoof::makeAckleyFunction(dimensions = length(x))(x)
  rastrigin_function <- function(x) smoof::makeRastriginFunction(dimensions = length(x))(x)
  schwefel_function <- function(x) smoof::makeSchwefelFunction(dimensions = length(x))(x)
  rosenbrock_function <- function(x) smoof::makeRosenbrockFunction(dimensions = length(x))(x)

  domain <- matrix(c(0, -2, 100, 1, 2, 1000), ncol = 2)

  ackley_result <- pure_random_search(ackley_function, domain, num_points = 1000)
  cat("Ackley function results:", "\n")
  print(ackley_result)

  rastrigin_result <- pure_random_search(rastrigin_function, domain, num_points = 1000)
  cat("Rastrigin function results:", "\n")
  print(rastrigin_result)

  schwefel_result <- pure_random_search(schwefel_function, domain, num_points = 1000)
  cat("Schwefel function results:", "\n")
  print(schwefel_result)

  rosenbrock_result <- pure_random_search(rosenbrock_function, domain, num_points = 1000)
  cat("Rosenbrock function results:", "\n")
  print(rosenbrock_result)
}

main()