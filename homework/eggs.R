# groceries example haha

eggs <- TRUE

n.milk <- ifelse(eggs == TRUE, yes = 6, no = 1)

paste0("Here's the milk. I bought ", n.milk, ".")


# now to write a function that does the same thing

shop <- function(eggs) { #do they have eggs? T/F
  if (eggs == TRUE) { # if there are eggs 
    n.milk <- 6 # get six cartons
  } else {# if there are not eggs
    n.milk <- 1 # get 1 carton of milk
  }
  paste0("Here's the milk. I bought ", n.milk, ".")
}

shop(TRUE) # run the function by setting the one and only argument (eggs) to either TRUE or FALSE

# second attempt

shop2 <- function(milk, eggs) {

  if (milk == TRUE && eggs == TRUE) {
  n.milk <- 6
} else if (milk == FALSE && eggs == TRUE) {
    n.milk <- 0
} else if (milk == TRUE && eggs == FALSE) {
    n.milk <- 1
} else {
    n.milk <- 0
  }
  return(n.milk)
}

shop2(TRUE, TRUE)

# third attempt

shop3 <- function(milk, eggs) {
  if (milk == TRUE && eggs == TRUE) {
    n.milk <- 1
    n.eggs <- 6
  } else if (milk == FALSE && eggs == TRUE) {
    n.milk <- 0
    n.eggs <- 6
  } else if (milk == TRUE && eggs == FALSE) {
    n.milk <- 1
    n.eggs <- 0
  } else {
    n.milk <- 0
    n.eggs <- 0 
  }
  paste0(n.milk, " milk and ", n.eggs, " eggs")
}

shop3(TRUE, TRUE)