
library(common)
library(ggplot2)
library(reporter)

# Get program directory
pth <- dirname(Sys.path())

# Create output file name
fp <- file.path(pth, "output", reportName)

# Use sample data
dat <- data.frame(name = rownames(mtcars), mtcars)


# Intialize ards
init_ards(studyid = "abc",
          tableid = "01", adsns = c("adsl", "advs"),
          population = "safety population",
          time = "SCREENING", where = "saffl = TRUE")

# Dump ards columns
add_ards(data = dat, statvars = v(mpg, cyl),
         statdesc = v(name, name))

# Generate plot
p <- ggplot(dat, aes(x=cyl, y=mpg)) + geom_point()

# Create plot content
plt <- create_plot(p, height = 4, width = 8) |>
    titles("Figure " %p% figureNum, "MTCARS Miles per Cylinder Plot", bold = TRUE) |>
    footnotes("* Motor Trend, 1974", borders = "none")

# Add content to report
rpt <- create_report(fp, output_type = "RTF", font = "Arial", font_size = 10) |>
    page_header("Client", "Study: XYZ") |>
    set_margins(top = 1, bottom = 1) |>
    add_content(plt) |>
    page_footer("Time", "Confidential", "Page [pg] of [tpg]")

# Write report to file system
res <- write_report(rpt)

# Retrieve ards data frame
ards <- get_ards()

# Write ards to file system
saveRDS(ards, file.path(pth, "output/ards.rds"))
