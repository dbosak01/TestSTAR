# ***********************************************************************
# Demo1: Commands to create, edit, save, and run a local module
# ***********************************************************************


# Install star package
install.packages("C:/packages/star_0.0.9001.tar.gz", repos = NULL, type = 'source')

# Load library
library(star)

# Create a new module for the demog prototype
mod <- create_module("t_dm_02_001", "./t_dm_02_001", major_version = 0, minor_version = 0,
                     description = "An initial demographics module used for development of STAR.",
                     keywords = c("demographics"),
                     dependancies = c("dplyr", "tibble", "tidyr", "common", "fmtr", "reporter"))


mod <- mod |>
    add_parameter("column_labels", c("ARM A" = "ARM A", "ARM B" = "ARM B", "ARM C" = "ARM C", "ARM D" = "ARM D"),
                  "character", "text", "Column Labels") |>
    add_parameter("block_vars", c( "SEX", "ETHNIC", "RACE", "AGE", "AGEGR1"), "character", "text", "Variables") |>
    add_parameter("block_pages", c(1, 1, 1, 2, 2), "character", "text", "Page Assignments") |>
    add_parameter("title_vct", "Table", "character", "text", "Title Vector") |>
    add_parameter("footnote_vct", "Footnote", "character", "text", "Footnote Vector")


# View module
mod


# Save changes
write_module(mod)


