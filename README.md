# dqvlc

Data Quality Validation with Logical Conditioning.

## Functions

### `validate_rules(data, rules)`

Checks logical rules of the form `"condition -> expectation"` and returns:

- A summary table of violations  
- A list of violating rows  

## Example

```r
df <- data.frame(
  sex=c("Male","Female"),
  isPregnant=c(TRUE,FALSE)
)

validate_rules(df, "sex=='Male' -> isPregnant==FALSE")
