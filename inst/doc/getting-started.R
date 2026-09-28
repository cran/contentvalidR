## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
set.seed(1)

## ----setup--------------------------------------------------------------------
library(contentvalidR)

## -----------------------------------------------------------------------------
toy_sort <- data.frame(
  item = rep(paste0("I", 1:4), each = 12),
  rater = rep(1:12, 4),
  target_construct   = rep(c("A","A","B","B"), each = 12),
  assigned_construct = c(
    sample(c("A","B"), 12, TRUE, c(.80,.20)),
    sample(c("A","B"), 12, TRUE, c(.65,.35)),
    sample(c("A","B"), 12, TRUE, c(.70,.30)),
    sample(c("A","B"), 12, TRUE, c(.45,.55))
  )
)
psa <- compute_psa(toy_sort)
csv <- compute_csv(toy_sort)
csv$decision <- vapply(seq_len(nrow(csv)), function(i) {
  csv_binom_test(csv$n_target[i], csv$n[i])$decision
}, character(1))
psa; csv

## -----------------------------------------------------------------------------
set.seed(2)
toy_ratings <- expand.grid(
  item = c("I1", "I2", "I3"),
  rater = 1:16,
  construct = c("A", "B", "C")
)
toy_ratings$target_construct <- ifelse(toy_ratings$item == "I3", "B", "A")
toy_ratings$rating <- ifelse(
  toy_ratings$construct == toy_ratings$target_construct,
  pmin(5, pmax(1, round(rnorm(nrow(toy_ratings), 4.4, .6)))),
  pmin(5, pmax(1, round(rnorm(nrow(toy_ratings), 2.2, .7))))
)

rating_fit <- rating_validity(toy_ratings, scale_min = 1, scale_max = 5)
rating_fit
summary(rating_fit)

## -----------------------------------------------------------------------------
expert_ratings <- matrix(
  c(4,4,4,4,4,4,
    4,4,4,3,4,4,
    4,3,4,4,3,4),
  nrow = 6,
  dimnames = list(NULL, paste0("Item", 1:3))
)
expert_fit <- expert_validity(expert_ratings, mode = "relevance", lo = 1, hi = 4)
expert_fit
summary(expert_fit)

## ----bundled-data-------------------------------------------------------------
example_files <- c(
  "sort_example.csv",
  "rating_example.csv",
  "expert_relevance_example.csv",
  "expert_essentiality_example.csv",
  "expert_congruence_example.csv"
)
vapply(example_files, function(x) {
  system.file("extdata", x, package = "contentvalidR")
}, character(1))

## -----------------------------------------------------------------------------
R <- matrix(sample(1:5, 5*6, replace = TRUE), nrow = 5)
aikens_v(R, lo = 1, hi = 5)

cvr(essential = c(8,10,5), N = 12)

M <- matrix(sample(0:1, 6*5, replace = TRUE, prob = c(.3,.7)), nrow = 6)
cvi(M)

ioc_df <- data.frame(
  item = rep(paste0("I",1:2), each = 9),
  judge = rep(1:3, times = 6),
  objective = rep(rep(LETTERS[1:3], each = 3), times = 2),
  score = sample(c(-1,0,1), 18, replace = TRUE)
)
ioc(ioc_df)

## -----------------------------------------------------------------------------
truth <- c(TRUE, TRUE, TRUE, FALSE)  # pretend "kept" after CFA
signal_detection(csv$decision == "significant", truth)

csv2_sig <- sample(c(TRUE, FALSE), nrow(csv), replace = TRUE)
reproducibility_phi(csv$decision == "significant", csv2_sig)

## -----------------------------------------------------------------------------
sort_power(N = c(20, 30), true_p = c(.65, .75))

