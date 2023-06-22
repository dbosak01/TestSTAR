# ***********************************************************************
# Demo3: Commands to find, pull, copy, edit, run, and push a new version.
# ***********************************************************************

# Install star package
install.packages("C:/packages/star_0.0.9001.tar.gz", repos = NULL, type = 'source')

# Load library
library(star)

lst <- find_module()

# Pull down a module to local environment
mod <- pull_module()

# Copy modules to local environment
mod <- copy_module()

mod$name <- "new name"
mod$major_version <- 0
mod$minor_version <- 0
mod$description <- "new description"

# View module
mod

# Save changes
write_module(mod)

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

