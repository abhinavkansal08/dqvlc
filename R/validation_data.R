#' Example Data for dqvlc: Data Quality Validation with Logical Conditioning
#'
#' A messy dataset illustrating multiple types of data quality issues
#' including missing values, impossible values, inconsistent logic,
#' outliers, and rule violations.
#'
#' This dataset is used to demonstrate how the function
#' \code{validate_rules()} identifies and extracts violating rows.
#'
#' @docType data
#'
#' @format A data frame with 50 rows and 7 variables:
#' \describe{
#'   \item{id}{Unique record identifier}
#'   \item{sex}{Sex of individual, 'Male', 'Female', or missing}
#'   \item{age}{Age in years; includes children, adults, extreme ages, and negative ages}
#'   \item{isPregnant}{TRUE/FALSE pregnancy status; includes missing values and inconsistent entries}
#'   \item{BMI}{Body Mass Index; includes negative values, zeros, and extreme values}
#'   \item{systolic_bp}{Systolic blood pressure (mmHg); includes missing values and extremes}
#'   \item{smoker}{TRUE/FALSE smoking indicator; includes missing values}
#' }
#'
#' @details
#' This dataset intentionally contains errors and inconsistencies such as:
#' \itemize{
#'   \item Negative BMI values
#'   \item Ages > 120 or < 0
#'   \item Pregnant males
#'   \item Missing values in categorical and numeric fields
#'   \item Implausible BP values
#' }
#'
#' @source Created manually for the dqvlc package.
"validation_data"
