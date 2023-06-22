
library(common)    # Utility functions (current path, sorting, etc.)
library(logr)      # For logging
library(fetch)     # To fetch data
library(reporter)  # For reporting
library(fmtr)      # Formatting


# Prepare Log -------------------------------------------------------------


options("logr.autolog" = TRUE,
        "logr.notes" = FALSE)


# Open log
lgpth <- log_open(prog_name)

# Assign names to pages
names(block_pages) <- block_vars


# Load and Prepare Data ---------------------------------------------------

sep("Prepare Data")

# Define data catalog
print(data_dir)
adam <- catalog(data_dir, engines$csv)
adsl <- fetch(adam$ADSL)


# Prepare data
dm_mod <- adsl[adsl$SAFFL == 'Y' & adsl$ARM %in% names(column_labels),
               c("USUBJID", "SEX", "AGE", "AGEGR1", "RACE",
                 "RACEN", "ETHNIC", "ETHNICN", "ARM")]


put("Get ARM population counts")
arm_pop <- table(dm_mod[["ARM"]], useNA = "no")


# Age Summary Block -------------------------------------------------------



if ("AGE" %in% block_vars) {

    sep("Create summary statistics for age")

    age_block <- block_cont(dm_mod, "AGE", names(column_labels), digits = 1,
                            pg = block_pages[["AGE"]]) |> put()

} else {

    age_block <- NULL
}


# Age Group Block ----------------------------------------------------------

if ("AGEGR1" %in% block_vars) {
    sep("Create frequency counts for Age Group")

    # Get sort
    dgrps <- unique(dm_mod$AGEGR1)

    put("Create age group frequency counts")
    ageg_block <- block_cat(dm_mod, "AGEGR1", names(column_labels), dgrps,
                            digits = 1, pg = block_pages[["AGEGR1"]]) |>
        put()

} else {

  ageg_block <- NULL
}


# Sex Block ---------------------------------------------------------------

if ("SEX" %in% block_vars) {
    sep("Create frequency counts for SEX")

    # Create user-defined format
    fmt_sex <- value(condition(is.na(x), "Unknown"),
                     condition(x == "M", "Male"),
                     condition(x == "F", "Female"),
                     condition(TRUE, "Other"))

    dm_mod$SEX <- fapply(dm_mod$SEX, fmt_sex)
    dgrps <- c("Male", "Female", "Other", "Unknown")

    # Create sex frequency counts
    sex_block <-  block_cat(dm_mod, "SEX", names(column_labels), dgrps,
                            digits = 1,
                            pg = block_pages[["SEX"]]) |>
        put()

} else {

  sex_block <- NULL
}

# Ethnic Block --------------------------------------------------------------

if ("ETHNIC" %in% block_vars) {
    sep("Create frequency counts for Ethnicity")

    # Create user-defined format
    fmt_ethnic <- value(condition(is.na(x), "Missing", order = 4),
                      condition(x == "HISPANIC OR LATINO",
                                "Hispanic or Latino", order = 1),
                      condition(x == "NOT HISPANIC OR LATINO",
                                "Not Hispanic or Latino", order = 2),
                      condition(TRUE, "Unknown", order = 3))

    dm_mod$ETHNIC <- fapply(dm_mod$ETHNIC, fmt_ethnic)
    dgrps <- labels(fmt_ethnic)

    # Create sex frequency counts
    ethnic_block <-  block_cat(dm_mod, "ETHNIC", names(column_labels), dgrps,
                               digits = 1,
                               pg = block_pages[["ETHNIC"]]) |>
        put()

} else {

    ethnic_block <- NULL
}



# Race Block --------------------------------------------------------------

if ("RACE" %in% block_vars) {
    sep("Create frequency counts for RACE")

    # Create user-defined format
    fmt_race <- value(condition(is.na(x), "Unknown", order = 7),
                      condition(x == "AMERICAN INDIAN OR ALASKA NATIVE",
                                "American Indian or Alaska Native", order = 1),
                      condition(x == "ASIAN", "Asian", order = 2),
                      condition(x == "BLACK OR AFRICAN AMERICAN",
                                "Black (or African American)", order = 3),
                      condition(x == "NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER",
                                "Native Hawaiian or Other Pacific Islander",
                                order = 4),
                      condition(x == "WHITE", "White", order = 5),
                      condition(TRUE, "Other", order = 6))

    dm_mod$RACE <- fapply(dm_mod$RACE, fmt_race)
    dgrps <- labels(fmt_race)

    # Create sex frequency counts
    race_block <-  block_cat(dm_mod, "RACE", names(column_labels), dgrps,
                             digits = 1,
                             pg = block_pages[["RACE"]]) |>
        put()

} else {

    race_block <- NULL
}




# Combine Final Dataset ---------------------------------------------------

sep("Final data frame")

put("Combine blocks into final data frame")
final <- rbind(sex_block, ethnic_block, race_block, age_block, ageg_block) |>
    sort(by = "page") |> put()

# Report ------------------------------------------------------------------


sep("Create and print report")

var_fmt <- c("AGE" = "Age (years)", "AGEGR1" = "Age Group - n(%)",
             "RACE" = "Race - n(%)",
             "SEX" = "Sex - n(%)", "ETHNIC" = "Ethnicity - n(%)")

# Create Table
tbl <- create_table(final, first_row_blank = TRUE,
                    borders = "outside") |>
    titles(title_vct, bold = TRUE, font_size = 11) |>
    footnotes("Page [pg] of [tpg]", align = "right", blank_row = "none") |>
    footnotes(footnote_vct, blank_row = "none") |>
    column_defaults(align = "center", width = 1) |>
    stub(vars = c("var", "label"), "", width = 2.5) |>
    define(var, blank_after = TRUE, dedupe = TRUE, label = "",
           format = var_fmt,label_row = TRUE) |>
    define(label, indent = .25, label = "") |>
    define(page, visible = FALSE, page_break = TRUE)

    # Add treatment groups
    for (nm in names(column_labels)) {

        tbl <- define(tbl, var = nm, label = column_labels[[nm]],
                      standard_eval = TRUE)
    }


pth <- file.path(output_dir, prog_name)

rpt <- create_report(pth, output_type = "RTF", font = "Arial") |>
    set_margins(top = 1, bottom = 1) |>
    add_content(tbl)

res <- write_report(rpt)

output_path <- res$modified_path


# Clean Up ----------------------------------------------------------------


# Close log
log_close()


