## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
set.seed(1)

## ----setup--------------------------------------------------------------------
library(contentvalidR)

## -----------------------------------------------------------------------------
attr(contentvalid_glossary(), "statuses")

## -----------------------------------------------------------------------------
sorts <- read.csv(
  system.file("extdata", "sort_example.csv", package = "contentvalidR"),
  stringsAsFactors = FALSE
)
fit_sort <- sort_validity(sorts)
fit_sort

## -----------------------------------------------------------------------------
ratings <- read.csv(
  system.file("extdata", "rating_example.csv", package = "contentvalidR"),
  stringsAsFactors = FALSE
)
fit_rating <- rating_validity(ratings)
fit_rating$scale_summary[, c("target", "mean_htc", "htc_strength",
                             "mean_htd", "htd_strength")]

## -----------------------------------------------------------------------------
colquitt_benchmarks("htc")
colquitt_benchmarks("htd")

## -----------------------------------------------------------------------------
relevance <- read.csv(
  system.file("extdata", "expert_relevance_example.csv", package = "contentvalidR"),
  stringsAsFactors = FALSE
)
panel <- as.matrix(relevance[, setdiff(names(relevance), "expert")])
fit_expert <- expert_validity(panel, mode = "relevance", lo = 1, hi = 4)
fit_expert$results[, c("item", "N", "V", "I_CVI", "I_CVI_low", "I_CVI_high",
                       "kappa_mod", "recommendation")]

## -----------------------------------------------------------------------------
exact <- expert_validity(panel, mode = "relevance", lo = 1, hi = 4,
                         proportion_ci = "exact")
exact$results[, c("item", "I_CVI", "I_CVI_low", "I_CVI_high")]

## -----------------------------------------------------------------------------
panel_agreement(panel, seed = 1)

## -----------------------------------------------------------------------------
judge_ratings <- rbind(
  c(4, 4, 4, 3, 2, 2), c(4, 4, 3, 4, 2, 1), c(4, 3, 4, 4, 1, 2),
  c(3, 4, 4, 4, 2, 2), c(4, 4, 4, 4, 2, 1), c(4, 3, 4, 3, 1, 2),
  c(4, 4, 3, 4, 2, 2), c(2, 2, 2, 2, 1, 1)
)
dimnames(judge_ratings) <- list(paste0("Judge", 1:8), paste0("Item", 1:6))
fit_judge <- judge_validity(judge_ratings, lo = 1, hi = 4)
fit_judge$results[, c("judge", "mean_rating", "severity_raw",
                      "differentiation", "n_items_flipped", "recommendation")]

## -----------------------------------------------------------------------------
summary(fit_judge)$gtheory$judges_needed

## -----------------------------------------------------------------------------
assignments <- data.frame(
  item = paste0("I", 1:7),
  construct = c("Autonomy", "Autonomy", "Autonomy", "Autonomy",
                "Competence", "Competence", "Relatedness"),
  stringsAsFactors = FALSE
)
fit_domain <- domain_validity(
  assignments,
  cell_col = "construct",
  domain = c("Autonomy", "Competence", "Relatedness", "Belonging")
)
fit_domain$results[, c("cell", "n_items", "share", "recommendation")]

## -----------------------------------------------------------------------------
fit_sort$settings[c("p0", "alpha", "judge_type")]

## ----eval = FALSE-------------------------------------------------------------
# options(contentvalidR.show_key = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# contentvalid_glossary("expert-panel")

