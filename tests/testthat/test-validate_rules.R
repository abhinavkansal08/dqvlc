test_that("validate_rules works on validation_data with multiple rule types", {

  rules <- c(
    "sex == 'Male' -> isPregnant == FALSE",
    "sex == 'Female' -> BMI >= 18.5",
    "age < 18 -> smoker == FALSE",
    "BMI >= 30 -> systolic_bp >= 110",
    "sex == 'Male' & age < 18 -> smoker == FALSE"
  )

  res <- validate_rules(validation_data, rules)

  # Structure checks
  expect_true(is.list(res))
  expect_true("summary" %in% names(res))
  expect_true("violating_rows" %in% names(res))

  # Summary must be a data frame with 3 columns
  expect_s3_class(res$summary, "data.frame")
  expect_equal(ncol(res$summary), 3)

  # Violating rows must be a list with same length as rules
  expect_equal(length(res$violating_rows), length(rules))

  # Each violating_rows element must be NULL or data frame
  lapply(res$violating_rows, function(x) {
    if (!is.null(x)) expect_s3_class(x, "data.frame")
  })
})
