# ***********************************************************************
# Demo4: Commands to create a listing module.
# ***********************************************************************


# Install star package
install.packages("C:/packages/star_0.0.9001.tar.gz", repos = NULL, type = 'source')

# Load library
library(star)

# Create a new module for the demog prototype
mod <- create_module("lst_proto", "./lst_proto", minor_version = 3,
                     description = "An initial prototype listing.",
                     type = "Listing", status = "Release",
                     keywords = c("prototype"),
                     dependancies = c("reporter")) |>
    add_parameter("listingNum", "0.0", "character", "text", "Table Number") |>
    add_parameter("reportName", "listing1", "character", "text", "Report File Name")


# Save parameters
write_module(mod)

# View module
mod

# Write code here

# Run module
res <- run_module(mod, listingNum = "1.0")

# List variables from returned environment
ls(res)

# View results
res$dat

# Push to module cache
push_module(mod)

# View modules
mods <- find_modules(version = "all")


