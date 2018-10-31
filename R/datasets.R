#' Expression matrix
#' @param ... ...
#' @export
gene_expression <- add_validators(
  derived_file,
  function(design) {
    expression <- read.table(self$path, nrows = 2, header = TRUE, row.names = 1)
    validate(all(!is.na(expression)), "All values should not be NA")
  }
)


#' Overall trajectory differential expression
#' @param ... ...
#' @export
tde_overall <- add_validators(
  derived_file,
  function(design) {
    tde_overall <- read_csv(h, nrows = 2, header = TRUE, row.names = 1)
    validate(all(!is.na(expression)), "All values should not be NA")
  }
)


