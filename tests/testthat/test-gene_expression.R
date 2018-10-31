context("Test gene_expression")

source(system.file(paste0("setup.R"), package = "tdeformats"))

design <- list(
  gene_expression = gene_expression(path("gene_expression/good_1.csv")),
  tde_overall = tde_overall(path("tde_overall/good_1.csv"))
)

# gene_expression ---------------------------------------------------------
file <- gene_expression(path("gene_expression/good_1.csv"))
expect_valid(file$validate(design = design))

file <- gene_expression(path("gene_expression/bad_1.csv"))
expect_invalid(file$validate(design = design))

file <- gene_expression(path("gene_expression/bad_2.csv"))
expect_invalid(file$validate(design = design))


# tde_overall ---------------------------------------------------------
file <- tde_overall(path("tde_overall/good_1.csv"))
expect_valid(file$validate(design = design))

file <- tde_overall(path("tde_overall/bad_1.csv"))
expect_invalid(file$validate(design = design))

file <- tde_overall(path("tde_overall/bad_2.csv"))
expect_invalid(file$validate(design = design))
