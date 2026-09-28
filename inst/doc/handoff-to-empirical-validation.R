## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(contentvalidR)

## ----panel--------------------------------------------------------------------
relevance <- matrix(
  c(4,4,4,3,  4,4,3,4,  3,4,4,4,  3,2,3,2,  2,2,1,2),
  nrow = 4,
  dimnames = list(NULL, paste0("Item", 1:5))
)

fit <- expert_validity(relevance, mode = "relevance", lo = 1, hi = 4, seed = 1)
fit$results[, c("item", "N", "V", "I_CVI", "kappa_mod", "status")]

## ----handoff------------------------------------------------------------------
handoff <- content_handoff(fit)
handoff

## ----components---------------------------------------------------------------
handoff$items
handoff$item_evidence
head(handoff$item_statistics)

## ----provenance---------------------------------------------------------------
str(handoff$provenance[c("schema_version", "workflow", "mode", "keep",
                         "method", "citation")])

## ----keep---------------------------------------------------------------------
content_handoff(fit, keep = c("Supported", "Review"))$items

## ----held---------------------------------------------------------------------
handoff$item_evidence[!handoff$item_evidence$carried,
                      c("item", "status", "recommendation")]

## ----scales-------------------------------------------------------------------
sort_dat <- data.frame(
  item = rep(c("A1", "A2", "B1"), each = 12),
  rater = rep(1:12, 3),
  target_construct = c(rep("A", 24), rep("B", 12)),
  assigned_construct = c(rep("A", 11), "B", rep("A", 9), rep("B", 3),
                         rep("B", 10), rep("A", 2))
)
content_handoff(sort_validity(sort_dat), keep = c("Supported", "Review"))$scales

## ----nomologr, eval=FALSE-----------------------------------------------------
# # install.packages("nomologR", repos = "https://juhalt.r-universe.dev")
# library(nomologR)
# 
# # `responses` is your collected data: one row per respondent, one column per item.
# scr <- nomo_screen(responses, items = handoff)
# scr$item_summary

## ----plain--------------------------------------------------------------------
class(handoff)

## ----reporting----------------------------------------------------------------
ev <- handoff$item_evidence
sprintf("%d of %d items were carried forward (%s); %d were held back.",
        length(handoff$items), length(unique(ev$item)),
        paste(handoff$provenance$keep, collapse = ", "), sum(!ev$carried))

