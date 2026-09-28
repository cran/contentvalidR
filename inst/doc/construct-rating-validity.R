## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
set.seed(12)

## ----setup--------------------------------------------------------------------
library(contentvalidR)

## ----data---------------------------------------------------------------------
rating_dat <- expand.grid(
  item = c("A1", "A2", "A3", "B1"),
  rater = 1:24,
  construct = c("A", "B", "C")
)
rating_dat$target_construct <- ifelse(rating_dat$item == "B1", "B", "A")

rating_dat$rating <- ifelse(
  rating_dat$construct == rating_dat$target_construct,
  pmin(5, pmax(1, round(rnorm(nrow(rating_dat), 4.4, .6)))),
  pmin(5, pmax(1, round(rnorm(nrow(rating_dat), 2.2, .8))))
)

## ----htc----------------------------------------------------------------------
htc(rating_dat, scale_min = 1, scale_max = 5)

## ----htd----------------------------------------------------------------------
htd(rating_dat, scale_min = 1, scale_max = 5)

## ----anova--------------------------------------------------------------------
aov_out <- anova_content(rating_dat, design = "within")
aov_out
attr(aov_out, "contrasts")

## ----workflow-----------------------------------------------------------------
fit <- rating_validity(
  rating_dat,
  scale_min = 1,
  scale_max = 5
)
fit
summary(fit)

## ----scale--------------------------------------------------------------------
fit$scale_summary
colquitt_benchmarks("htc")
colquitt_benchmarks("htd")

## ----conditional--------------------------------------------------------------
rating_validity(
  rating_dat,
  orbiting_r = c(A = .42, B = .55)
)$scale_summary

## ----expert-------------------------------------------------------------------
rating_validity(rating_dat, judge_type = "expert")$scale_summary

## ----plot, fig.width=7, fig.height=4------------------------------------------
plot(fit, metric = "htc")
plot(fit, metric = "htd")

## ----rating-map, fig.width=7, fig.height=5------------------------------------
plot(fit, type = "map")

## ----rating-profile, fig.width=7, fig.height=5--------------------------------
plot(fit, type = "profile")

