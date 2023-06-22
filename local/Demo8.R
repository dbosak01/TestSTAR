# ***********************************************************************
# Demo8: Commands to create a batch.
# ***********************************************************************


# Install star package
install.packages("C:/packages/star_0.0.9001.tar.gz", repos = NULL, type = 'source')

# Load library
library(star)


# Define program list
lst <- list(program_parms("lst_proto", "v0.3", list(listingNum = "1.2")),
            program_parms("tbl_demog_proto", "v0.3", list(tableNum = "2.4")),
            program_parms("fig_proto", "v0.1", list(figureNum = "3.8")))

# Identify study directory
loc <- "c:/packages/Amgen/TestSTAR/study"

# Create batch program
res <- create_batch(lst, loc)

# Run batch
source(file.path(loc, "run_all.R"))
