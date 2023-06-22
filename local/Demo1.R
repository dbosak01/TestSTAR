# ***********************************************************************
# Demo1: Commands to create, edit, save, and run a local module
# ***********************************************************************


# Install star package
install.packages("C:/packages/star_0.0.9001.tar.gz", repos = NULL, type = 'source')

# Load library
library(star)

# Create a new module for the demog prototype
mod <- create_module("tbl_demog_proto", "./tbl_demog_proto", minor_version = 3,
                     description = "An initial prototype demographics module used for development of STAR.",
                     keywords = c("demographics",  "prototype"),
                     dependancies = c("dplyr", "fmtr", "reporter")) |>
    add_parameter("tableNum", "0.0", "character", "text", "Table Number") |>
    add_parameter("myvar", NULL, "character", "text", "Test Variable",
                  "A test variable to take from parent environment") |>
    add_parameter("reportName", "table1", "character", "text", "Report File Name")

# View module
mod

# Edit module
mod$dependancies <- c("dplyr", "tibble", "tidyr", "common", "fmtr", "reporter")

# Save changes
write_module(mod)

# Clear environment
rm(list = ls())

# Write code here

# Read module
mod <- pull_module("./tbl_demog_proto")

# Set variable in current environment
myvar = "Test2"

# Run module
res <- run_module(mod, tableNum = "1.1")

# List variables from returned environment
ls(res)

# View results
res$final
res$ards



# Push to module cache
push_module(mod)

repos

