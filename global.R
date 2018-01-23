library(shiny)
library(shinyjs)
library(shiny.semantic)
library(shinyWidgets)
library(timevis)
library(V8)
library(dplyr)
library(glue)
library(lubridate)
library(readr)
library(pool)
library(RPostgreSQL)
library(keyring)

jsCode <- "

shinyjs.init = function() {
Shiny.onInputChange('TL_selection', '')
};

shinyjs.find_ev = function(){

var sel_title = $('#timeline').find('.vis-selected').text()

Shiny.onInputChange('TL_selection', sel_title)

}"

# Connect to database
db <- 'hhtl'
host <- 'hhtl.ctysajtozyfu.us-west-2.rds.amazonaws.com' 
port <- 5432
username <- key_list("hhtl")$username
password <- key_get(service = "hhtl", username = "hhtl")

db_pool <- dbPool(
  drv = dbDriver("PostgreSQL"),
  dbname = db,
  host = host,
  port = port,
  user = username,
  password = password
)

# Read in csv
data = dbGetQuery(db_pool, "SELECT * FROM events")

hide_loading = function(){
  Sys.sleep(1)
  shinyjs::hide("loading_page")
}

# Load extra scripts
source("create_card.R")
source("utils.R")