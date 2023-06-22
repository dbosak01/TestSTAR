# ***********************************************************************
# Demo9: Commands to find, pull, and run a module.
# ***********************************************************************

# Install star package
#install.packages("C:/Projects/Amgen/OncVis/oncvis_1.2.1.tar.gz", repos = NULL, type = 'source')
#install.packages("C:/packages/star_0.0.9001.tar.gz", repos = NULL, type = 'source')

# Load library
library(star)


# Find all modules
mods <- find_modules()

mods

# Find a specific module
mods <- find_modules("tbl_oncvis_demog1")

mods

# Pull down a module to local environment
mod <- pull_module(mods$Name)

mod

# Run module
res <- run_module(mod, outputNumber = "14-1.001", outputName = "t14-01-001-demog",  adslFilter = "enrlfl")


file.show(paste0(res$rpth, ".rtf"))
