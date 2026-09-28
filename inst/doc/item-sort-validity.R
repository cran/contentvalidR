## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(contentvalidR)

## -----------------------------------------------------------------------------
sort_dat <- data.frame(
  item = rep(c("A1", "A2", "A3", "B1", "B2", "B3"), each = 20),
  rater = rep(1:20, 6),
  target_construct = rep(c("A", "A", "A", "B", "B", "B"), each = 20),
  assigned_construct = c(
    rep("A", 18), rep("B", 2),
    rep("A", 16), rep("B", 4),
    rep("A", 13), rep("B", 7),
    rep("B", 18), rep("A", 2),
    rep("B", 17), rep("A", 3),
    rep("B", 14), rep("A", 6)
  )
)

fit <- sort_validity(sort_dat)
fit

## -----------------------------------------------------------------------------
summary(fit)

## -----------------------------------------------------------------------------
csv_binom_test(n_c = 15, N = 20)
csv_binom_test(n_c = 14, N = 20)

## -----------------------------------------------------------------------------
colquitt_benchmarks("psa")
colquitt_benchmarks("csv")

## -----------------------------------------------------------------------------
fit_normed <- sort_validity(
  sort_dat,
  orbiting_r = c(A = .42, B = .28)
)
fit_normed$scale_summary

## -----------------------------------------------------------------------------
expert_fit <- sort_validity(sort_dat, judge_type = "expert")
expert_fit$scale_summary

## -----------------------------------------------------------------------------
sort_power(N = c(20, 30, 40), true_p = c(.60, .70, .80))

## ----fig.width=7, fig.height=4------------------------------------------------
plot(fit, metric = "psa")
plot(fit, metric = "csv")

## ----fig.width=7, fig.height=5------------------------------------------------
plot(fit, type = "map")

## ----fig.width=7, fig.height=4------------------------------------------------
plan <- sort_power(N = seq(10, 50, by = 5), true_p = c(.60, .70, .80))
plot(plan)
plot(plan, type = "critical")

