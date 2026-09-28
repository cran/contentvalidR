## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(contentvalidR)
read_example <- function(name) {
  utils::read.csv(
    system.file("extdata", name, package = "contentvalidR"),
    stringsAsFactors = FALSE
  )
}

## ----example-data-------------------------------------------------------------
sort_dat <- read_example("sort_example.csv")
rating_dat <- read_example("rating_example.csv")
expert_rel <- read_example("expert_relevance_example.csv")

sort_fit <- sort_validity(sort_dat)
rating_fit <- rating_validity(rating_dat, scale_min = 1, scale_max = 5)
expert_fit <- expert_validity(
  as.matrix(expert_rel[setdiff(names(expert_rel), "expert")]),
  mode = "relevance", lo = 1, hi = 4
)

## ----sort-table---------------------------------------------------------------
sort_fit$results[c(
  "item", "target", "n", "n_target", "competitor",
  "psa", "csv", "p_value", "status", "recommendation"
)]

## ----rating-table-------------------------------------------------------------
rating_fit$results[c(
  "item", "target", "n_complete", "strongest_competitor",
  "htc", "htd", "p_value", "max_contrast_p", "status", "recommendation"
)]
rating_fit$scale_summary

## ----expert-table-------------------------------------------------------------
expert_fit$results[c(
  "item", "N", "V", "ci_low", "ci_high", "I_CVI",
  "kappa_mod", "status", "recommendation"
)]
expert_fit$scale_summary

## ----diagnostics--------------------------------------------------------------
pretest_supported <- sort_fit$results$status == "Supported"
later_retained <- c(TRUE, TRUE, TRUE, FALSE, TRUE, FALSE)
signal_detection(pretest_supported, later_retained)

replication_supported <- c(TRUE, TRUE, TRUE, FALSE, TRUE, TRUE)
reproducibility_phi(pretest_supported, replication_supported)

## ----power--------------------------------------------------------------------
sort_power(N = c(20, 30, 40), true_p = c(.60, .70, .80))

