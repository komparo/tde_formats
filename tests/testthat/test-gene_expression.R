context("Test gene_expression")

gene_expression_path <- function(x) {system.file(paste0("examples/gene_expression/", x))}

gene_expression(gene_expression_path("good_1.csv"))
