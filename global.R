if (!("pacman" %in% installed.packages())) install.packages('pacman')
library(pacman)

# Packages --------------------------------------------------------------


p_load(
  tidyverse, lubridate, glue, stringr, furrr,
  V8, timevis, shiny.semantic, shiny, googleCloudStorageR, shinyWidgets, shinyjs, here
)


# Options  --------------------------------------------------------------------

# Secret code
source("data/secrets.R")

# Cheeky javascript
jsCode <- "

shinyjs.init = function() {
Shiny.onInputChange('TL_selection', '')
};

shinyjs.find_ev = function(){

var sel_title = $('#timeline').find('.vis-selected').text()

Shiny.onInputChange('TL_selection', sel_title)

}"


# Load extra scripts
source("create_card.R")
source("utils.R")

# Data --------------------------------------------------------------------

# Connect and auth gcp
Sys.setenv("GCS_AUTH_FILE" = paste0(here(), "/data/tmbish-8998f7559de5.json"))
options(googleAuthR.scopes.selected = "https://www.googleapis.com/auth/devstorage.full_control")
gcs_auth()

# Read data
data_path = "hhtl-events-data.csv"

# Write locally
gcs_get_object(
  object_name = data_path,
  bucket = "hhtl",
  saveToDisk = "data/temp.csv",
  overwrite = TRUE
)

# Read in
data = read_csv("data/temp.csv")

# Remove local
file.remove("data/temp.csv")


hide_loading = function(){
  Sys.sleep(1)
  shinyjs::hide("loading_page")
}