# ***********************************************************************
# Demo12: Commands to create a figure module.
# ***********************************************************************

# Install star package
install.packages("C:/packages/star_0.0.9001.tar.gz", repos = NULL, type = 'source')

# Load library
library(star)

# Create a new module for the demog prototype
mod <- create_module("fig_proto", "./fig_proto", minor_version = 2,
                     type = "Figure", status = "Release",
                     description = "An initial prototype figure.",
                     keywords = c("prototype"),
                     dependancies = c("ggplot2", "common", "reporter")) |>
    add_parameter("figureNum", "0.0", "character", "text", "Table Number") |>
    add_parameter("reportName", "figure1", "character", "text", "Report File Name")



# Save parameters
write_module(mod)

# View module
mod

# Write code here

# Run module
res <- run_module(mod, figureNum = "1.0")

# List variables from returned environment
ls(res)

# View results
res$dat
res$ards


# Push to module cache
push_module(mod)

# View modules
mods <- find_modules(version = "all")

mods


