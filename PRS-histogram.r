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

  result_list <- list(best_point = best_point, best_value = best_value)
  return(best_value)
}


main <- function(){
    ackley_function <- function(x) smoof::makeAckleyFunction(dimensions = length(x))(x)
    rastrigin_function <- function(x) smoof::makeRastriginFunction(dimensions = length(x))(x)

    dimensions2 = 2
    domain2 <- matrix(c(rep(0, dimensions2), rep(10, dimensions2)), ncol = 2)

    dimensions10 = 10
    domain10 <- matrix(c(rep(0, dimensions10), rep(10, dimensions10)), ncol = 2)

    dimensions20 = 20
    domain20 <- matrix(c(rep(0, dimensions20), rep(10, dimensions20)), ncol = 2)
    

    ackley_results2 <- replicate(50, pure_random_search(ackley_function, domain2, num_points = 100,dimensions2))
    rastring_results2 <- replicate(50, pure_random_search(rastrigin_function, domain2, num_points = 100,dimensions2))
    ackley_results10 <- replicate(50, pure_random_search(ackley_function, domain10, num_points = 100,dimensions10))
    rastring_results10 <- replicate(50, pure_random_search(rastrigin_function, domain10, num_points = 100,dimensions10))
    ackley_results20 <- replicate(50, pure_random_search(ackley_function, domain20, num_points = 100,dimensions20))
    rastring_results20 <- replicate(50, pure_random_search(rastrigin_function, domain20, num_points = 100,dimensions20))

    par(mfrow = c(3, 2))
    hist(ackley_results2, breaks = 30)
    hist(rastring_results2, breaks = 30)
    hist(ackley_results10, breaks = 30)
    hist(rastring_results10, breaks = 30)
    hist(ackley_results20, breaks = 30)
    hist(rastring_results20, breaks = 30)
}

main()
