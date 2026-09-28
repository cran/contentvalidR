## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(contentvalidR)
read_example <- function(name) {
  utils::read.csv(
    system.file("extdata", name, package = "contentvalidR"),
    stringsAsFactors = FALSE
  )
}

## ----sort-fit-----------------------------------------------------------------
sort_dat <- read_example("sort_example.csv")
sort_fit <- sort_validity(sort_dat)
sort_sum <- summary(sort_fit)
sort_fit$results
sort_fit$scale_summary

## ----sort-table---------------------------------------------------------------
sort_fit$results[c(
  "item", "target", "n", "n_target", "competitor",
  "psa", "csv", "p_value", "status", "recommendation"
)]

## ----rating-fit---------------------------------------------------------------
rating_dat <- read_example("rating_example.csv")
rating_fit <- rating_validity(rating_dat, scale_min = 1, scale_max = 5)
rating_sum <- summary(rating_fit)
rating_fit$results
rating_fit$scale_summary

## ----rating-table-------------------------------------------------------------
rating_fit$results[c(
  "item", "target", "n_complete", "strongest_competitor",
  "htc", "htd", "p_value", "max_contrast_p", "status", "recommendation"
)]

## ----expert-relevance---------------------------------------------------------
expert_rel <- read_example("expert_relevance_example.csv")
expert_rel_matrix <- as.matrix(expert_rel[setdiff(names(expert_rel), "expert")])
expert_fit <- expert_validity(
  expert_rel_matrix,
  mode = "relevance",
  lo = 1,
  hi = 4
)
expert_sum <- summary(expert_fit)
expert_fit$results
expert_fit$scale_summary

## ----expert-essentiality------------------------------------------------------
expert_ess <- read_example("expert_essentiality_example.csv")
expert_ess_matrix <- as.matrix(expert_ess[setdiff(names(expert_ess), "expert")])
ess_fit <- expert_validity(expert_ess_matrix, mode = "essentiality")
ess_fit$results

## ----expert-congruence--------------------------------------------------------
expert_ioc <- read_example("expert_congruence_example.csv")
ioc_fit <- expert_validity(expert_ioc, mode = "congruence")
ioc_fit$results

## ----reproducibility----------------------------------------------------------
packageVersion("contentvalidR")
sort_fit$settings
sort_fit$design

