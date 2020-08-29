## makeCacheMatrix uses <<- and encloses functions set/get/setSolve/getSolve to 
## modify the a parent var called 'inv'

makeCacheMatrix <- function(m = matrix()) {
  # each function are closures for the parent function makeCacheMatrix
  # From stackoverflow -> https://stackoverflow.com/questions/2628621/how-do-you-use-scoping-assignment-in-r
  # '<<-' manage a variable at two levels makes it possible to maintain the 
  #       state across function invocations by allowing a function to modify 
  #       variables in the environment of its parent
  inv <- NULL
  
  set <- function(x) {
    m <<- x
    inv <<- NULL
  }
  setSolve <- function(res) inv <<- res
  
  get <- function() m
  getSolve <- function() inv
  
  list(set = set, get = get,
       setSolve = setSolve,
       getSolve = getSolve)
}


## cacheSolve, return cached 'inv' if 'getSolve' has data (ie cached 'inv').
## Otherwise, get the matrix from 'get', compute solve, 'setSolve', and return 'inv'

cacheSolve <- function(cacheFunc, ...) {
  inv <- cacheFunc$getSolve()
  if (!is.null(inv)) {
    message("Using cached inv matrix")
    return(inv)
  }
  
  matrixData <- cacheFunc$get()
  inv <- solve(matrixData)
  cacheFunc$setSolve(inv)
  inv
}


main <- function() {
  m <- matrix(c(1,4,2,6,3,5,2,7,4), nrow=3, ncol=3)
  f <- makeCacheMatrix()
  f$set(m)
  cacheSolve(f)
}

main()

#            [,1] [,2]       [,3]
# [1,]  3.2857143    2 -5.1428571
# [2,]  0.2857143    0 -0.1428571
# [3,] -2.0000000   -1  3.0000000

# Something to remember: 
# multiply a matrix by its inverse we get the Identity matrix
# Must be same # of rows/cols
# Each row must not be a factor of the other
# A x A^-1 = I