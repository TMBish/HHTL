library(shiny)
library(shinyjs)
library(shiny.semantic)
library(shinyWidgets)
library(timevis)
library(V8)
library(googlesheets)
library(dplyr)
library(glue)
library(lubridate)

jsCode <- "

shinyjs.init = function() {
Shiny.onInputChange('TL_selection', '')
};

shinyjs.find_ev = function(){

var sel_title = $('#timeline').find('.vis-selected').text()

Shiny.onInputChange('TL_selection', sel_title)

}"

hhtl_key <- extract_key_from_url("https://docs.google.com/spreadsheets/d/1ixqO2ZubVrb2-zV1gUSDWA0SmajvhZUitfv9LBPD4jc/edit?usp=sharing")

hhtl_obj <- hhtl_key %>%
  gs_key()

# Assumes an oauth .rds file is in the working directory
# Manually copied over to the EC2 instance using putty
gs_auth(token = "gsheets_auth.rds")

hide_loading = function(){
  Sys.sleep(4)
  shinyjs::hide("loading_page")
}

# Load extra scripts
source("create_card.R")
source("utils.R")