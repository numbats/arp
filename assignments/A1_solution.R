remaining_customers_count <- function(mu, lambda, p = 3, n = 720) {
  # Argument validation
  if (!is.numeric(mu) || mu <= 0) stop("mu must be a positive number.")
  if (!is.numeric(lambda) || lambda <= 0) stop("lambda must be a positive number.")
  if (!is.numeric(p) || p < 1 || p != as.integer(p)) stop("p must be a positive integer.")
  if (!is.numeric(n) || n <= 0) stop("n must be a strictly positive number.")

  # Track checkout timing
  queue <- rep(list(numeric()), p)

  # Generate customer arrival times within n
  arrivals <- rexp(ceiling(n * (1.5 / mu)), rate = 1 / mu)
  arrivals <- arrivals[cumsum(arrivals) <= n]  # Only keep arrivals within time limit
  # while(max(arrivals) < n) {
  #   rexp(1,)
  # }

  num_arrivals <- length(arrivals)

  # Generate checkout times
  checkouts <- rexp(num_arrivals, rate = 1 / lambda)

  # Process each arrival
  for (i in seq_len(num_arrivals)) {
    # Update the checkouts based inter-arrival time
    queue <- lapply(queue, `-`, arrivals[i])
    queue <- lapply(queue, Filter, f = \(x) x > 0)

    # Join the checkout with the shortest queue
    queue_idx <- which.min(lengths(queue))
    queue_pos <- length(queue[[queue_idx]]) + 1
    queue[[queue_idx]][queue_pos] <-
      if(queue_pos > 1)
        queue[[queue_idx]][queue_pos - 1] + checkouts[[i]]
      else
        checkouts[[i]]
  }

  # Return total customers still in queues
  sum(pmax(0, lengths(queue) - 1))
}

remaining_customers_time <- function(mu, lambda, p = 3, n = 720) {
  # Argument validation
  if (!is.numeric(mu) || mu <= 0) stop("mu must be a positive number.")
  if (!is.numeric(lambda) || lambda <= 0) stop("lambda must be a positive number.")
  if (!is.numeric(p) || p < 1 || p != as.integer(p)) stop("p must be a positive integer.")
  if (!is.numeric(n) || n < 1 || n != as.integer(n)) stop("n must be a positive integer.")

  # Track checkout timing
  queue <- rep(list(numeric()), p)

  # Generate customer arrival times within n
  arrivals <- rexp(ceiling(n * (1.5 / mu)), rate = 1 / mu)
  arrivals <- arrivals[cumsum(arrivals) <= n]  # Only keep arrivals within time limit
  num_arrivals <- length(arrivals)

  arrival_time <- cumsum(arrivals)

  # Generate checkout times
  checkout_time <- rexp(num_arrivals, rate = 1 / lambda)

  # a p-wise min-cumsum with delayed start
  queue_wait <- rep(NA_real_, length(arrival_time))
  empty_time <- numeric(p)
  for (i in seq_along(arrival_time)) {
    # Customer chooses the shortest queue (by time)
    checkout <- which.min(empty_time)

    # The wait time is the time the customer is served, less their arrival time
    queue_wait[i] <- max(0, empty_time[checkout] - arrival_time[i])

    # Update the total checkout time with the new customer's checkout time
    empty_time[checkout] <- arrival_time[i] + queue_wait[i] + checkout_time[i]
  }

  # Return total customers still in queues
  return(sum(arrival_time + queue_wait > n))

  # Alternatively return a data.frame of the event timings for plotting
  # data.frame(
  #   arrival_time,
  #   checkout_time,
  #   queue_wait,
  #   serve_time = arrival_time + queue_wait,
  #   departure_time = arrival_time + checkout_time + queue_wait
  # )
}

my_result <- bench::mark(
  remaining_customers_count(3, 10),
  remaining_customers_time(3, 10),
  check = FALSE
)

## Update `remaining_customers_time` to return the data.frame, then...
# queue_events <- remaining_customers_time(3, 10)
#
# with(
#   queue_events,
#   tibble(
#     time = sort(c(queue_events$arrival_time, queue_events$serve_time)),
#     in_queue = vapply(time, \(n) sum(arrival_time + queue_wait > n & arrival_time < n), numeric(1L))
#   )
# ) |>
#   ggplot(aes(x = time, y = in_queue)) +
#   geom_line()
