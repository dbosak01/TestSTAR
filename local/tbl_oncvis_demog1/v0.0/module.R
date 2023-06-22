

library(oncvis)
library(common)

pth <- dirname(Sys.path())

print(dataPath)
print(adslFilter)
print(outputPath)


dataPath <- "c:/packages/Amgen/TestSTAR/local/tbl_oncvis_demog1/v0.0/data"

# Example 1

# Setup a data connection for accessing our SAS data sets
# dc1 <- oncvis::connect_to_data(data_source = "/userdata/stat/amg650/onc/20190131/analysis/asco_202101_f/statdata/adam/",
#                                type        = oncvis::dctype$sas7bdat)


dc1 <- oncvis::connect_to_data(data_source = file.path(pth, dataPath),
                               type        = oncvis::dctype$sas7bdat)

# Create a reporting object for adding Tables, Figures, and Listings
rpt1 <- oncvis::create_report(data_connection = dc1)

# Add a single TFL
rpt1 <- oncvis::add_tfl(report = rpt1,
                        tfl    = oncvis::tflname$t_disp,
                        filter = list(adsl = adslFilter)
)

# Export the report to a folder
#oncvis::export(rpt1, output_folder = "/userdata/cfda/data_science/projects/oncvis/demo/output")

oncvis::export(rpt1, output_folder = file.path(pth, outputPath))






