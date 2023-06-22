library(common)
library(star)

# Parameters --------------------------------------------------------------


source("utilities/utils.R")

# Read module
mod <- read_module("./t_dm_02_001")

# Run module
res <- run_module(mod, prog_name = "t_dm_02_001",
                  data_dir = file.path(getwd(), mod$name, mod$version, "data"),
                  output_dir = file.path(getwd(), mod$name, mod$version, "output"),

                  column_labels = c("ARM A" = "Cohort 1\n0.001 mg\nQW\n(N=16)\nn(%)",
                                     "ARM B" = "Cohort 2\n0.003 mg\nQW\n(N=16)\nn(%)",
                                     "ARM C" = "Cohort 3\n0.001 mg\nQW\n(N=17)\nn(%)",
                                     "ARM D" = "Cohort 4\n0.003 mg\nQW\n(N=14)\nn(%)"),

                  block_vars = c( "SEX", "ETHNIC", "RACE",
                                  "AGE", "AGEGR1"
                                  ),
                  block_pages = c(1, 1, 1, 2, 2),

                  title_vct = c("Table 14-2.2.1.2.  Baseline Demographics", "(Safety Analysis Set)"),
                  footnote_vct = c("Data cutoff date: 07DEC2022. N=Number of subjects in the analysis set. " %p%
                                   "n=Number of subjects with observed data. " %p%
                                   "SD=Standard Deviation, Q1=First Quartile, Q3=Third Quartile." %p%
                                   "S=Step Dosing.",
                                   "Safety analysis set includes all subjects that are enrolled an recieve at least 1 dose of AMG 509."))

# List variables from returned environment
ls(res)

# View results
res$final



# View files
file.show(res$output_path)
# file.show(res$lgpth)
