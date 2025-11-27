# dqvlc

`dqvlc` (Data Quality Validation with Logical Conditioning) is an R package that evaluates user‑defined logical rules on a data frame and returns which rows violate each rule. It is designed for use with clinical, epidemiologic, and other analytical datasets where transparent, reproducible data quality checks are needed.

---

## Rationale

The goal of `dqvlc` is to make it easy to formalize and run data‑quality rules that analysts often write informally (e.g., “males should not be pregnant”, “minors should not be smokers”). By expressing these checks as simple “if–then” logical rules, you can:

- Standardize data validation across projects.  
- Quickly identify records that violate design or clinical constraints.  
- Create reusable rule sets that can be shared with collaborators and rerun as data are updated.

---

## What the main function does

The core function, `validate_rules()`, takes:

- a data frame, and  
- a character vector of rules of the form `condition -> expectation`  

Each rule is evaluated row‑by‑row. A **violation** occurs when the left‑hand side (`condition`) is `TRUE` but the right‑hand side (`expectation`) is `FALSE` for a given row.

`validate_rules()` returns:

- a **summary table** with one row per rule, including the number of violations and the indices of violating rows, and  
- a **list of data frames** (`violating_rows`), where each element contains the subset of the original data that violated the corresponding rule.

For example, the rule

```
sex == "Male" -> isPregnant == FALSE
```

states that if `sex` is `"Male"`, then `isPregnant` must be `FALSE`. Any male record with `isPregnant == TRUE` is flagged as a violation.

---

## How to install dqvlc in R

```
install.packages("devtools")
library(devtools)

devtools::install_github("abhinavkansal08/dqvlc")
library(dqvlc)
```

After installation, you can access function‑level help with:

```
?validate_rules
```
---
## Example

Here is a minimal example using a small toy data frame:

```
library(dqvlc)

df <- data.frame(
  sex        = c("Male", "Female", "Male"),
  isPregnant = c(TRUE, FALSE, FALSE)
)

rules <- "sex == 'Male' -> isPregnant == FALSE"

res <- validate_rules(df, rules)

# Summary of violations for each rule
res$summary

# Rows that violated the first rule
res$violating_rows][1]
```

This example identifies any records where a male is incorrectly marked as pregnant.

---

## Multiple‑rule example with included data

`dqvlc` includes a small synthetic dataset, `validation_data`, to demonstrate more realistic checks:

```
data("validation_data", package = "dqvlc")
head(validation_data)
```

You can define multiple rules at once, for example:

```
rules <- c(
  "sex == 'Male'   -> isPregnant == FALSE",
  "sex == 'Female' -> BMI >= 18.5",
  "age < 18        -> smoker == FALSE",
  "BMI >= 30       -> systolic_bp >= 110",
  "sex == 'Male' & age < 18 -> smoker == FALSE"
)

res <- validate_rules(validation_data, rules)

# Overview of violations by rule
res$summary

# List of data frames with violating rows for each rule
res$violating_rows
```

Each rule captures a simple consistency or plausibility check (e.g., under‑18s should not be smokers), and the output helps you quickly see which observations require review.

---
