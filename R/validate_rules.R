library(devtools)
library(usethis)

#' Validate logical rules in a data frame
#'
#' @param data A data frame to check.
#' @param rules A character vector of rules (e.g. "sex == 'Male' -> isPregnant == FALSE").
#'
#' @return A list with:
#' \describe{
#'   \item{summary}{A data frame where each row corresponds to a rule, reporting total violations and row indices.}
#'   \item{violating_rows}{A list of data frames, each containing rows from `data` that violated the rule.}
#' }
#'
#' @examples
#' df <- data.frame(sex = c("Male","Female"), isPregnant=c(TRUE,FALSE))
#' validate_rules(df, "sex=='Male' -> isPregnant==FALSE")
#'
#' @export
validate_rules <- function(data, rules) {

  results <- list()
  violating_rows <- vector("list", length(rules))

  for (i in seq_along(rules)) {

    rule <- rules[[i]]
    parts <- strsplit(rule, "->")[[1]]

    if (length(parts) != 2)
      stop(paste("Invalid rule format:", rule))

    condition   <- trimws(parts[1])
    expectation <- trimws(parts[2])

    tryCatch({

      cond_eval <- with(data, eval(parse(text = condition)))
      exp_eval  <- with(data, eval(parse(text = expectation)))

      viol <- cond_eval & !exp_eval

      results[[i]] <- data.frame(
        Rule = rule,
        Violations = sum(viol, na.rm = TRUE),
        Violating_Rows = paste(which(viol), collapse = ", "),
        stringsAsFactors = FALSE
      )

      violating_rows[[i]] <- data[which(viol), , drop = FALSE]

    }, error = function(e) {

      warning(paste("Error in rule:", rule, "-", e$message))

      results[[i]] <- data.frame(
        Rule = rule,
        Violations = NA,
        Violating_Rows = NA,
        stringsAsFactors = FALSE
      )

      violating_rows[[i]] <- NULL
    })
  }

  names(violating_rows) <- rules

  list(
    summary = do.call(rbind, results),
    violating_rows = violating_rows
  )
}
