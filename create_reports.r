library("rmarkdown")
library("shiny")

Rmd_template <- "reagent_lot_validation.Rmd"
pdf_output <- "reagent_lot_validation.pdf"

render_document <- function(analyte,data, recommendation) {
    rmarkdown::render(Rmd_template,
                      params = list(
                          analyte = analyte,
                          data = data,
                          recommendation = recommendation))
}

## params = list(analyte = "TSH", data = "TSH_lot_validation_2017-04-05.xls",
##                 recommendation = "This reagent lot is acceptable for use")

render_query <- function() {
    rmarkdown::render("reagent_lot_validation.Rmd", params = "ask")}

rename_document <- function(analyte,data){
    date <- regmatches(data,
                       regexpr("[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}",
                               data, perl=TRUE))

    file.rename(from = pdf_output,
                to = paste0(analyte, "_Reagent_Validation_", date, ".pdf"))
}

create_report <- function(analyte,data,recommendation){
    render_document(analyte, data, recommendation)
    rename_document(analyte,data)
}

create_report(analyte = "TSH", data = "TSH_lot_validation_2017-04-05.xls",
              recommendation = "accepted")


## create_report(analyte = "N17P", data = "N17P_lot_validation_2017-05-16.xls",
##               recommendation = "accepted")

## create_report(analyte = "IRT", data = "IRT_lot_validation_2017-05-16.xls",
##                 recommendation = "accepted")
