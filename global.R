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

hhtl_link <- "https://docs.google.com/spreadsheets/d/1ixqO2ZubVrb2-zV1gUSDWA0SmajvhZUitfv9LBPD4jc/edit?usp=sharing"

hhtl_obj <- hhtl_link %>%
  gs_url()

hide_loading = function(){
  Sys.sleep(4)
  shinyjs::hide("loading_page")
}

# Load extra scripts
source("create_card.R")
source("utils.R")