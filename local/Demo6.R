# ***********************************************************************
# Demo6: Commands to create an OncVis module.
# ***********************************************************************

# Install star package
install.packages("C:/packages/star_0.0.9001.tar.gz", repos = NULL, type = 'source')

# Load library
library(star)

# Create a new module for the demog prototype
mod <- create_module("tbl_oncvis_demog1", "./tbl_oncvis_demog1", minor_version = 0,
                     description = "An initial oncvis demog table.",
                     keywords = c("table",  "oncvis"),
                     dependancies = c("reporter")) |>
    add_parameter("dataPath", "", "character", "text", "Input data path") |>
    add_parameter("adslFilter", "saffl == 'Y'", "character", "text", "ADSL Filter string") |>
    add_parameter("outputPath", "", "character", "text", "Report output path")



# Save parameters
write_module(mod)

# View module
mod

# Write code here

# Read module if necessary
mod <- read_module("tbl_oncvis_demog1")

# Run module
res <- run_module(mod, dataPath = "data", outputPath = "output")

# List variables from returned environment
ls(res)


# Push module to remote
push_module(mod)


# View module list
find_modules()



