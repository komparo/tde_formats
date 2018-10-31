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
    col_types <- cols(
      feature_id = col_character(), 
      tde_overall = col_logical()
    )
    
    # check tde overall
    tde_overall <- read_csv(
      self$path, 
      col_types = col_types
    )
    validate(all(!is.na(tde_overall)), "All values should not be NA")
    
    # check feature ids
    all_feature_ids <- readr::read_lines(design$gene_expression$path, n_max = 1) %>% str_split(",") %>% dplyr::first() %>% tail(-1)
    validate(all(tde_overall$feature_id %in% all_feature_ids), "All feature_id are present in the original dataset")
  }
)