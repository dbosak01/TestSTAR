# ***********************************************************************
# Demo2: Commands to find, pull, and run a module.
# ***********************************************************************

# Install star package
install.packages("C:/packages/star_0.0.9001.tar.gz", repos = NULL, type = 'source')

# Load library
library(star)

# Find all modules
mods <- find_modules(version = "all", status = "all")

# Find a specific module
mods <- find_modules(name = "lst*")

mods

# Pull down a module to local environment
mod <- pull_module(mods$Name)

mod

# Run module
res <- run_module(mod, listingNum = "1.1")

# List variables from returned environment
ls(res)

# View results
res$listingNum
res$reportName
res$dat

