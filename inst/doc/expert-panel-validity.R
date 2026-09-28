## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(contentvalidR)

## ----relevance----------------------------------------------------------------
R <- matrix(
  c(4,4,4,4,4,4,
    4,4,4,3,4,4,
    4,3,4,4,3,4,
    3,3,4,3,2,3),
  nrow = 6,
  dimnames = list(NULL, paste0("Item", 1:4))
)

fit <- expert_validity(R, mode = "relevance", lo = 1, hi = 4, seed = 1)
fit
summary(fit)

## ----aiken-bootstrap----------------------------------------------------------
aikens_v(R, lo = 1, hi = 4, ci = "bootstrap", B = 200, seed = 1)

## ----agreement----------------------------------------------------------------
fit$scale_summary[, c("agreement", "agreement_low", "agreement_high")]
fit$details$agreement

## ----agreement-level----------------------------------------------------------
expert_validity(R, mode = "relevance", lo = 1, hi = 4,
                agreement_level = "interval", agreement_B = 0)$scale_summary$agreement

## ----agreement-ac1------------------------------------------------------------
ac1_fit <- expert_validity(R, mode = "relevance", lo = 1, hi = 4,
                           agreement = "ac1", agreement_B = 0)
ac1_fit$details$agreement

## ----essentiality-------------------------------------------------------------
expert_validity(c(10, 8, 6), mode = "essentiality", N = 12)

## ----essential-matrix---------------------------------------------------------
E <- cbind(
  Item1 = c(1,1,1,1,1,1,1,1),
  Item2 = c(1,1,1,1,1,0,0,0)
)
expert_validity(E, mode = "essentiality")

## ----congruence---------------------------------------------------------------
d <- expand.grid(
  item = c("I1", "I2"),
  judge = 1:4,
  objective = c("A", "B")
)
d$target_objective <- ifelse(d$item == "I1", "A", "B")
d$score <- ifelse(d$objective == d$target_objective, 1, -1)

expert_validity(d, mode = "congruence")

## ----expert-plots, fig.width=7, fig.height=4----------------------------------
plot(expert_validity(R, mode = "relevance", lo = 1, hi = 4))
plot(expert_validity(c(10, 8, 6), mode = "essentiality", N = 12))
plot(expert_validity(d, mode = "congruence"))

