library(fs)

# go to temporary directory and copy over all files
oldwd <- getwd()
on.exit({setwd(oldwd)})

tempdir <- tempfile()
dir.create(tempdir)
dir_copy(system.file("examples", package = "tdeformats"), tempdir)
setwd(paste0(tempdir, "/examples"))

# create extra testthat functions
expect_valid <- function(exprs, file = "") {testthat::expect_true(exprs, info = exprs)}
expect_invalid <- function(exprs, file = "") {testthat::expect_true(is.character(exprs), info = exprs)}

# create a fake history for each file, so that it doesn't get deleted
fs::dir_ls(recursive = TRUE, type = "file") %>% 
  purrr::map(certigo::raw_file) %>% 
  purrr::map("write_history") %>% 
  purrr::invoke_map(call_digest = "")