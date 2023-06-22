# ***********************************************************************
# Demo7: Pull and run a module.
# ***********************************************************************

# Install star package
install.packages("C:/packages/star_0.0.9001.tar.gz", repos = NULL, type = 'source')

# Load library
library(star)


# View modules
lst <- find_modules( version = "all")


# Pull module to local area
mod <- pull_module("tbl_oncvis_demog1")

# Run module locally
res <- run_module(mod, dataPath = "data", outputPath = "output")

# List variables from returned environment
ls(res)

