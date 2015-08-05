## These functions calculate the inverse of a matrix and cache it for use in later computations
## This is useful as matrix inverse computations can be computationally expensive
## and reducing the number of calls to said functions will reduce run time


## This function calculates and caches the inverse of a matrix

makeCacheMatrix <- function(x = matrix()) {
  #initializes m locally
  m <- NULL
  set <- function(y) {
    #initializes m and x in the cache
    x <<- y
    m <<- NULL
  }
  #pulls x from the cache
  get <- function() x
  #caches a value for m
  set_inverse <- function(inv) m <<- inv
  #pulls m from the cache
  get_inverse <- function() m
  #makes the above functions accessible
  list(set = set, get = get,
       set_inverse = set_inverse,
       get_inverse = get_inverse)
}


## This function returns the cached matrix inverse

cacheSolve <- function(x, ...) {
  #check to see if m is already cached
  m <- x$get_inverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  #pulls x from cache
  data <- x$get()
  #calculates the inverse of x
  m <- solve(data, ...)
  #caches m, the inverse
  x$set_inverse(m)
  m
}



# this is a test case
# x=matrix(c(1:8,10),nrow=3)
# dat=makeCacheMatrix(x)
# solve(x)
# cacheSolve(dat)
# cacheSolve(dat)%*%x
