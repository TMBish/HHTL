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

# Read in all data
data = dbGetQuery(db_pool, "SELECT * FROM events")

# Temp write
write_rds(data, "C:/Users/Tom Bishop/Desktop/HHTL/data/rds-snapshot.rds")
