#' Expression matrix
#' @param ... ...
#' @export
gene_expression <- add_validators(
  derived_file,
  function(design) {
    expression <- as.matrix(read.table(self$path, header = TRUE, nrows = 1, row.names = 1, sep = ","))
    validate(all(!is.na(expression)), "All values should not be NA")
    validate(is.numeric(expression), "All values should be numeric")
  }
)


#' Overall trajectory differential expression
#' @param ... ...
#' @export
tde_overall <- add_validators(
  derived_file,
  function(design) {
    # check tde overall
    tde_overall <- read_csv(
      self$path,
      col_types = cols()
    )
    
    allowed_colnames <- c("feature_id", "significant", "p_value", "effect_size", "rank")
    validate(
      all(colnames(tde_overall) %in% allowed_colnames), 
      hint = setdiff(colnames(tde_overall), allowed_colnames)
    )
    
    validate(any(c("significant", "p_value", "effect_size", "rank") %in% colnames(tde_overall)))
    
    if ("significant" %in% colnames(tde_overall)) {
      validate(is.logical(tde_overall$significant))
    }
    if ("p_value" %in% colnames(tde_overall)) {
      validate(is.numeric(tde_overall$p_value))
      validate(all(tde_overall$p_value >= 0))
      validate(all(tde_overall$p_value <= 1))
    }
    if ("effect_size" %in% colnames(tde_overall)) {
      validate(is.numeric(tde_overall$effect_size))
    }
    if ("rank" %in% colnames(tde_overall)) {
      validate(is.integer(tde_overall$rank))
      validate(min(tde_overall$rank) >= 1)
      validate(max(tde_overall$rank) <= nrow(tde_overall))
    }
    
    validate(all(!is.na(tde_overall)))
    
    # check feature ids
    if ("dataset" %in% names(design)) {
      all_feature_ids <- as.matrix(read.table(design$dataset$gene_expression$path, header = TRUE, nrows = 1, row.names = 1, sep = ",")) %>% colnames()
    } else if ("gene_expression" %in% names(design)) {
      all_feature_ids <- as.matrix(read.table(design$gene_expression$path, header = TRUE, nrows = 1, row.names = 1, sep = ",")) %>% colnames()
    }
    
    validate(all(tde_overall$feature_id %in% all_feature_ids), "All feature_id are present in the original dataset")
  }
)