library(smoof)
library(ecr)

random <- function(param_set, dimensions) {
    res <- numeric(dimensions)
    
    for (i in 1:dimensions) {
        cat(param_set[1, i], " ", param_set[2, i], "\n")
        res[i] <- runif(1, min = as.numeric(param_set[1, i]), max = as.numeric(param_set[2, i]))
    }
    
    return(res)
}

pure_random_search <- function(param_set, budget, dimensions) {
  ackley <- makeAckleyFunction(dimensions = dimensions)
  best_value <- Inf 
  
  for (i in 1:budget) {
    solutions <- random(param_set, dimensions)
    cat("1\n", solutions, "\n")
    value <- ackley(solutions)
    
    if (value < best_value) {
      best_value <- value
    }
  }
  
  return(best_value)
}

main <- function() {
  budget <- 10
  dimensions <- 2
  par.set <- makeParamSet(
    makeNumericParam("x1", lower = -5, upper = 5),
    makeNumericParam("x2", lower = -5, upper = 5)
  )
  cat(pure_random_search(par.set$par.set, budget, dimensions))
}

main()
