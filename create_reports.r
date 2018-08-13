library("rmarkdown")
library("shiny")
options(browser = "/usr/bin/firefox")
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

## Document names string must be: ANALYTE_lot_validation_Lot#XXXXXXXXX.xls 
rename_document <- function(analyte,data){
    ## date <- regmatches(data,
    ##                    regexpr("[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}",
    ##                            data, perl=TRUE))
    
    lot <- regmatches(data,
                       regexpr("[[:digit:]]{6}", data, perl=TRUE))
    
    file.rename(from = pdf_output,
                to = paste0("../reports/",analyte, "_Reagent_Validation_", lot,"_", Sys.Date(), ".pdf"))
}

create_report <- function(analyte = NA ,data = NA ,recommendation = NA, gui = TRUE){
    if (gui == TRUE) {
        render_query()
    } else {
        render_document(analyte, data, recommendation)
    }
    rename_document(analyte,data)
}

create_report(analyte = "N17P", data = "17OHP New Kit Lot Validation Worksheet Lot#656884.xls",
              recommendation = "accepted")
create_report(analyte = "TSH", data = "TSH New Kit Lot Validation Worksheet Lot#657128.xls",
              recommendation = "accepted")
create_report(analyte = "IRT", data = "./data/IRT New Lot Validation Lot#657259.xls",
              recommendation = "accepted")

create_report(analyte = "N17P", data = "./data/17OHP New Kit Lot Validation Lot#662927.xls",
              recommendation = "accepted")

create_report(analyte = "IRT", data = "./data/IRT New Kit Lot Validation Lot#662097.xls",
              recommendation = "accepted")

create_report(analyte = "TSH", data = "./data/TSH New Kit Lot Validation Lot#662601.xls",
              recommendation = "accepted")

## params <- list(analyte = "N17P", data = "17OHP New Kit Lot Validation Worksheet Lot#656884.xls",
##               recommendation = "accepted")

## create_report(analyte = "N17P", data = "N17P_lot_validation_2017-05-16.xls",
##               recommendation = "accepted")

## create_report(analyte = "IRT", data = "IRT_lot_validation_2017-05-16.xls",
##                 recommendation = "accepted")

create_report(gui=TRUE)
create_report(analyte = "IRT", data = "../data/IRT New Lot Validation Lot#662761.xls",
              recommendation = "accepted", gui = FALSE)
