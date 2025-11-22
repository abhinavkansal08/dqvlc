# dqvlc

**dqvlc** (Data Quality Validation with Logical Conditioning) provides a
simple, rule-based framework for checking data quality in R.

The package evaluates logical rules of the form:


For example:  
`sex == 'Male' -> isPregnant == FALSE`  
ensures that male records must have `isPregnant == FALSE`.

`validate_rules()` evaluates each rule on your data frame and returns:

- a **summary table** of rule violations  
- a **list of violating rows** for deeper inspection  

This enables transparent, reproducible data validation for clinical,
epidemiologic, and general-purpose datasets.

---

## Installation and Usage

```r
# Install from GitHub
# install.packages("devtools")
devtools::install_github("abhinavkansal08/dqvlc")

library(dqvlc)

# Basic Example

df <- data.frame(
  sex        = c("Male", "Female", "Male"),
  isPregnant = c(TRUE, FALSE, FALSE)
)

rules <- "sex == 'Male' -> isPregnant == FALSE"

res <- validate_rules(df, rules)

res$summary
res$violating_rows[[1]]


# Example Dataset

data("validation_data", package = "dqvlc")
head(validation_data)

# Multiple Rules Example

rules <- c(
  "sex == 'Male'   -> isPregnant == FALSE",
  "sex == 'Female' -> BMI >= 18.5",
  "age < 18        -> smoker == FALSE",
  "BMI >= 30       -> systolic_bp >= 110",
  "sex == 'Male' & age < 18 -> smoker == FALSE"
)

res <- validate_rules(validation_data, rules)

res$summary          # overview of violations
res$violating_rows   # list of violating rows
